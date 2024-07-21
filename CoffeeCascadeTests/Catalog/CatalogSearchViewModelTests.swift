//
//  CatalogSearchViewModelTests.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 21.07.2024.
//

@testable import Coffee_Cascade
import Combine
import SwiftfulRouting
import SwiftUI
import XCTest

final class CatalogSearchViewModelTests: XCTestCase {
    var viewModel: CatalogSearchViewModel!
    var mockRouter: MockRouter!
    var router: AnyRouter!
    var cartService: MockProductCartService!
    var recipes: [Recipe]!
    var categories: [String]!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        mockRouter = MockRouter()
        router = AnyRouter(object: mockRouter)
        cartService = MockProductCartService()
        recipes = [
            Recipe(
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
            ),
            Recipe(
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
            ),
        ]
        categories = ["Hot Drinks", "Cold Drinks"]
        viewModel = CatalogSearchViewModel(
            router: router,
            recipes: recipes,
            categories: categories,
            productCartSerivce: cartService
        )
        cancellables = []
    }

    override func tearDownWithError() throws {
        viewModel = nil
        router = nil
        cartService = nil
        recipes = nil
        categories = nil
        cancellables = nil
    }

    func testInitialization() throws {
        XCTAssertEqual(viewModel.recipes.count, 2)
        XCTAssertEqual(viewModel.categories.count, 2)
        XCTAssertTrue(viewModel.productCounts.isEmpty)
    }

    func testAddToCart() throws {
        viewModel.addToCart(recipe: recipes[0])
        XCTAssertTrue(cartService.didAddProduct)
        XCTAssertEqual(cartService.addedProductID, "1")
    }

    func testRemoveFromCart() throws {
        viewModel.removeFromCart(recipe: recipes[0])
        XCTAssertTrue(cartService.didRemoveProduct)
        XCTAssertEqual(cartService.removedProductID, "1")
    }

    func testProductDetailScreen() throws {
        viewModel.productDetailScreen(recipe: recipes[0])
        XCTAssertTrue(mockRouter.didShowScreen)
    }

    func testProductCountsUpdate() throws {
        let expectation = self.expectation(description: "Product counts updated")

        viewModel.$productCounts
            .dropFirst()
            .sink { counts in
                XCTAssertEqual(counts["1"], 1)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        cartService.productCounts = ["1": 1]

        waitForExpectations(timeout: 1, handler: nil)
    }
}
