
import pytest


@pytest.fixture(scope="module")
def jet(JaredToken, accounts):
    print('token mint')
    return JaredToken.deploy("Jared Token", "jet", 18, 1000, {'from': accounts[0]})


@pytest.fixture(scope="function", autouse=True)
def isolation(fn_isolation):
    pass
