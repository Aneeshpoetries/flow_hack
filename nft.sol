// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/// @title ZKP-Simulated NFT for Verified Users
/// @notice No imports, no constructors, and no external input fields.
contract ZKPNFT {
    /* -------------------- State -------------------- */
    address public admin;
    bool public initialized;
    bool public paused;

    uint256 private nextTokenId = 1;

    mapping(address => bool) private verified;   // simulated "ZKP verified" users
    mapping(uint256 => address) private owners;  // NFT ownership
    mapping(address => uint256[]) private tokens; // tokens owned by user

    /* -------------------- Events -------------------- */
    event AdminInitialized(address indexed admin);
    event UserVerified(address indexed user);
    event NFTMinted(address indexed user, uint256 tokenId);
    event Paused(bool paused);

    /* -------------------- Modifiers -------------------- */
    modifier onlyAdmin() {
        require(msg.sender == admin, "not admin");
        _;
    }

    modifier notPaused() {
        require(!paused, "paused");
        _;
    }

    /* -------------------- Initialization (no constructor) -------------------- */
    function initAdmin() external {
        require(!initialized, "already initialized");
        admin = msg.sender;
        initialized = true;
        emit AdminInitialized(admin);
    }

    /* -------------------- Admin Controls (no inputs) -------------------- */

    /// @notice Toggle paused/unpaused state.
    function togglePause() external onlyAdmin {
        paused = !paused;
        emit Paused(paused);
    }

    /// @notice Admin marks themselves as verified (simulating ZKP validation).
    /// In real ZKP flow, proof verification would happen off-chain or by verifier contract.
    function adminVerifySelf() external onlyAdmin {
        verified[msg.sender] = true;
        emit UserVerified(msg.sender);
    }

    /* -------------------- ZKP Simulation -------------------- */

    /// @notice Simulated verification function.
    /// Each user calls this function, which checks a hidden condition (their address hash).
    /// Think of this as a "zero-knowledge" reveal: the user doesn't input anything;
    /// the contract computes the proof internally from msg.sender.
    function verifySelf() external notPaused {
        // "Hidden" verification condition: simple deterministic hash rule
        bytes32 proof = keccak256(abi.encodePacked(msg.sender, block.chainid));

        // For demonstration, assume addresses whose proof ends with an even byte are valid
        if (uint8(proof[31]) % 2 == 0) {
            verified[msg.sender] = true;
            emit UserVerified(msg.sender);
        } else {
            revert("ZKP verification failed");
        }
    }

    /* -------------------- NFT Minting (no input fields) -------------------- */

    /// @notice Mint NFT if verified by ZKP.
    /// No parameters — uses msg.sender as identity.
    function mintNFT() external notPaused {
        require(verified[msg.sender], "not verified");
        uint256 tokenId = nextTokenId;
        nextTokenId++;

        owners[tokenId] = msg.sender;
        tokens[msg.sender].push(tokenId);
        emit NFTMinted(msg.sender, tokenId);
    }

    /* -------------------- Views (no input fields) -------------------- */

    /// @notice Returns your own token IDs (no inputs).
    function myTokens() external view returns (uint256[] memory) {
        return tokens[msg.sender];
    }

    /// @notice Returns your verification status (no inputs).
    function amIVerified() external view returns (bool) {
        return verified[msg.sender];
    }

    /// @notice Returns the owner of your first token (if any).
    function myFirstTokenOwner() external view returns (address) {
        if (tokens[msg.sender].length == 0) return address(0);
        return owners[tokens[msg.sender][0]];
    }
}
