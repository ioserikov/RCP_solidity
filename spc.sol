

pragma solidity ^0.5.10;

contract rpc_game{
   
    // types

    enum resultenum {
        winfirst,  // 0
        winsecond, // 1 
        nowin     // 2
    }


    enum turnenum {
        scissors, // 0
        paper,    //1
        rock     //2 
    }


    // global vars - PUBLIC

    address payable creator;
    address payable public  player1;
    address payable public  player2;
    uint256 public stake; // in weis
    bool public turn1done;
    bool public turn2done;
    resultenum public Result;
    

    //global vars - private

      
    turnenum private  turn1value; 
    turnenum private  turn2value; 
    
    


    constructor () public {
            creator = msg.sender;

    }


    event StakesDone(address add1, address add2, uint stake);
    event Played(address add1, address add2, resultenum result);


    function Play()  public returns (resultenum win){
                    
           require(turn2done == true);
           resultenum result = resultenum.nowin;
            
            
           Result = countresult(turn1value,turn2value);
           emit Played(player1, player2, result);
           
           return Result;
            
   }
   
   
   function Clear() public { 
       
       creator.transfer(address(this).balance /  10);
       
       if (Result == resultenum.nowin){
           
         player1.transfer(address(this).balance / 2); 
         player2.transfer(address(this).balance / 2); 
         
           
       }
       // prize to winner
       address payable winner;
       
       
       winner = player1;
       if (Result == resultenum.winsecond) {
            winner = player2;
       }
       
       winner.transfer(address(this).balance);
       
       return;
   }


     // internal result determining
    function countresult(turnenum turn1, turnenum turn2) private returns (resultenum result){
   
        result = resultenum.nowin; 
        if (turn1 == turn2)
            { return result;
        }
        
        if ((turn1 == turnenum.scissors && turn2 ==turnenum.paper) || (turn1 == turnenum.paper && turn2 == turnenum.rock) || (turn1 == turnenum.rock && turn2 == turnenum.scissors )) {
            result = resultenum.winfirst;
            return result;    
        }
        else
        {
            result = resultenum.winsecond;
            return result;
        }
    
    }  
    
    
    
        
        
    
    
    function MakeTurn(turnenum turn) public payable { //Stake for every address
        require (stake > 0 && turn1done == false);
        
        if (turn1done == false) {
            player1 = msg.sender;
            turn1done = true;
            turn1value = turn;
            stake = msg.value;
            return;   
        } else {
            require (msg.sender != player1  &&   msg.value==stake);
            
            player2  = msg.sender;
            turn2done = true;
            
            emit StakesDone(player1, player2, stake);
        }
        
        
        
    }
    
    
    
}