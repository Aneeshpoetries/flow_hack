# 🧩 ZKP-Based NFT Smart Contract (No Imports / No Constructors / No Inputs)

### Overview
This project implements a **Zero-Knowledge Proof (ZKP)–inspired NFT minting system** written entirely in **Solidity**, with **no imports**, **no constructors**, and **no input fields** in its external functions.

It simulates a zero-knowledge verification mechanism that allows only *verified users* to mint NFTs — without ever revealing their personal data or passing explicit parameters.

---

## 🛠 Features

- ✅ **Zero-Knowledge Simulation**  
  Users call `verifySelf()` with no inputs.  
  The contract internally computes a verification hash and determines if the user is valid — no sensitive data is exposed.

- 🪙 **NFT Minting (No Inputs)**  
  Verified users can mint NFTs by simply calling `mintNFT()`.  
  Each NFT is uniquely tied to the user’s address.

- 🔐 **Admin Controls (No Inputs)**  
  The admin can:
  - Initialize themselves (`initAdmin()`)
  - Pause/unpause the contract
  - Self-verify for demo/testing

- 🧾 **No Imports, No Constructors, No Inputs**  
  Entire logic is contained within a single Solidity file and uses only built-in features.  
  This ensures simplicity, transparency, and full on-chain verification.

---

## 📜 Contract Details

| Property | Value |
|-----------|--------|
| **Name** | ZKP NFT |
| **Symbol** | None (Minimal implementation) |
| **Network** | Ethereum-compatible (EVM) |
| **Solidity Version** | ^0.8.19 |
| **Contract Address** | `0xC8d5B8757145Ca1C96447acE170D239a6f4730cf` |

---

## ⚙️ Functions Summary

### 🔧 Admin Functions
- `initAdmin()` — Set the deploying account as admin (once only).  
- `togglePause()` — Pause/unpause the contract.  
- `adminVerifySelf()` — Mark admin as verified manually (for testing).

### 🧩 User Functions
- `verifySelf()` — Simulated ZKP validation (no inputs).  
  Uses internal hash condition to confirm verification.
- `mintNFT()` — Mint NFT if verified (no inputs).  
  Mints one unique NFT per call.
- `myTokens()` — View all NFTs owned by the caller.  
- `amIVerified()` — Check if the caller is verified.  
- `myFirstTokenOwner()` — Get owner address of the caller’s first token.

---

## 🚀 Deployment Info

**Deployed Address:**  
`0xC8d5B8757145Ca1C96447acE170D239a6f4730cf`

**Deployed Network:**  
Flow testnet
---

## 🔒 Zero-Knowledge Simulation Logic

The `verifySelf()` function computes:
