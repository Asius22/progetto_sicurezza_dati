// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/AccessControl.sol";

contract StudentList is AccessControl{
    bytes32 private constant RETTORE_ROLE = keccak256("RETTORE_ROLE");

    constructor() public{
        _grantRole(RETTORE_ROLE, msg.sender);
    }


    struct student{
        string name;
        string surname;
        string matricola;
        bool isExist;
    }

    mapping (string => student) students;

    modifier onlyOwner(){
        require(hasRole(RETTORE_ROLE, msg.sender), "non hai il permesso di eseguire questa istruzione");
        _;
    }

    //TODO cambiare require
    function addStudent(string memory name, string memory surname, string memory matricola) public onlyOwner{
        require (students[matricola].isExist == false, "esiste gia uno studente con questa matricola");
        students[matricola] = student(name, surname, matricola, true);

    }

    function getStudent(string calldata matricola) external view returns(string memory, string memory, string memory ){
        require (students[matricola].isExist == true, "lo studente con la matricola specificata non esiste");
        student storage s = students[matricola];
        return (s.name, s.surname,s.matricola);
    }

    function existStudent(string calldata matricola) external view returns(bool) {
    	return students[matricola].isExist;
    }

    function setNewRector(address newRector) public payable onlyOwner{
        require(hasRole(RETTORE_ROLE, newRector) == false, "l'indirizzo passato gia' e' un rettore");
        _grantRole(RETTORE_ROLE, newRector);
    }


}
