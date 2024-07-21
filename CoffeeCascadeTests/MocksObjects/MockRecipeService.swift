//
//  MockRecipeService.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 21.07.2024.
//

import Foundation

final class MockRecipeService: IRecipeService {
    private let dataRepository: IDataRepository
    
    init(dataRepository: IDataRepository) {
        self.dataRepository = dataRepository
    }
    
    func getRecipes() async throws -> [Recipe] {
        let data = try await dataRepository.fetchData(from: URLRouter.recipe.path, method: .get)
        return try JSONDecoder().decode([Recipe].self, from: data)
    }
}
