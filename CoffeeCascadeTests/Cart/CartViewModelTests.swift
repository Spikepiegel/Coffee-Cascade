//
//  CartViewModelTests.swift
//  Coffee CascadeTests
//
//  Created by Николай Лермонтов on 21.07.2024.
//

@testable import Coffee_Cascade
import Combine
import SwiftfulRouting
import XCTest

final class CartViewModelTests: XCTestCase {
    var viewModel: CartViewModel!
    var mockRouter: MockRouter!
    var router: AnyRouter!
    var cartService: MockProductCartService!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        mockRouter = MockRouter()
        router = AnyRouter(object: mockRouter)
        cartService = MockProductCartService()
        viewModel = CartViewModel(router: router, paymentFinished: nil)
        cancellables = []
    }

    override func tearDownWithError() throws {
        viewModel = nil
        router = nil
        cartService = nil
        cancellables = nil
    }

    func testInitialization() throws {
        XCTAssertEqual(viewModel.totalPrice, 0)
        XCTAssertEqual(viewModel.priceFreeShipping, 15)
        XCTAssertTrue(viewModel.products.isEmpty)
        XCTAssertTrue(viewModel.productCounts.isEmpty)
        XCTAssertFalse(viewModel.paymentConfirmed)
    }

    func testAddToCart() throws {
        let recipe = Recipe(
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
        viewModel.addToCart(recipe: recipe)
        XCTAssertTrue(cartService.didAddProduct)
        XCTAssertEqual(cartService.addedProductID, "1")
    }

    func testRemoveFromCart() throws {
        let recipe = Recipe(
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
        viewModel.addToCart(recipe: recipe) // Add first
        viewModel.removeFromCart(recipe: recipe)
        XCTAssertTrue(cartService.didRemoveProduct)
        XCTAssertEqual(cartService.removedProductID, "1")
    }

    func testCloseCart() throws {
        viewModel.closeCart()
        XCTAssertTrue(mockRouter.didDismissScreen())
    }

    func testTotalPriceUpdate() throws {
        let expectation = self.expectation(description: "Total price updated")

        viewModel.$totalPrice
            .dropFirst()
            .sink { totalPrice in
                XCTAssertEqual(totalPrice, 2.99)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        let recipe = Recipe(
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
        cartService.addProduct(recipe)

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testPaymentConfirmed() throws {
        let expectation = self.expectation(description: "Payment confirmed and cart closed")

        viewModel.paymentFinished = {
            expectation.fulfill()
        }

        viewModel.paymentConfirmed = true

        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertTrue(mockRouter.didDismissScreen())
    }
}
