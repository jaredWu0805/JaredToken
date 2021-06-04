from brownie import accounts, ReceiveEther, SendEther

def main():
    rcv = ReceiveEther.deploy({'from': accounts[0]})
    snd = SendEther.deploy({'from': accounts[0]})

    # tx = snd.sendViaTranfer(rcv.address, {'from': accounts[0], 'value': 1000, 'gas': 1000000})
    # print(tx.events)
    # tx = snd.sendViaSend(rcv.address, {'from': accounts[0], 'value': 1000, 'gas': 1000000})
    # print(tx.events)
    tx = snd.sendViaCall(rcv.address, {'from': accounts[0], 'value': 1000, 'gas': 1000000})
    print(tx.events)

    print(rcv.getBalance({'from': accounts[0]}))

    return
