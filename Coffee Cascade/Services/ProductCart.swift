//
//  ProductCart.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 18.07.2024.
//

import Combine
import Foundation
import SwiftUI

protocol IProductCart {
    func addProduct(_ product: Recipe)
    func removeProduct(withID id: String)
    func containsProduct(withID id: String) -> Bool
    func getAllProducts() -> [Recipe]
    func getCountOfProducts(withID id: String) -> Int

    var publishProducts: [Recipe] { get set }
    var productCounts: [String: Int] { get set }
}

final class ProductCart: IProductCart, ObservableObject {
    static let shared = ProductCart()

    private init() {
        setupBindings()
    }

    @Published
    var publishProducts: [Recipe] = []

    @Published
    var productCounts: [String: Int] = [:]

    private var cancellables = Set<AnyCancellable>()

    /// Add the product to the cart
    func addProduct(_ product: Recipe) {
        publishProducts.append(product)
    }

    /// Remove product from the cart by ID
    func removeProduct(withID id: String) {
        if let index = publishProducts.firstIndex(where: { $0.productID == id }) {
            publishProducts.remove(at: index)
        }
    }

    /// Check if the product is contained in the cart
    func containsProduct(withID id: String) -> Bool {
        publishProducts.contains { $0.productID == id }
    }

    /// Count of Product
    func getCountOfProducts(withID id: String) -> Int {
        publishProducts.filter { $0.productID == id }.count
    }
    
    /// Clear cart
    
    func clearCart() {
        publishProducts.removeAll()
    }

    /// Get all products from the cart
    func getAllProducts() -> [Recipe] {
        publishProducts
    }

    var publishProductsPublisher: AnyPublisher<[Recipe], Never> {
        $publishProducts.eraseToAnyPublisher()
    }

    private func setupBindings() {
        $publishProducts
            .sink { [weak self] products in
                self?.updateProductCounts(with: products)
            }
            .store(in: &cancellables)
    }

    private func updateProductCounts(with products: [Recipe]) {
        var counts: [String: Int] = [:]
        for product in products {
            counts[product.productID, default: 0] += 1
        }
        productCounts = counts
    }
}
