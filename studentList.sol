// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.10;

contract StudentList{
    constructor() {
        owner = msg.sender;
    }

    address public owner;
    struct Student{
        string name;
        string surname;
        address matricola;
        bool isExist;
    }

    mapping (address => Student) students;


    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }

    //TODO cambiare require
    function addStudent(string memory name, string memory surname, address matricola) public onlyOwner returns (uint) {
        require (students[matricola].isExist == false, "esiste gia uno studente con questa matricola");
        students[matricola] = Student(name, surname, matricola, true);
        return 1;
    }

    function getStudent(address matricola) public view returns(Student memory){
        require (students[matricola].isExist == true, "lo studente con la matricola specificata non esiste");
        return students[matricola];
    }

}