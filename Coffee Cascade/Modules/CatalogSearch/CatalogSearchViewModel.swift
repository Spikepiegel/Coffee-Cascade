//
//  CatalogSearchViewModel.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 09.07.2024.
//

import Combine
import Foundation
import SwiftfulRouting

protocol ICatalogSearchViewModel: ObservableObject {
    var recipes: [Recipe] { get set }
    var categories: [String] { get set }
    var productCounts: [String: Int] { get set }
    func addToCart(recipe: Recipe)
    func removeFromCart(recipe: Recipe)
    func productDetailScreen(recipe: Recipe)
}

final class CatalogSearchViewModel: ICatalogSearchViewModel {
    // MARK: - Public Properties
    
    let router: AnyRouter
    let productCartSerivce: IProductCart

    // MARK: - Private Properties

    private var cartService = ProductCart.shared
    private var cancellables = Set<AnyCancellable>()

    @Published
    var recipes: [Recipe]
    @Published
    var categories: [String]
    @Published
    var productCounts: [String: Int] = [:]

    // MARK: - Initializers

    init(router: AnyRouter, recipes: [Recipe], categories: [String], productCartSerivce: IProductCart) {
        self.router = router
        self.recipes = recipes
        self.categories = categories
        self.productCartSerivce = productCartSerivce

        setupBindings()
    }
    
    // MARK: - Public Methods

    func addToCart(recipe: Recipe) {
        cartService.addProduct(recipe)
        print(cartService.getAllProducts)
    }

    func removeFromCart(recipe: Recipe) {
        cartService.removeProduct(withID: recipe.productID)
        print(cartService.getAllProducts)
    }
    
    func productDetailScreen(recipe: Recipe) {
        router.showScreen(.fullScreenCover) { router in
            let vm = ProductDetailsViewModel(router: router, recipe: recipe)
            ProductDetailView(viewModel: vm)
        }
    }

    // MARK: - Private Methods

    private func setupBindings() {
        cartService.$productCounts
            .receive(on: RunLoop.main)
            .sink { [weak self] dict in
                self?.productCounts = dict
            }
            .store(in: &cancellables)
    }
}
