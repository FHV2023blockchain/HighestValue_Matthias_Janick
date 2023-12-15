There are two functions:
1. getPlayer(): Shall return a list of participants that have joined so far. 
2. join(): Player can enter his name and an integer between 1 and 20. The player with the highest number wins.
3. getWinner(): shows the person who has won. only usable by me:)
Further conditions:
- At least 2 participants per round
- The one with the highest value.



Contract Address: 0x301287848FEB0C744B4cCF2449a06f6C4984C295 


how to youse 

Commands:

truffle console --network sepolia
const abi = require("./build/contracts/FoxEnd.json");
var join_instance = new web3.eth.Contract(abi['abi'],"CONTRACT ADDRESS")
join_instance.methods.join('NAME', number).send({from: 'YOUR ADDRESS',value: web3.utils.toWei("0.02")})
join_instance.methods.getPlayers().call()