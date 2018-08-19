pragma solidity ^0.4.23;

contract Explorer {
    
    address public owner;

    struct Product {
        string name;
        string source_name;
        address[] ingredientsArray;
    }

    mapping (address => Product) public products;

    struct Ingredient {
        string name;
    }

    mapping (address => Ingredient) public ingredients;

    constructor() public {
        owner = msg.sender;
    }
    
    function addProduct(address _product_address, string _name, string _source_name) public {
        // creating a temp struct first
        Product memory newProduct;
        newProduct.name = _name;
        newProduct.source_name = _source_name;

        // saving struct into the `products` mapping
        products[_product_address] = newProduct;
    }

    function addIngredient(address _ingredients_address, address _product_address, string _name) public {
        // creating a temp struct first
        Ingredient memory newIngredient;
        newIngredient.name = _name;

        // saving struct into the `ingredients` mapping
        ingredients[_ingredients_address] = newIngredient;

        Product storage _product = products[_product_address];
        _product.ingredientsArray.push(_ingredients_address);
    }

    function getIngredientLength(address _product_address) public view returns (uint256) {
        return products[_product_address].ingredientsArray.length;
    }

    function getIngredient(address _product_address, uint256 _index) public view returns (address) {
        return products[_product_address].ingredientsArray[_index];
    }

}
