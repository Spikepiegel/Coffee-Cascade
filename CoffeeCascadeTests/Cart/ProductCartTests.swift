//
//  ProductCartTests.swift
//  Coffee CascadeTests
//
//  Created by Николай Лермонтов on 07.07.2024.
//

@testable import Coffee_Cascade
import Combine
import XCTest

final class ProductCartTests: XCTestCase {
    var productCart: ProductCart!
    var cancellables: Set<AnyCancellable>!

    var product: Recipe = Recipe(
        productID: "1",
        name: "Espresso",
        image: "espresso.jpg",
        description: "Strong coffee",
        recipeYield: "1 cup",
        datePublished: "2023-01-01",
        prepTime: "5 min",
        totalTime: "5 min",
        recipeIngredient: ["coffee"],
        recipeInstructions: [],
        category: "Hot Drinks"
    )

    override func setUpWithError() throws {
        productCart = ProductCart.shared
        productCart.clearCart()
        cancellables = []
    }

    override func tearDownWithError() throws {
        productCart.clearCart()
        cancellables = nil
    }

    func testAddProduct() throws {
        productCart.addProduct(product)
        XCTAssertEqual(productCart.publishProducts.count, 1)
        XCTAssertEqual(productCart.publishProducts.first?.productID, "1")
    }

    func testRemoveProduct() throws {
        productCart.addProduct(product)
        productCart.removeProduct(withID: "1")
        XCTAssertTrue(productCart.publishProducts.isEmpty)
    }

    func testContainsProduct() throws {
        productCart.addProduct(product)
        XCTAssertTrue(productCart.containsProduct(withID: "1"))
    }

    func testGetCountOfProducts() throws {
        let additionalProduct = Recipe(
            productID: "1",
            name: "Latte",
            image: "latte.jpg",
            description: "Coffee with milk",
            recipeYield: "1 cup",
            datePublished: "2023-01-02",
            prepTime: "10 min",
            totalTime: "10 min",
            recipeIngredient: ["coffee", "milk"],
            recipeInstructions: [],
            category: "Hot Drinks"
        )
        productCart.addProduct(product)
        productCart.addProduct(additionalProduct)
        XCTAssertEqual(productCart.getCountOfProducts(withID: "1"), 2)
    }

    func testGetAllProducts() throws {
        let additionalProduct = Recipe(
            productID: "2",
            name: "Latte",
            image: "latte.jpg",
            description: "Coffee with milk",
            recipeYield: "1 cup",
            datePublished: "2023-01-02",
            prepTime: "10 min",
            totalTime: "10 min",
            recipeIngredient: ["coffee", "milk"],
            recipeInstructions: [],
            category: "Hot Drinks"
        )
        productCart.addProduct(product)
        productCart.addProduct(additionalProduct)
        XCTAssertEqual(productCart.getAllProducts().count, 2)
    }

    func testProductCountsUpdate() throws {
        let additionalProduct = Recipe(
            productID: "2",
            name: "Latte",
            image: "latte.jpg",
            description: "Coffee with milk",
            recipeYield: "1 cup",
            datePublished: "2023-01-02",
            prepTime: "10 min",
            totalTime: "10 min",
            recipeIngredient: ["coffee", "milk"],
            recipeInstructions: [],
            category: "Hot Drinks"
        )
        let expectation = self.expectation(description: "Product counts updated")

        productCart.$productCounts
            .dropFirst()
            .sink { counts in
                XCTAssertEqual(counts["1"], 1)
                XCTAssertEqual(counts["2"], 1)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        productCart.addProduct(product)
        productCart.addProduct(additionalProduct)

        waitForExpectations(timeout: 1, handler: nil)
    }
}
