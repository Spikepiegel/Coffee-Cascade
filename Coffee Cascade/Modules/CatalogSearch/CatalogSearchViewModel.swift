//
//  CatalogSearchViewModel.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 09.07.2024.
//

import Combine
import Foundation

protocol ICatalogSearchViewModel: ObservableObject {
    var recipes: [Recipe] { get set }
    var categories: [String] { get set }
    var productCounts: [String: Int] { get set }
    func addToCart(recipe: Recipe)
    func removeFromCart(recipe: Recipe)
}

final class CatalogSearchViewModel: ICatalogSearchViewModel {
    // MARK: - Public Properties

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

    init(recipes: [Recipe], categories: [String], productCartSerivce: IProductCart) {
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
