// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.5.10;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/studentList.sol";

contract TestStudentList{

  StudentList student = StudentList(DeployedAddresses.StudentList());

  address matricolaDiTest = address(12345);
  string nome = "ciro"; 
  string cognome = "malafronte";

	function testInsert() public {
		//student.setAsOwner();
		student.addStudent(nome, cognome, matricolaDiTest);
		(string memory n, string memory s, address m) = student.getStudent(matricolaDiTest);
		Assert.equal(n, nome, "i nomi sono uguali");
		Assert.equal(s, cognome, "i cognomi sono uguali");
		Assert.equal(m, matricolaDiTest, "le matricoli sono uguali");
	}
	
	function testIsExist() public {
		Assert.isTrue(student.existStudent(matricolaDiTest), "ciao");
	}
}
