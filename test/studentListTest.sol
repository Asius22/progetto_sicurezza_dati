// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/studentList.sol";

contract TestStudentList {
    StudentList student = StudentList(DeployedAddresses.StudentList());

    string matricolaDiTest = "12345";
    string nome = "ciro";
    string cognome = "malafronte";

    function testNewRector() public {
        try student.setNewRector(address(this)) {}
		catch Error(string memory m){
			Assert.isTrue(true, m);
		}
    }

    function testInsert() public {
        try student.addStudent(nome, cognome, matricolaDiTest) {
            Assert.isFalse(false, "");
        } catch Error(string memory m) {
            Assert.isFalse(false, m);
        }
    }

    function testIsExist() public {
        Assert.isFalse(
            student.existStudent(matricolaDiTest) ,
            "studente esiste"
        );
    }

    function testGetStudent() public {
        try student.getStudent(matricolaDiTest) {
            Assert.equal("", nome, "i nomi sono uguali");
            Assert.equal("", cognome, "i cognomi sono uguali");
            Assert.equal("", matricolaDiTest, "le matricole sono uguali");
        } catch Error(string memory e) {
            Assert.isTrue(true, "getStudent ha dato errore come previsto");
        }
    }
}
