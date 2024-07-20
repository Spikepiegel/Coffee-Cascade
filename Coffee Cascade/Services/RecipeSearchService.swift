//
//  RecipeSearchService.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 09.07.2024.
//

import Foundation
import SwiftUI

protocol IRecipeSearchService {
    func searchRecipe() async throws -> [Recipe]
}

final class RecipeSearchService: IRecipeSearchService {
    // MARK: - Private Properties

    private let dataRepository: IDataRepository
    
    // MARK: - Initializers

    init(dataRepository: IDataRepository) {
        self.dataRepository = dataRepository
    }
    
    // MARK: - Public methods
    
    func searchRecipe() async throws -> [Recipe] {
        let data = try await dataRepository.fetchData(from: URLRouter.recipe.path, method: .get)
        return try JSONDecoder().decode([Recipe].self, from: data)
    }
}
