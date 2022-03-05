// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
 
/**
 * @title SafeMath
 * @dev Unsigned math operations with safety checks that revert on error
 */
 
library SafeMath {
    /**
     * @dev Multiplies two unsigned integers, reverts on overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
        if (a == 0) {
            return 0;
        }
 
        uint256 c = a * b;
        require(c / a == b);
 
        return c;
    }
 
    /**
     * @dev Integer division of two unsigned integers truncating the quotient, reverts on division by zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold
 
        return c;
    }
 
    /**
     * @dev Subtracts two unsigned integers, reverts on overflow (i.e. if subtrahend is greater than minuend).
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a);
        uint256 c = a - b;
 
        return c;
    }
 
    /**
     * @dev Adds two unsigned integers, reverts on overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a);
 
        return c;
    }
 
    /**
     * @dev Divides two unsigned integers and returns the remainder (unsigned integer modulo),
     * reverts when dividing by zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0);
        return a % b;
    }
}

contract Score {

    using SafeMath for uint256;
    address public owner;
    uint public newscore ;
    modifier onlyowner(){
    	require(msg.sender == owner,"only teacher can call this function");
    	_;
	}
    mapping(address => uint) public Studentscore;
    constructor() public{
        owner = msg.sender;
	}

    function Addstudent(address _studenid,uint _score) public onlyowner{
        require(_studenid != address(0x0),"studnet address Cannot be empty");
        assert(_score < 100);
        Studentscore[_studenid]=_score;
    }

    function Addscore(address _studenid,uint iscore) external onlyowner{
        assert(iscore < 100);
        Studentscore[_studenid]+=iscore;
        newscore = Studentscore[_studenid];
        assert(newscore < 100);
       
    }

    function Subscore(address _studenid,uint iscore) external onlyowner{
        assert(iscore < 100);  
        Studentscore[_studenid]-=iscore;
        newscore = Studentscore[_studenid];     
        assert(newscore < 100);

    }

    function Add() external onlyowner{
        Studentscore[msg.sender]+=1;
        newscore = Studentscore[msg.sender];
        assert(newscore < 100);
     
    }

}



interface IScore {
    function Add() external;
    function Subscore() external;
}



contract Teacher {
    function incrementCounter(address _score)external {
        IScore(_score).Add();
        
    }

   // function subscoreTeacher(address _score,uint iscore) external {
        //return IScore(_score).Subscore();
    //}
}
