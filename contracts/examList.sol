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
        //require(profs[msg.sender], "Colui che sta provando ad inserire l'esame non e' un prof");
        hasRole(PROF_ROLE, msg.sender);
        _;
    }

    function setStudentList(address a) public {
        s = StudentList(a);
    }

    modifier onlyIfStudentExist(string memory matricola) {
        require (s.existStudent(matricola) == true, "lo studente non esiste");
       _;
    }

    function addExam(string memory name, string memory examId, uint mark, string memory studentId) public onlyProfs onlyIfStudentExist(studentId){
        require (exams[examId].exist == false, "Esiste gia' un esame con questo dientificativo");
        exams[examId] = Exam(name,examId, mark, studentId, true);
    }

    function getExam(string memory examId) public returns(string memory, string memory, uint ){
        require(exams[examId].exist = true);
        Exam storage e = exams[examId];
        (string memory examName, string memory studentId, uint mark ) = (e.name, e.studentId, e.mark);
        return (e.name, e.studentId, e.mark);
    }

    function setProf() public payable {
        //TODO add value control
        _grantRole(PROF_ROLE, msg.sender);
        profs[msg.sender] = true;
    }

}
