#First EXAMPLE
# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

#Deployment
local :; forge create --rpc-url http://127.0.0.1:7545 \
   						--constructor-args "" \
   					 	--private-key 506a01d72bd140ba821edc2111bbb4c60f304da6a53abb3fcb66ec682d258a45 \
					 	--legacy $(contract)

rinkeby_migrate :; forge create --rpc-url $(ALCHEMY) \
   						--constructor-args $(args) \
   					    --private-key ${ACCOUNT_PRIVATE_KEY} $(contract) 

rinkeby_migrate_without_constructor :; forge create --rpc-url $(ALCHEMY) \
   					    --private-key ${ACCOUNT_PRIVATE_KEY} $(contract) 

rinkeby_verify :; forge verify-contract \
				--compiler-version "v0.8.13+commit.abaa5c0e" \
				 $(address) $(contract) ${ETHERSCAN_API_KEY} --chain-id 4 

rinkeby_verify_check :; forge verify-check --chain-id 4 $(guid) ${ETHERSCAN_API_KEY}

# Build & test
trace   :; forge test -vvv

all: clean remove install update solc build dappbuild

# Install proper solc version.
#solc:; nix-env -f https://github.com/dapphub/dapptools/archive/master.tar.gz -iA solc-static-versions.solc_0_8_13

# Clean the repo
clean  :; forge clean

# Remove modules
remove :; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules

# Install the Modules
install :;  forge install dapphub/ds-test && \
			forge install OpenZeppelin/openzeppelin-contracts 
			# && forge install rari-capital/solmate && 
		    # forge install brockelmore/forge-std &&
		    # forge install ZeframLou/clones-with-immutable-args && 
			# forge install smartcontractkit/chainlink-brownie-contracts

# Update Dependencies
update:; forge update

# Builds
build  :; forge clean && forge build --optimize --optimize-runs 1000000
dappbuild :; dapp build

# chmod scripts
scripts :; chmod +x ./scripts/*

# Tests
test   :; forge clean && forge test --optimize --optimize-runs 1000000 -v # --ffi # enable if you need the `ffi` cheat code on HEVM

# Lints
lint :; yarn prettier --write src/**/*.sol && prettier --write src/*.sol

# Generate Gas Snapshots
snapshot :; forge clean && forge snapshot --optimize --optimize-runs 1000000

# Fork Mainnet With Hardhat
mainnet-fork :; npx hardhat node --fork ${ETH_MAINNET_RPC_URL}

# Rename all instances of this repo with the new repo name
rename :; chmod +x ./scripts/* && ./scripts/rename.sh

