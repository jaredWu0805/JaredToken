
def test_second(jet, accounts):
    assert jet.balanceOf(accounts[0]) == 1000
