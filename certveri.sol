pragma solidity ^0.6.1;

contract BloceducareCerts{
	//global variable
	address private admin;
	mapping  (bytes => bool) private certificates;
	
	//events
	event certAdded(bytes hash);
	event certRemoved(bytes hash);
	
	//modifier
	modifier onlyAdmin(){
		require(msg.sender == admin, "Accessible by only Admin");
		_;
	}
	
	//verify that a cert must be added
	modifier certMustBeAdded(bytes memory hash){
	    require(certificates[hash] == true,"Cert doesn't exist");
	    _;
	}
	
	//verify that a cert must be not added
	modifier certMustBeNotAdded(bytes memory hash){
	    require(certificates[hash] == false,"Cert already was added");
	    _;
	}
	
	constructor() public{
		admin = msg.sender;
	}
	
	//if it should be possible to add many certs at a time, 
	//implement a method like
	//addCert(bytes[] memory hash)
	//You'll pay less fees making all in only one transaction!
	
	//dont let transaction go if cert is already added
	function addCert(bytes memory hash) 
	certMustBeNotAdded(hash) 
	onlyAdmin 
	public{
		certificates[hash] = true;
		emit certAdded(hash);
	}
	
	//Dont let transaction go if cert doesnt exist
	function removeCert(bytes memory hash) 
	certMustBeAdded(hash) 
	onlyAdmin public{
		certificates[hash] = false;
		emit certRemoved(hash);
	}
	
	function verifyCert(bytes memory hash) public view returns(bool){
		return (certificates[hash]);
	}
}
