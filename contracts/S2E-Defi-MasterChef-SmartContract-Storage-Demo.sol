//SPDX-License-Identifier: MIT
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "../contracts/s2erewards.sol";
pragma solidity ^0.8.7;
contract S2EMasterChefV1 is Ownable, ReentrancyGuard{
    using SafeMath for uint256;
    using SafeERC20 for IERC20;
    struct UserInfo {
        uint256 amount;
        uint256 pendingReward;
    }
    struct PoolInfo {
        IERC20 lpToken;
        uint256 allocPoint;
        uint256 lastRewardBlock;
        uint256 rewardTokenPerShare;
    }
    s2eRewards public s2er;
    address public dev;
    uint256 public s2erPerBlock;
    mapping(uint256 => mapping(address=>UserInfo)) public userInfo;
    PoolInfo[] public poolInfo;
    uint256 public totalAllocation=0;
    uint256 public startBlock;
    uint256 public BONUS_MULTIPLIER;
    constructor (
        s2eRewards _s2er,
        address _dev,
        uint256 _s2erPerBlock,
        uint256 _startBlock,
        uint256 _multiplier
    )  {
        s2er = _s2er;
        dev= _dev;
        s2erPerBlock=_s2erPerBlock;
        startBlock=_startBlock;
        BONUS_MULTIPLIER= _multiplier;
        poolInfo.push(PoolInfo({
            lpToken:_s2er,
            allocPoint:10000,
            lastRewardBlock:_startBlock,
            rewardTokenPerShare:0
        }));
        totalAllocation = 10000;
    }
}