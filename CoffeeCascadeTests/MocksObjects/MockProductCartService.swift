//
//  MockProductCartService.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 21.07.2024.
//

import Foundation

//final class MockProductCartService: IProductCart {
//    var didAddProduct = false
//    var didRemoveProduct = false
//    var addedProductID: String?
//    var removedProductID: String?
//
//    var publishProducts: [Recipe] = []
//    var productCounts: [String: Int] = [:]
//
//    func addProduct(_ product: Recipe) {
//        didAddProduct = true
//        addedProductID = product.productID
//        publishProducts.append(product)
//    }
//
//    func removeProduct(withID productID: String) {
//        didRemoveProduct = true
//        removedProductID = productID
//        if let index = publishProducts.firstIndex(where: { $0.productID == productID }) {
//            publishProducts.remove(at: index)
//        }
//    }
//
//    func containsProduct(withID productID: String) -> Bool {
//        publishProducts.contains { $0.productID == productID }
//    }
//
//    func getAllProducts() -> [Recipe] {
//        publishProducts
//    }
//
//    func getCountOfProducts(withID productID: String) -> Int {
//        publishProducts.filter { $0.productID == productID }.count
//    }
//}

final class MockProductCartService: IProductCart {
    var didAddProduct = false
    var didRemoveProduct = false
    var addedProductID: String?
    var removedProductID: String?
    
    @Published var publishProducts: [Recipe] = []
    @Published var productCounts: [String: Int] = [:]

    func addProduct(_ product: Recipe) {
        didAddProduct = true
        addedProductID = product.productID
        publishProducts.append(product)
        updateProductCounts()
    }

    func removeProduct(withID productID: String) {
        didRemoveProduct = true
        removedProductID = productID
        if let index = publishProducts.firstIndex(where: { $0.productID == productID }) {
            publishProducts.remove(at: index)
        }
        updateProductCounts()
    }

    func containsProduct(withID productID: String) -> Bool {
        publishProducts.contains { $0.productID == productID }
    }

    func getAllProducts() -> [Recipe] {
        publishProducts
    }

    func getCountOfProducts(withID productID: String) -> Int {
        publishProducts.filter { $0.productID == productID }.count
    }

    private func updateProductCounts() {
        var counts: [String: Int] = [:]
        for product in publishProducts {
            counts[product.productID, default: 0] += 1
        }
        productCounts = counts
    }
}
