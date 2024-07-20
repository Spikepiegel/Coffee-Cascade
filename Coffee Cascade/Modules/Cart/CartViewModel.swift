//
//  CartViewModel.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 20.07.2024.
//

import Combine
import SwiftfulRouting
import SwiftUI

protocol ICartViewModel: ObservableObject {
    func closeCart()
    func addToCart(recipe: Recipe)
    func removeFromCart(recipe: Recipe)

    var totalPrice: Double { get }
    var priceFreeShipping: Double { get }
    var products: [Recipe] { get set }
    var productCounts: [String: Int] { get set }
    var paymentConfirmed: Bool { get set }
}

final class CartViewModel: ICartViewModel {
    // MARK: - Public Properties

    let router: AnyRouter

    var priceFreeShipping: Double = 15

    @Published
    var totalPrice: Double = 0
    @Published
    var products: [Recipe] = []
    @Published
    var paymentConfirmed = false

    @Published
    var productCounts: [String: Int] = [:]
    
    var paymentFinished: (() -> Void)?

    // MARK: - Private Properties

    private var cartService = ProductCart.shared
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initializers

    init(router: AnyRouter, paymentFinished: (() -> Void)?) {
        self.router = router
        self.paymentFinished = paymentFinished
        
        setupBindings()
    }

    // MARK: - Public Methods

    func closeCart() {
        router.dismissScreen()
    }

    func addToCart(recipe: Recipe) {
        cartService.addProduct(recipe)
    }

    func removeFromCart(recipe: Recipe) {
        cartService.removeProduct(withID: recipe.productID)
    }

    // MARK: - Private Methods

    private func setupBindings() {
        cartService.$publishProducts
            .receive(on: RunLoop.main)
            .sink { [weak self] products in
                let totalPrice = products.map(\.price).reduce(0, +)
                self?.totalPrice = totalPrice
            }
            .store(in: &cancellables)

        cartService.$publishProducts
            .receive(on: RunLoop.main)
            .sink { [weak self] products in
                self?.products = products
            }
            .store(in: &cancellables)

        cartService.$productCounts
            .receive(on: RunLoop.main)
            .sink { [weak self] dict in
                self?.productCounts = dict
            }
            .store(in: &cancellables)
        
        $paymentConfirmed
            .receive(on: RunLoop.main)
            .sink { [weak self] paymentConfirmed in
                if paymentConfirmed {
                    self?.paymentFinished?()
                    self?.router.dismissScreen()
                }
            }
            .store(in: &cancellables)
    }
}
