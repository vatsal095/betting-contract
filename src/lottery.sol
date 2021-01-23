pragma solidity 0.7.0;

contract Batting {
    address payable public manager;
    address payable [] public players; 
    
    constructor () {
        manager = msg.sender;
    }
    function enter() public payable AllIn{
    
        require(msg.value == 10 ether); //condition
        players.push(msg.sender);
        
    }
    
    function random() private view returns(uint) {
        return uint(keccak256(abi.encodePacked(block.timestamp,block.difficulty,msg.sender)));
    }
    
    
    function pickWinner() public restricted {
        msg.sender.transfer(address(this).balance/100);
        
        uint index = random() % players.length;
        players[index].transfer((address(this).balance * 2 )/ 3);
        index = random() % players.length;
        players[index].transfer(address(this).balance /3);
    }
    
    
    modifier restricted() {
        require(msg.sender == manager); 
        _;
    }
    modifier AllIn{
    	require(players.length < 3);
    	_;
    }
 }