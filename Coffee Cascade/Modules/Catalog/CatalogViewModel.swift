//
//  CatalogViewModel.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 07.07.2024.
//

import Combine
import Foundation
import SwiftfulRouting
import SwiftUI

protocol ICatalogViewModel: ObservableObject {
    func onAppear() async
    func productDetailScreen(recipe: Recipe)
    func openCartView()

    var recipes: [Recipe] { get set }
    var categories: [String] { get set }
    var selectedCategory: String? { get set }
    var filteredRecipes: [Recipe] { get set }
    var router: AnyRouter { get }
}

final class CatalogViewModel: ICatalogViewModel {
    // MARK: - Public Properties

    let router: AnyRouter
    @Published
    var recipes: [Recipe] = []
    @Published
    var categories: [String] = []
    @Published
    var selectedCategory: String? = nil
    @Published
    var filteredRecipes: [Recipe] = []

    // MARK: - Private Properties

    private var cancellables = Set<AnyCancellable>()
    private let recipeService: IRecipeService
    private let cartService = ProductCart.shared

    // MARK: - Initializers

    init(router: AnyRouter, recipeService: IRecipeService) {
        self.router = router
        self.recipeService = recipeService
    }

    // MARK: - Public Methods

    func onAppear() async {
        await getData()
        setupBindings()
    }

    func productDetailScreen(recipe: Recipe) {
        router.showScreen(.fullScreenCover) { router in
            let vm = ProductDetailsViewModel(router: router, recipe: recipe)
            ProductDetailView(viewModel: vm)
        }
    }

    func openCartView() {
        router.showScreen(.fullScreenCover) { router in
            let vm = CartViewModel(router: router, paymentFinished: { [weak self] in
                self?.cartService.clearCart()

                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self?.openSuccessOrderScreen()
                }
            })
            CartView(viewModel: vm)
        }
    }

    private func openSuccessOrderScreen() {
        router.showResizableSheet(
            sheetDetents: [.medium],
            selection: nil,
            showDragIndicator: false
        ) { router in
            let vm = SuccessOrderViewModel(router: router)
            return SuccessOrderView(viewModel: vm)
        }
    }

    // MARK: - Private Methods

    private func setupBindings() {
        $selectedCategory
            .receive(on: DispatchQueue.main)
            .combineLatest($recipes)
            .map { selectedCategory, recipes in
                guard let selectedCategory else {
                    return recipes
                }
                return recipes.filter { $0.category == selectedCategory }
            }
            .assign(to: &$filteredRecipes)
    }

    private func getData() async {
        do {
            let recipes = try await recipeService.getRecipes()
            await MainActor.run {
                self.recipes = recipes
                self.categories = Array(Set(recipes.map(\.category))).sorted()
            }
        } catch {
            print("Error fetching data: \(error)")
        }
    }
}
