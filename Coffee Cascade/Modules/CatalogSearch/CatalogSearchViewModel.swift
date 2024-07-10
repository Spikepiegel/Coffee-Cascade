//
//  CatalogSearchViewModel.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 09.07.2024.
//

import Foundation

protocol ICatalogSearchViewModel: ObservableObject {
    var recipes: [Recipe] { get set }
    var categories: [String] { get set }
}

final class CatalogSearchViewModel: ICatalogSearchViewModel {
    // MARK: - Public Properties

    @Published var recipes: [Recipe]
    @Published var categories: [String]
    
    // MARK: - Initializers

    init(recipes: [Recipe], categories: [String]) {
        self.recipes = recipes
        self.categories = categories
    }
}
