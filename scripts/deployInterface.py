from brownie import Test, Main, accounts

def main():
    t = Test.deploy(10, 85, {'from': accounts[0]})
    m = Main.deploy({'from': accounts[0]})

    print(m.getTestSecret(t.address))
    print(m.getNumber(t.address))
    print(m.setTestNumber(t.address, 11))
    print(m.getNumber(t.address))

    return
