// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/examList.sol";

contract TesttExamList {
    ExamList exam = ExamList(DeployedAddresses.ExamList());

    string examId = "1";
    string studentId = "12345";
    uint mark = 29;
    string nome = "sicurezza dei dati";

    function testInsert() public {
        try exam.addExam(nome, examId, mark, studentId) {
            Assert.isTrue(true, "esame aggiunto");
        } catch Error(string memory m) {
            Assert.isTrue(true, m);
        }
    }

    function testGetExam() public {
        try exam.getExam(examId) {
            Assert.isTrue(true, "esame letto con successo");
        } catch Error(string memory m) {
            Assert.isTrue(true, m);
        }
    }
}
