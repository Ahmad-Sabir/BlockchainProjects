// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.0;

interface IERC223 {
    function balanceOf(address account) external view returns (uint256);

    function mint(address _userAdd, uint256 _amount) external returns (bool);

    function burn(address _userAdd, uint256 _amount) external returns (bool);

    function transfer(
        address _to,
        uint256 _value,
        bytes calldata _data
    ) external returns (bool);

    function transfer(address _to, uint256 _value) public returns (bool);
}

contract Staking {
    struct stake {
        address userId;
        uint256 amount;
        uint256 _stakingtime;
        uint256 totaltime;
        bool staked;
    }

    IERC223 public token;
    mapping(address => stake) stakes;
    address[] stakeHolders;
    uint256 stakeHolderCount = 0;

    constructor() {
        token = IERC223(0xd9145CCE52D386f254917e481eB44e9943F39138);
    }

    function addStake(address _userId, uint256 _amount) public returns (bool) {
        require(
            stakes[_userId].staked == false,
            "You have Already Staked Token"
        );
        require(
            _amount <= token.balanceOf(_userId),
            "You can't Stake More than You Own"
        );
        // token.burn(_userId, _amount);
        token.transferFrom(msg.sender, address(this), _amount);
        stakes[_userId] = stake(_userId, _amount, block.timestamp, 0, true);
        stakeHolders.push(_userId);
        stakeHolderCount++;
        return true;
    }

    function reward() private {
        uint256 rewardtk = stakeHolderCount / 1;
    }

    function checkStakedToken(address _userId) public view returns (uint256) {
        return stakes[_userId].amount;
    }

    function removeStake(address _userId, uint256 _amount)
        public
        returns (bool)
    {
        // token.mint(_userId, _amount);
        token.transferFrom(address(this), msg.sender, stakes[_userId].amount);
        stakes[_userId].totaltime = (block.timestamp -
            stakes[_userId]._stakingtime);
        stakes[_userId].amount = stakes[_userId].amount - _amount;
        stakes[_userId].staked = false;
        stakeHolderCount--;
        return true;
    }

    function checkStakeHolders() public view returns (address[] memory) {
        return stakeHolders;
    }

    function checkStakedTime(address _userId) public view returns (uint256) {
        return stakes[_userId].totaltime;
    }
}
