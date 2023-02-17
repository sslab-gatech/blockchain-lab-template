from os import fpathconf
from scripts.pwn import *

def init_instance(organizer, player):
    factory = ChallengeNameFactory.deploy({"from": organizer.address})

    tx = factory.createInstance(player.address, {"from": organizer.address})
    return (factory, ChallengeName.at(tx.return_value))

def deploy(player, organizer):
    (factory, instance) = init_instance(organizer, player)

    print("player  : %s" % player)
    print("factory : %s" % factory)
    print("instance: %s" % instance)

    return (player, factory, instance)

def main():
    player = a[0]
    organizer = a[1]

    (player, factory, instance) = deploy(player, organizer)

    accounts.default = player
    assert instance.completed() == False

