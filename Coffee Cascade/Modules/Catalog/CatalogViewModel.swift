//
//  CatalogViewModel.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 07.07.2024.
//

import Foundation
import Combine
import SwiftUI

protocol ICatalogViewModel: ObservableObject {
    func onAppear() async
    
    var recipes: [Recipe] { get set }
    var categories: [String] { get set }
    var selectedCategory: String? { get set }
    var filteredRecipes: [Recipe] { get set }
}

final class CatalogViewModel: ICatalogViewModel {
    
    // MARK: - Public Properties
    
    @Published var recipes: [Recipe] = []
    @Published var categories: [String] = []
    @Published var selectedCategory: String? = nil
    @Published var filteredRecipes: [Recipe] = []
    
    // MARK: - Private Properties

    private var cancellables = Set<AnyCancellable>()
    private let recipeService: IRecipeService
    
    // MARK: - Initializers

    init(recipeService: IRecipeService) {
        self.recipeService = recipeService
    }
    
    // MARK: - Public Methods
    
    func onAppear() async {
        await getData()
        setupBindings()
    }
    
    // MARK: - Private Methods
    
    private func setupBindings() {
        $selectedCategory
            .receive(on: DispatchQueue.main)
            .combineLatest($recipes)
            .map { selectedCategory, recipes in
                guard let selectedCategory = selectedCategory else {
                    return recipes
                }
                return recipes.filter { $0.category == selectedCategory }
            }
            .assign(to: &$filteredRecipes)
    }
    
    private func getData() async {
        do {
            let recipes = try await recipeService.getRecipes()
            await MainActor.run {
                self.recipes = recipes
                self.categories = Array(Set(recipes.map { $0.category })).sorted()
            }
        } catch {
            print("Error fetching data: \(error)")
        }
    }

}
