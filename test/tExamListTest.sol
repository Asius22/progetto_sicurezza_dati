// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.5.10;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/examList.sol";

contract TesttExamList{

  ExamList exam = ExamList(DeployedAddresses.ExamList());

  address examId = address(1);
  address studentId = address(12345);
  uint mark = 29; 
  string nome = "sicurezza dei dati";

	function testInsert() public {
		StudentList s = StudentList(DeployedAddresses.StudentList());
		s.addStudent("ciro", "malafronte", studentId);
		exam.setStudentList(s);
		Assert.isTrue(s.existStudent(studentId), "lo studente non esiste");
		bool res = exam.addExam(nome, examId, mark, studentId);
		Assert.isTrue(res, "esame aggiunto");
	}
}
