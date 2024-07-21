//
//  MockDataRepository.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 21.07.2024.
//

import Foundation

final class MockDataRepository: IDataRepository {
    func fetchData(from path: String, method: HTTPMethod) async throws -> Data {
        let recipes = [
            Recipe(productID: "1", name: "Espresso", image: "espresso.jpg", description: "Strong coffee", recipeYield: "1 cup", datePublished: "2023-01-01", prepTime: "5 min", totalTime: "5 min", recipeIngredient: ["coffee"], recipeInstructions: [], category: "Hot Drinks"),
            Recipe(productID: "2", name: "Latte", image: "latte.jpg", description: "Coffee with milk", recipeYield: "1 cup", datePublished: "2023-01-02", prepTime: "10 min", totalTime: "10 min", recipeIngredient: ["coffee", "milk"], recipeInstructions: [], category: "Hot Drinks")
        ]
        return try JSONEncoder().encode(recipes)
    }
}
