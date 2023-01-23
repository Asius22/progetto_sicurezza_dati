var exam = artifacts.require("ExamList");
var student = artifacts.require("StudentList");
module.exports = function(deployer) {
	deployer.deploy(exam);	
	deployer.deploy(student);
};
