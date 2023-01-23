// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.5.10;
import "./studentList.sol";

contract ExamList{
    constructor() public{
        owner = msg.sender;
        s = StudentList(address(this));
    }

    address public owner;
    StudentList s;
    struct Exam{
        string name;
        address examId;
        uint mark;
        address studentId;
    }

    mapping (address => Exam) exams;

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }

     modifier onlyIfStudentExist(address matricola){
        
        require (s.existStudent(matricola) == true, "lo studente non esiste");
        _;
    }
    //TODORIMUOVERE
    function setStudentList(StudentList l) public {
    	s = l;
    }	

    //TODO cambiare require
    function addExam(string memory name, address examId, uint mark, address studentId) public onlyIfStudentExist(studentId) returns (bool) {
        exams[examId] = Exam(name,examId, mark, studentId);
        return true;
    }

}
