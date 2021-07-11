pragma solidity ^0.4.21;

// SPDX-License-Identifier: MIT

contract ReentrancyGuard {
    // Booleans are more expensive than uint256 or any type that takes up a full
    // word because each write operation emits an extra SLOAD to first read the
    // slot's contents, replace the bits taken up by the boolean, and then write
    // back. This is the compiler's defense against contract upgrades and
    // pointer aliasing, and it cannot be disabled.

    // The values being non-zero value makes deployment a bit more expensive,
    // but in exchange the refund on every call to nonReentrant will be lower in
    // amount. Since refunds are capped to a percentage of the total
    // transaction's gas, it is best to keep them low in cases like this one, to
    // increase the likelihood of the full refund coming into effect.
    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;

    uint256 private _status;

    function ReentrancyGuard() internal {
        _status = _NOT_ENTERED;
    }

    /**
     * @dev Prevents a contract from calling itself, directly or indirectly.
     * Calling a `nonReentrant` function from another `nonReentrant`
     * function is not supported. It is possible to prevent this from happening
     * by making the `nonReentrant` function external, and make it call a
     * `private` function that does the actual work.
     */
    modifier nonReentrant() {
        // On the first call to nonReentrant, _notEntered will be true
        require(_status != _ENTERED);

        // Any calls to nonReentrant after this point will fail
        _status = _ENTERED;

        _;

        // By storing the original value once again, a refund is triggered (see
        // https://eips.ethereum.org/EIPS/eip-2200)
        _status = _NOT_ENTERED;
    }
}

contract Owned {
    address public owner;
    address public nominatedOwner;

    function Owned(address _owner) public {
        require(_owner != address(0));
        owner = _owner;
        emit OwnerChanged(address(0), _owner);
    }

    function nominateNewOwner(address _owner) external onlyOwner {
        nominatedOwner = _owner;
        emit OwnerNominated(_owner);
    }

    function acceptOwnership() external {
        require(msg.sender == nominatedOwner);
        emit OwnerChanged(owner, nominatedOwner);
        owner = nominatedOwner;
        nominatedOwner = address(0);
    }

    modifier onlyOwner {
        _onlyOwner();
        _;
    }

    function _onlyOwner() private view {
        require(msg.sender == owner);
    }

    event OwnerNominated(address newOwner);
    event OwnerChanged(address oldOwner, address newOwner);
}

contract Pausable is Owned {
    uint256 public lastPauseTime;
    bool public paused;

    function Pausable() internal {
        // This contract is abstract, and thus cannot be instantiated directly
        require(owner != address(0));
        // Paused will be false, and lastPauseTime will be 0 upon initialisation
    }

    /**
     * @notice Change the paused state of the contract
     * @dev Only the contract owner may call this.
     */
    function setPaused(bool _paused) external onlyOwner {
        // Ensure we're actually changing the state before we do anything
        if (_paused == paused) {
            return;
        }

        // Set our paused state.
        paused = _paused;

        // If applicable, set the last pause time.
        if (paused) {
            lastPauseTime = now;
        }

        // Let everyone know that our pause state has changed.
        emit PauseChanged(paused);
    }

    event PauseChanged(bool isPaused);

    modifier notPaused {
        require(!paused);
        _;
    }
}

library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a);

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b);

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0);
        return a % b;
    }
}

interface CDEXContract {

    function balanceOf(address account) external view returns (uint256);
    function transfer(address _to, uint256 _value) external;
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);

}

contract CDEXStakingPool is ReentrancyGuard, Pausable {
    using SafeMath for uint256;

    // STATE VARIABLES

    CDEXContract public CDEXToken;
    uint256 public periodFinish = 0;
    uint256 public rewardRate = 0;
    uint256 public rewardsDuration = 0;
    uint256 public lastUpdateTime;
    uint256 public rewardPerTokenStored;
    
    // Loyalty tiers are based on the user balance being staked
    uint256 public loyaltyTier1 = 100000000 * 1e8;
    uint256 public loyaltyTier2 = 10000000 * 1e8;
    uint256 public loyaltyTier3 = 1000000 * 1e8;
    
    // Bonus tiers are calculated with precision of two decimals (i.e. 125 = 1.25%)
    uint256 public loyaltyBonusTier1 = 125;
    uint256 public loyaltyBonusTier2 = 100;
    uint256 public loyaltyBonusTier3 = 50;
    uint256 public loyaltyBonusTotal;
    uint256 public depositedLoyaltyBonus;

    mapping(address => uint256) public userRewardPerTokenPaid;
    mapping(address => uint256) public rewards;
    uint256 public depositedRewardTokens;

    uint256 private _totalSupply;
    mapping(address => uint256) private _balances;

    // CONSTRUCTOR

    function CDEXStakingPool(
        address _owner,
        address _CDEXToken
    ) public Owned(_owner) {
        CDEXToken = CDEXContract(_CDEXToken);
    }

    // VIEWS

    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) external view returns (uint256) {
        return _balances[account];
    }

    function lastTimeRewardApplicable() public view returns (uint256) {
        return min(block.timestamp, periodFinish);
    }

    function rewardPerToken() public view returns (uint256) {
        if (_totalSupply == 0) {
            return rewardPerTokenStored;
        }
        return
            rewardPerTokenStored.add(
                lastTimeRewardApplicable()
                    .sub(lastUpdateTime)
                    .mul(rewardRate)
                    .mul(1e8)
                    .div(_totalSupply)
            );
    }

    function earned(address account) public view returns (uint256) {
        return
            _balances[account]
                .mul(rewardPerToken().sub(userRewardPerTokenPaid[account]))
                .div(1e8)
                .add(rewards[account]);
    }

    function getRewardForDuration() external view returns (uint256) {
        return rewardRate.mul(rewardsDuration);
    }

    function min(uint256 a, uint256 b) public pure returns (uint256) {
        return a < b ? a : b;
    }

    // PUBLIC FUNCTIONS

    function stake(uint256 amount)
        external
        nonReentrant
        notPaused
        updateReward(msg.sender)
    {
        require(amount > 0);
        _totalSupply = _totalSupply.add(amount);
        _balances[msg.sender] = _balances[msg.sender].add(amount);
        CDEXToken.transferFrom(msg.sender, address(this), amount);
        emit Staked(msg.sender, amount);
    }

    function withdraw(uint256 amount)
        public
        nonReentrant
        updateReward(msg.sender)
    {
        require(amount > 0);
        _totalSupply = _totalSupply.sub(amount);
        _balances[msg.sender] = _balances[msg.sender].sub(amount);
        CDEXToken.transfer(msg.sender, amount);
        emit Withdrawn(msg.sender, amount);
    }

    function getReward() 
        public 
        nonReentrant 
        updateReward(msg.sender) 
    {
        uint256 reward = rewards[msg.sender];
        uint loyaltyBonus;
        if (reward > 0 && depositedRewardTokens >= reward) {
            rewards[msg.sender] = 0;
            depositedRewardTokens = depositedRewardTokens.sub(reward);
            
            if (_balances[msg.sender] >= loyaltyTier1) {
                loyaltyBonus = reward.mul(loyaltyBonusTier1).div(10000);
            } else if (_balances[msg.sender] >= loyaltyTier2) {
                loyaltyBonus = reward.mul(loyaltyBonusTier2).div(10000);
            } else if (_balances[msg.sender] >= loyaltyTier3) {
                loyaltyBonus = reward.mul(loyaltyBonusTier3).div(10000);
            }
            
            depositedLoyaltyBonus = depositedLoyaltyBonus.sub(loyaltyBonus);
            CDEXToken.transfer(msg.sender, reward.add(loyaltyBonus));
            emit RewardPaid(msg.sender, reward);

            if(loyaltyBonus > 0) {
                emit LoyaltyBonusPaid(msg.sender, loyaltyBonus);
            }
        }
    }

    function exit() external {
        withdraw(_balances[msg.sender]);
        getReward();
    }
    
     // RESTRICTED FUNCTIONS
     
    function depositTokens(uint256 amount) public onlyOwner {
        // Calculating the total loyalty bonus percentage from the total
        depositedLoyaltyBonus = amount.mul(loyaltyBonusTotal).div(10000);
        // Calculating the reward part of the deposit
        depositedRewardTokens = depositedRewardTokens.add(amount.sub(depositedLoyaltyBonus));
        CDEXToken.transferFrom(owner, address(this), amount);
        emit RewardsAndBonusDeposited(owner, address(this), amount, depositedLoyaltyBonus);
    }

    function notifyRewardAmount(uint256 reward)
        external
        onlyOwner
        updateReward(address(0))
    {
        if (block.timestamp >= periodFinish) {
            rewardRate = reward.div(rewardsDuration);
        } else {
            uint256 remaining = periodFinish.sub(block.timestamp);
            uint256 leftover = remaining.mul(rewardRate);
            rewardRate = reward.add(leftover).div(rewardsDuration);
        }

        // Ensure the provided reward amount is not more than the balance in the contract.
        // This keeps the reward rate in the right range, preventing overflows due to
        // very high values of rewardRate in the earned and rewardsPerToken functions;
        // Reward + leftover must be less than 2^256 / 10^18 to avoid overflow.
      
        require(rewardRate <= depositedRewardTokens.div(rewardsDuration));

        lastUpdateTime = block.timestamp;
        periodFinish = block.timestamp.add(rewardsDuration);
        emit RewardAdded(reward);
    }

    function setRewardsDuration(uint256 _rewardsDuration) external onlyOwner {
        require(block.timestamp > periodFinish);
        rewardsDuration = _rewardsDuration;
        emit RewardsDurationUpdated(rewardsDuration);
    }

    function setLoyaltyTiers(
        uint256 _loyaltyTier1, 
        uint256 _loyaltyTier2, 
        uint256 _loyaltyTier3
    ) external onlyOwner 
    {
        loyaltyTier1 = _loyaltyTier1.mul(1e8);
        loyaltyTier2 = _loyaltyTier2.mul(1e8);
        loyaltyTier3 = _loyaltyTier3.mul(1e8);

        emit LoyaltyTiersUpdated(loyaltyTier1, loyaltyTier2, loyaltyTier3);
    }

    function setLoyaltyBonusTiers(
        uint256 _loyaltyBonusTier1, 
        uint256 _loyaltyBonusTier2, 
        uint256 _loyaltyBonusTier3
    ) external onlyOwner 
    {
        // Total must be less than 100% of the reward
        // Bonus tiers must be informed as two decimal precision, therefore 10,000 = 1 = 100%
        require(_loyaltyBonusTier1.add(_loyaltyBonusTier2).add(_loyaltyBonusTier3) < 10000);

        loyaltyBonusTier1 = _loyaltyBonusTier1;
        loyaltyBonusTier2 = _loyaltyBonusTier2;
        loyaltyBonusTier3 = _loyaltyBonusTier3;

        loyaltyBonusTotal = loyaltyBonusTier1.add(loyaltyBonusTier2).add(loyaltyBonusTier3);

        emit LoyaltyBonusTiersUpdated(loyaltyBonusTier1, loyaltyBonusTier2, loyaltyBonusTier3);
    }

    // MODIFIERS

    modifier updateReward(address account) {
        rewardPerTokenStored = rewardPerToken();
        lastUpdateTime = lastTimeRewardApplicable();
        if (account != address(0)) {
            rewards[account] = earned(account);
            userRewardPerTokenPaid[account] = rewardPerTokenStored;
        }
        _;
    }

    // EVENTS

    event RewardAdded(uint256 reward);
    event Staked(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);
    event RewardPaid(address indexed user, uint256 reward);
    event LoyaltyBonusPaid(address indexed user, uint256 loyaltyBonus);
    event RewardsDurationUpdated(uint256 newDuration);
    event Recovered(address token, uint256 amount);
    event RewardsAndBonusDeposited(address sender, address receiver, uint256 reward, uint256 bonus);
    event LoyaltyTiersUpdated(uint256 loyaltyTier1, uint256 loyaltyTier2, uint256 loyaltyTier3);
    event LoyaltyBonusTiersUpdated(uint256 loyaltyBonusTier1, uint256 loyaltyBonusTier2, uint256 loyaltyBonusTier3);
}