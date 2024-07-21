//
//  ProductDetailsViewModelTests.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 21.07.2024.
//

import XCTest
import Combine
@testable import Coffee_Cascade
import SwiftfulRouting

final class ProductDetailsViewModelTests: XCTestCase {

    var viewModel: ProductDetailsViewModel!
    var mockRouter: MockRouter!
    var router: AnyRouter!
    var cartService: MockProductCartService!
    var recipe: Recipe!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        mockRouter = MockRouter()
        router = AnyRouter(object: mockRouter)
        cartService = MockProductCartService()
        recipe = Recipe(productID: "1", name: "Espresso", image: "espresso.jpg", description: "Strong coffee", recipeYield: "1 cup", datePublished: "2023-01-01", prepTime: "5 min", totalTime: "5 min", recipeIngredient: ["coffee"], recipeInstructions: [], category: "Hot Drinks")
        viewModel = ProductDetailsViewModel(router: router, recipe: recipe)
        cancellables = []
    }

    override func tearDownWithError() throws {
        viewModel = nil
        router = nil
        cartService = nil
        recipe = nil
        cancellables = nil
    }

    func testInitialization() throws {
        XCTAssertEqual(viewModel.recipe.productID, "1")
        XCTAssertEqual(viewModel.recipe.name, "Espresso")
        XCTAssertEqual(viewModel.countOfProducts, 0)
        XCTAssertTrue(viewModel.isCartEmpty)
    }

    func testAddToCart() throws {
        viewModel.addToCart()
        XCTAssertTrue(cartService.didAddProduct)
        XCTAssertEqual(cartService.addedProductID, "1")
    }

    func testRemoveFromCart() throws {
        viewModel.addToCart()
        viewModel.removeFromCart()
        XCTAssertTrue(cartService.didRemoveProduct)
        XCTAssertEqual(cartService.removedProductID, "1")
    }

    func testCountOfProductsUpdate() throws {
        let expectation = self.expectation(description: "Count of products updated")
        
        viewModel.$countOfProducts
            .dropFirst()
            .sink { count in
                XCTAssertEqual(count, 1)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        cartService.addProduct(recipe)
        
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testIsCartEmptyUpdate() throws {
        let expectation = self.expectation(description: "isCartEmpty updated")
        
        viewModel.$isCartEmpty
            .dropFirst()
            .sink { isEmpty in
                XCTAssertFalse(isEmpty)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        cartService.addProduct(recipe)
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
