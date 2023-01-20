// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.10;
import "./studentList.sol";

contract ExamList{
    constructor() {
        owner = msg.sender; 
    }

    address public owner;
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
        require (StudentList().getStudent(matricola).isExist == true);
        _;
    }

    //TODO cambiare require
    function addExam(string memory name, address examId, uint mark, address studentId) public onlyOwner onlyIfStudentExist(studentId) returns (uint) {
        exams[examId] = Exam(name,examId, mark, studentId);
        return 1;
    }

 

}