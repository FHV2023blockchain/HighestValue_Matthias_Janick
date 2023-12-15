// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract FoxEnd {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function withdrawFees() public {
        require(msg.sender == owner, "Only the owner can withdraw fees");
        payable(owner).transfer(address(this).balance);
    }

    string public name;
    uint public value;

    struct Player {
        address payable addr;
        string pName;
        uint pValue;
    }
    struct Winner {
        string pName;
        uint pValue;
    }

    uint256 public highestValue;
    uint256 public lowestValue = 100;
    Player[] public players;
    Winner[] public winners;

    function join(string memory pName, uint pValue) external payable {
        require(
            msg.value > 0.01 ether && msg.value < 1.05 ether,
            "Invalid ether amount"
        );
        require(!isPlayerJoined(msg.sender));

        if (pValue >= highestValue) {
            highestValue = pValue;

            if (players.length != 0 || winners.length > 1) {
                winners.pop();
            } else if (winners.length > 0) {
                if (pValue == winners[0].pValue) {
                    delete winners;
                }
            }
            Winner memory newWinner = Winner({pName: pName, pValue: pValue});
            winners.push(newWinner);
        }

        Player memory newPlayer = Player({
            addr: payable(msg.sender),
            pName: pName,
            pValue: pValue
        });

        players.push(newPlayer);
    }

    function getPlayers() public view returns (Player[] memory) {
        return players;
    }

    function getWinner() public view returns (Winner[] memory) {
        require(players.length >= 2);
        return winners;
    }

    function newGame() public {
        delete players;
        delete winners;
        highestValue = 0;
        lowestValue = 100;
    }

    function isPlayerJoined(address _addr) internal view returns (bool) {
        for (uint256 i = 0; i < players.length; i++) {
            if (players[i].addr == _addr) {
                return true;
            }
        }
        return false;
    }
}

// const abi = require("./build/contracts/FoxEnd.json");
// var join_instance = new web3.eth.Contract(abi['abi'],"0x301287848FEB0C744B4cCF2449a06f6C4984C295")
// join_instance.methods.join('Matthias', 1).send({from: '0xcDfafd5f231a44122FAaf2AeE5ed4e5E418D0805',value: web3.utils.toWei("0.02")})
// join_instance.methods.getPlayers().call()
// join_instance.methods.contractBalance().call()

// join_instance.methods.sayMessage().call()
// 0xcDfafd5f231a44122FAaf2AeE5ed4e5E418D0805   --> MM
// 0x83F55615168277a689B5963142c675533A974089   --> MM
// wss://sepolia.infura.io/v3/4ac1f63261eb4847a8862944348d3272    --> sepolia key

// 4ac1f63261eb4847a8862944348d3272
//

// const abi = require("./build/contracts/FoxEnd.json");
// var join_instance = new web3.eth.Contract(abi['abi'],"0x56Bc169486585CeC40136E62E7917D362FD3819a")
// join_instance.methods.join('Matthias', 1).send({from: '0xcDfafd5f231a44122FAaf2AeE5ed4e5E418D0805',value: web3.utils.toWei("0.01")})
// join_instance.methods.getPlayers().call()
// join_instance.methods.contractBalance().call()
//0xEb5655Ad63832018795570EB8359f419e8247F95
