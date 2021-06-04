from brownie import JaredToken, accounts

def main():
    return JaredToken.deploy("Jared Token", "JET", 18, 1e18, {'from': accounts[0]})
