import pytest
from brownie import JaredToken, TokenSwap, accounts


@pytest.fixture(scope="function", autouse=True)
def isolation(fn_isolation):
    pass


@pytest.fixture(scope="module")
def setup(TokenSwap, accounts):
    token1 = JaredToken.deploy("Token1", "TK1", 18, 1000, {'from': accounts[0]})
    token2 = JaredToken.deploy("Token2", "TK2", 18, 10000, {'from': accounts[1]})
    tokenSwap = TokenSwap.deploy(
        token1.address, token2.address, accounts[0], accounts[1], 10, 100, {'from': accounts[2]}
    )

    return (token1, token2, tokenSwap)


def test_initial_state(setup, accounts):
    [token1, token2, tokenSwap] = setup

    assert tokenSwap.token1() == token1
    assert tokenSwap.token2() == token2
    assert tokenSwap.owner1() == accounts[0]
    assert tokenSwap.owner2() == accounts[1]
    assert tokenSwap.owner1Amount() == 10
    assert tokenSwap.owner2Amount() == 100


def test_set_allowance_and_token_swap(setup, accounts):
    [token1, token2, tokenSwap] = setup
    token1.approve(tokenSwap, 100, {'from': accounts[0]})
    token2.approve(tokenSwap, 100, {'from': accounts[1]})

    assert token1.allowance(accounts[0], tokenSwap) == 100
    assert token2.allowance(accounts[1], tokenSwap) == 100

    tokenSwap.swap({'from': accounts[0]})

    assert token1.balanceOf(accounts[1]) == 10
    assert token2.balanceOf(accounts[0]) == 100
