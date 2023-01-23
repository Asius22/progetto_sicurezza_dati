// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.5.10;

contract StudentList{
    constructor() public{
        owner = msg.sender;
    }

    address public owner;

    struct student{
        string name;
        string surname;
        address matricola;
        bool isExist;
    }

    mapping (address => student) students;

    modifier onlyOwner(){
        require(msg.sender == owner, "solo l'owner può aggiungere studenti");
        _;
    }
    
    //TODO cambiare require
    function addStudent(string memory name, string memory surname, address matricola) public {
        require (students[matricola].isExist == false, "esiste gia uno studente con questa matricola");
        students[matricola] = student(name, surname, matricola, true);

    }

    function getStudent(address matricola) public view returns(string memory, string memory, address ){
        require (students[matricola].isExist == true, "lo studente con la matricola specificata non esiste");
        student storage s = students[matricola];
        return (s.name, s.surname,s.matricola);
    }
    
    function existStudent(address matricola) public view returns(bool) {
    	return students[matricola].isExist;
    }	

}
