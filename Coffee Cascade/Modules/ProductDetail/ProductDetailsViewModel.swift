//
//  ProductDetailsViewModel.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 18.07.2024.
//

import Combine
import SwiftUI

protocol IProductDetailsViewModel: ObservableObject {
    var recipe: Recipe { get }
    var isCartEmpty: Bool { get set }
    var countOfProducts: Int { get set }
    func addToCart()
    func removeFromCart()
}

final class ProductDetailsViewModel: IProductDetailsViewModel {
    // MARK: Public Properties

    var recipe: Recipe

    @Published
    var countOfProducts = 0

    @Published
    var isCartEmpty = true

    // MARK: Private Properties

    private var cartService = ProductCart.shared

    private var cancellables = Set<AnyCancellable>()

    // MARK: Initializers

    init(recipe: Recipe) {
        self.recipe = recipe
        setupBindings()
    }

    // MARK: - Public Methods

    func addToCart() {
        cartService.addProduct(recipe)
        print(cartService.getAllProducts)
    }

    func removeFromCart() {
        cartService.removeProduct(withID: recipe.productID)
        print(cartService.getAllProducts)
    }

    // MARK: - Private Methods

    private func setupBindings() {
        cartService.$publishProducts
            .receive(on: RunLoop.main)
            .map(\.isEmpty)
            .assign(to: \.isCartEmpty, on: self)
            .store(in: &cancellables)

        cartService.$publishProducts
            .receive(on: RunLoop.main)
            .map { [weak self] products in
                self?.cartService.getCountOfProducts(withID: self?.recipe.productID ?? "") ?? 0
            }
            .assign(to: \.countOfProducts, on: self)
            .store(in: &cancellables)
    }
}
