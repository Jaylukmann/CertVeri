pragma solidity ^0.6.1;

contract BloceducareCerts{
    
	//global variable
	address private admin;

	struct Certificate{
	address participantAddress;
	string name;
	string award;
	string project;
	uint   grade;
	uint   dateCreated;
	uint   dateIssued;
	}

	string[] certificateList;
	//mapping
	mapping(address => Certificate) public certificates;
	mapping(string => 	mapping(address => Certificate)) public byName;
	mapping(string => bool) private isParticipant;

	//events
	event certRemoved(string _msg,address _participantAddress,string _msg2,string at,uint time);
	event certCreated(string _msg,string _name,string _with, address participant, string by,address creator,uint time);
	event cerVerified(string _msg, address addressVerified);
	event Participant(address addressVerified,string _msg);
	//modifier
	modifier onlyAdmin(){
		require(msg.sender == admin, "Accessible by only Admin");
	_;
	}
	constructor() public{
		admin = msg.sender;
	}
	//Allows Admin to create certificates
	function createCertificate(address __participantAddress,
	string memory __name, string memory __award,
	string memory __project,uint __grade) public onlyAdmin {
	certificates[__participantAddress] = Certificate({
	    participantAddress:__participantAddress,
	    name : __name,
	    award : __award,
	    project:__project,
	    grade: __grade,
	    dateCreated:now,
	    dateIssued:now
	});
	certificateList.push(__name);
     	emit certCreated("A new certificate has been created for:",__name,"with address:",__participantAddress,"by:",msg.sender,now);
	}
	//Allows admin to remove a certificate.
	//This function should be called only when there is an creating a certificate
		function removeCertificate(address __participantAddress) onlyAdmin public{
		delete certificates[__participantAddress];
		emit certRemoved("A certificate belonging to:",__participantAddress,"has been deleted","at",now);
	}
	function checkParticipant(address __participantAddress) external  {
	     Certificate memory _cert;
        _cert.participantAddress = __participantAddress;
	   emit Participant(__participantAddress,"is a participant");
	}
	function issueCert() public{
	}
	function verifyCertByAddress(address __participantAddress) public view returns(bool){
	   
	   }

}