// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/utils/math/Math.sol";
import "@openzeppelin/contracts/interfaces/IERC4626.sol";

contract VulnerableVault is ERC20, IERC4626 {
    using SafeERC20 for IERC20;
    using Math for uint256;

    address owner;

    IERC20 private immutable _asset;

    constructor(IERC20 assetToken) ERC20("Vulnerable Vault", "vVLT") {
        _asset = assetToken;
        owner = msg.sender;
    }

    function asset() public view virtual override returns (address) {
        return address(_asset);
    }

    // Esta é a função de depósito do vault que permite aos usuários depositarem tokens
    // e receberem shares (ações) do vault em troca
    //
    // Parâmetros:
    // - assets: quantidade de tokens que o usuário quer depositar
    // - receiver: endereço que receberá as shares do vault
    //
    // A função:
    // 1. Verifica o supply total de shares do vault
    // 2. Calcula quantas shares o usuário deve receber baseado nos assets depositados:
    //    - Se o supply for 0 (primeiro depósito), shares = assets (1:1)
    //    - Senão, shares = (assets * supply total) / total de assets no vault
    // 3. Minta as novas shares para o receiver
    // 4. Transfere os tokens do usuário para o vault
    // 5. Emite evento de Deposit
    //
    // VULNERABILIDADE: A ordem das operações está incorreta - o vault minta as shares
    // antes de receber os assets, permitindo manipulação do preço das shares
    function deposit(uint256 assets, address receiver) public virtual override returns (uint256 shares) {
        uint256 supply = totalSupply();
        shares = supply == 0 ? assets : (assets * supply) / totalAssets();
        _mint(receiver, shares);
        _asset.safeTransferFrom(msg.sender, address(this), assets);
        emit Deposit(msg.sender, receiver, assets, shares);
    }

    // É como a função deposit, mas ao contrário :
    // Em vez de dizer "quero depositar X tokens", o usuário diz "quero receber X shares".
    function mint(uint256 shares, address receiver) public virtual override returns (uint256 assets) {
        if (msg.sender != owner) {
            uint256 maxAssets = convertToAssets(allowance(owner, msg.sender));
            require(assets <= maxAssets, "Withdraw amount exceeds allowance");
            _spendAllowance(owner, msg.sender, convertToShares(assets));
        }

        assets = convertToAssets(shares);
        _mint(receiver, shares);
        _asset.safeTransferFrom(msg.sender, address(this), assets);
        emit Deposit(msg.sender, receiver, assets, shares);
    }

    function withdraw(uint256 assets, address receiver, address owner_)
        public
        virtual
        override
        returns (uint256 shares)
    {
        if (msg.sender != owner_) {
            uint256 maxAssets = convertToAssets(allowance(owner_, msg.sender));
            require(assets <= maxAssets, "Withdraw amount exceeds allowance");
            _spendAllowance(owner_, msg.sender, convertToShares(assets));
        }

        shares = convertToShares(assets);
        require(shares <= balanceOf(owner_), "Withdraw amount exceeds balance");

        _burn(owner_, shares);
        _asset.safeTransfer(receiver, assets);

        emit Withdraw(msg.sender, receiver, owner_, assets, shares);
        return shares;
    }

    function redeem(uint256 shares, address receiver, address owner_)
        public
        virtual
        override
        returns (uint256 assets)
    {
        if (msg.sender != owner_) {
            _spendAllowance(owner_, msg.sender, shares);
        }
        assets = convertToAssets(shares);
        _burn(owner_, shares);
        _asset.safeTransfer(receiver, assets);
        emit Withdraw(msg.sender, receiver, owner_, assets, shares);
    }

    function totalAssets() public view virtual override returns (uint256) {
        return _asset.balanceOf(address(this));
    }

    function convertToShares(uint256 assets) public view virtual override returns (uint256) {
        uint256 supply = totalSupply();
        return supply == 0 ? assets : assets.mulDiv(supply, totalAssets(), Math.Rounding.Floor);
    }

    function donateAssets(uint256 amount) public {
        _asset.safeTransferFrom(msg.sender, address(this), amount);
    }

    function convertToAssets(uint256 shares) public view virtual override returns (uint256) {
        uint256 supply = totalSupply();
        if (supply == 0) {
            return shares;
        }
        return (shares * totalAssets() * 100) / supply;
    }

    function previewDeposit(uint256 assets) public view virtual override returns (uint256) {
        return convertToShares(assets);
    }

    function previewMint(uint256 shares) public view virtual override returns (uint256) {
        return convertToAssets(shares);
    }

    function previewWithdraw(uint256 assets) public view virtual override returns (uint256) {
        return convertToShares(assets);
    }

    function previewRedeem(uint256 shares) public view virtual override returns (uint256) {
        return convertToAssets(shares);
    }

    function maxDeposit(address) public view virtual override returns (uint256) {
        return type(uint256).max;
    }

    function maxMint(address) public view virtual override returns (uint256) {
        return type(uint256).max;
    }

    function maxWithdraw(address owner_) public view virtual override returns (uint256) {
        return convertToAssets(balanceOf(owner_));
    }

    function maxRedeem(address owner_) public view virtual override returns (uint256) {
        return balanceOf(owner_);
    }
}
