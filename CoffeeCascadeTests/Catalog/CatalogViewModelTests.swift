//
//  CatalogViewModelTests.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 21.07.2024.
//

import XCTest
import Combine
@testable import Coffee_Cascade
import SwiftfulRouting

final class CatalogViewModelTests: XCTestCase {

    var viewModel: CatalogViewModel!
    var mockRouter: MockRouter!
    var router: AnyRouter!
    var mockDataRepository: MockDataRepository!
    var recipeService: MockRecipeService!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        mockRouter = MockRouter()
        router = AnyRouter(object: mockRouter)
        mockDataRepository = MockDataRepository()
        recipeService = MockRecipeService(dataRepository: mockDataRepository)
        viewModel = CatalogViewModel(router: router, recipeService: recipeService)
        cancellables = []
    }

    override func tearDownWithError() throws {
        viewModel = nil
        router = nil
        mockDataRepository = nil
        recipeService = nil
        cancellables = nil
    }

    func testInitialization() throws {
        XCTAssertTrue(viewModel.recipes.isEmpty)
        XCTAssertTrue(viewModel.categories.isEmpty)
        XCTAssertNil(viewModel.selectedCategory)
        XCTAssertTrue(viewModel.filteredRecipes.isEmpty)
    }

    func testOnAppear() async throws {
        await viewModel.onAppear()
        XCTAssertEqual(viewModel.recipes.count, 2)
        XCTAssertEqual(viewModel.categories.count, 1)
        XCTAssertEqual(viewModel.categories.first, "Hot Drinks")
    }

    func testProductDetailScreen() async throws {
        await viewModel.productDetailScreen(recipe: try recipeService.getRecipes().first!)
        XCTAssertTrue(mockRouter.didShowScreen)
    }

    func testOpenCartView() throws {
        viewModel.openCartView()
        XCTAssertTrue(mockRouter.didShowScreen)
    }

    func testFilteredRecipes() async throws {
        viewModel.recipes = try await recipeService.getRecipes()
        viewModel.selectedCategory = "Hot Drinks"
        
        XCTAssertEqual(viewModel.filteredRecipes.count, 2)
        
        viewModel.selectedCategory = "Non-existent category"
        
        XCTAssertEqual(viewModel.filteredRecipes.count, 0)
    }
}
