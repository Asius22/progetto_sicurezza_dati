// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;
import "./studentList.sol";

import "@openzeppelin/contracts/access/AccessControl.sol";


contract ExamList is AccessControl{

    bytes32 private constant PROF_ROLE = keccak256("PROF_ROLE");

    constructor() public{
        owner = msg.sender;
        _grantRole(PROF_ROLE, msg.sender);
        profs[msg.sender] = true;
    }

    mapping(address => bool) private profs;

    address private owner;
    StudentList private s;
    struct Exam{
        string name;
        string examId;
        uint mark;
        string studentId;
        bool exist;
    }

    mapping (string => Exam) exams;

    modifier onlyProfs(){
        require(hasRole(PROF_ROLE, msg.sender),"non hai il permesso di eseguire quest'azione");
        _;
    }

    function setStudentList(address a) public {
        s = StudentList(a);
    }

    function onlyIfStudentExist(string memory matricola) public view {
        require (s.existStudent(matricola) == true, "lo studente non esiste");
    }

    function addExam(string memory name, string memory examId, uint mark, string memory studentId) public onlyProfs {
        onlyIfStudentExist(studentId);
        require (exams[examId].exist == false, "Esiste gia' un esame con questo identificativo");
        exams[examId] = Exam(name,examId, mark, studentId, true);
    }

    function getExam(string memory examId) public view returns(string memory, string memory, uint ){
        require(exams[examId].exist == true);
        Exam storage e = exams[examId];
        return (e.name, e.studentId, e.mark);
    }

    function setProf() public payable {
        //TODO add value control
        _grantRole(PROF_ROLE, msg.sender);
        profs[msg.sender] = true;
    }

}
