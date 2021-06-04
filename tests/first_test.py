import pytest
import brownie

def test_transfer(jet, accounts):
    jet.transfer(accounts[1], 100, {'from': accounts[0]})
    assert jet.balanceOf(accounts[1]) == 100


def test_balances(jet, accounts):
    assert jet.balanceOf(accounts[0]) == 1000
    assert jet.balanceOf(accounts[1]) == 0


@pytest.mark.parametrize('amount', [1, 2, 100])
def test_transfer_revert(jet, accounts, amount):
    with brownie.reverts():
        assert jet.transfer(accounts[1], amount, {'from': accounts[2]})


def test_revert_msg(jet):
    with brownie.reverts('dev: is three'):
        assert jet.revertExamples(3)
