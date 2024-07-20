//
//  RecipeService.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 07.07.2024.
//

import Foundation
import SwiftUI

protocol IRecipeService {
    func getRecipes() async throws -> [Recipe]
}

final class RecipeService: IRecipeService {
    
    // MARK: - Private Properties

    private let dataRepository: IDataRepository
    
    // MARK: - Initializers

    init(dataRepository: IDataRepository) {
        self.dataRepository = dataRepository
    }
    
    // MARK: - Public methods
    
    func getRecipes() async throws -> [Recipe] {
        let data = try await dataRepository.fetchData(from: URLRouter.recipe.path, method: .get)
        return try JSONDecoder().decode([Recipe].self, from: data)
    }
    
    // MARK: - Private methods
    
    /// Метод загрузки всех сразу картинок, прост чтобы было, для скролла пагинируем
    private func loadImages(for recipes: inout [Recipe]) async throws {
        try await withThrowingTaskGroup(of: (Int, Data?).self) { group in
            for (index, recipe) in recipes.enumerated() {
                group.addTask {
                    let data = try await self.loadImageData(from: recipe.image)
                    return (index, data)
                }
            }
            
            for try await (index, data) in group {
                recipes[index].imageData = data
            }
        }
    }
    
    private func loadImageData(from urlString: String) async throws -> Data? {
        guard let url = URL(string: urlString) else { return nil }
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}
