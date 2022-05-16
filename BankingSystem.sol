// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.0;

contract banking{

    struct customer{
        uint256 cid;
        string name;
        string dateOfBirth;
        string fullAddress;
        string phoneNumber;
        bool firstAdmin;
        bool secondAdmin;
        bool thirdAdmin;
        bool isExist;
    }

    mapping (uint256 => customer) customers;

    function addCustomer (uint256 _cid, string memory _name, string memory _dateOfBirth, string memory _fullAddress, string memory _phoneNumber) public returns (bool){
        require(customers[_cid].isExist == false, "Customer Already Exist with Same ID");
        customers[_cid] = customer(_cid, _name, _dateOfBirth, _fullAddress, _phoneNumber, false, false, false, true);
        return true;
    }

    function deleteCustomer (uint256 _cid) public returns (bool){
        delete customers[_cid];
        return true;
    }

    function firstAdminApproval (uint256 _cid, bool _isApproved) public returns (bool){
        customers[_cid].firstAdmin = _isApproved;
        return true;
    }

    function secondAdminApproval (uint256 _cid, bool _isApproved) public returns (bool){
        customers[_cid].secondAdmin = _isApproved;
        return true;
    }

    function thirdAdminApproval (uint256 _cid, bool _isApproved) public returns (bool){
        customers[_cid].thirdAdmin = _isApproved;
        return true;
    }

    function getCustomer (uint256 _cid) public view returns (string memory, string memory, string memory, string memory){
        return(
            customers[_cid].name,
            customers[_cid].dateOfBirth,
            customers[_cid].fullAddress,
            customers[_cid].phoneNumber
        );
    }

    function checkCustomerStatus (uint256 _cid) public view returns (bool, bool, bool){
        return(
            customers[_cid].firstAdmin,
            customers[_cid].secondAdmin,
            customers[_cid].thirdAdmin
        );
    }
}
