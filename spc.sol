pragma solidity ^0.5.1;

contract rpc_game{
    address creator;
    address public  player1;
    address public  palyer2;
    uint256 public stake; // in weis
    bool public turn1done;
    bool public turn2done;

    enum resultenum {winfirst, winsecond, nowin }

    enum turnenum {scissors, paper, rock}
    
    turnenum private  turn1value; 
    turnenum private  turn2value; 
    
    constructor () public {
            creator = msg.sender;


    }



    function Play()  public returns (resultenum win){
                    
           require(turn2done == true);
            resultenum result = resultenum.nowin;
            
            
            result = countresult(turn1value,turn2value);
            
            return result;

   }


     // internal result determining
    function countresult(turnenum turn1, turnenum turn2) private returns (resultenum result){
   
    result = resultenum.nowin; 
    if (turn1 == turn2)
        { return result; }
    if ((turn1 == turnenum.scissors && turn2 ==turnenum.paper) || (turn1 == turnenum.paper && turn2 == turnenum.rock) || (turn1 == turnenum.rock && turn2 == turnenum.scissors )) {
            result = resultenum.winfirst;
            return result;    
    }else{
       result = resultenum.winsecond;
       return result;
    }
    
    }    
    
    function setStake(uint256 value) public {
        require (msg.sender == creator);
        stake = value;
    }
        
        
    
    
    function MakeTurn(turnenum turn) public {
        require (stake > 0);
        if (turn1done == false) {
            player1 = msg.sender;
            turn1done = true;
            turn1value = turn;
            return;   
        }
        
    }
    
    
    
}