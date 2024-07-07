//
//  MockCatalogViewModel.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 07.07.2024.
//

import Foundation

import SwiftUI
import Combine

final class MockCatalogViewModel: ICatalogViewModel {
    @Published var recipes: [Recipe] = []
    @Published var categories: [String] = []
    @Published var selectedCategory: String? = nil
    @Published var filteredRecipes: [Recipe] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        mockData()
        
        $selectedCategory
            .combineLatest($recipes)
            .map { selectedCategory, recipes in
                guard let selectedCategory = selectedCategory else {
                    return recipes
                }
                return recipes.filter { $0.category == selectedCategory }
            }
            .assign(to: &$filteredRecipes)
    }
    
    func onAppear() async {}
    
    private func mockData() {
        recipes = [
            Recipe(
                productID: "6681b8d94507f78afe801839",
                name: "Nutty Dark Chocolate Cold Brew",
                image: "https://athome.starbucks.com/sites/default/files/2024-05/OTHC-P00122733_COLD_ChocolateHazelnut_2880x1660_0.png",
                description: "Dark chocolate and hazelnut make the perfect pairing.",
                recipeYield: "1",
                datePublished: "Mon, 05/06/2024 - 22:15",
                prepTime: "PT2M",
                totalTime: "PT2M",
                recipeIngredient: [
                    "6 oz Starbucks® Dark Chocolate Hazelnut Cold Brew Concentrate",
                    "6 oz water",
                    "1 Tbsp Vanilla Syrup",
                    "Ice",
                    "2 oz almondmilk (or your choice of milk)"
                ],
                recipeInstructions: [
                    Instruction(name: "STEP 01", text: "In a large glass, stir together 6 oz of Starbucks® Dark Chocolate Hazelnut Cold Brew Concentrate 6 oz of water, and 1-2 oz Vanilla Syrup."),
                    Instruction(name: "STEP 02", text: "Add enough ice to fill the glass to ½ inch below the rim, leaving room for milk."),
                    Instruction(name: "STEP 03", text: "Top with your desired amount of almondmilk.")
                ],
                category: "ICED BEVERAGES"
            ),
            Recipe(
                productID: "6681b8d94507f78afe801838",
                name: "Vanilla Iced Coffee With Cake Batter Foam",
                image: "https://athome.starbucks.com/sites/default/files/2024-05/OTHC-P00122733_COLD_VanillaCakeBatter_RecipeHeader_0.png",
                description: "Turn any day into a special occasion. This Vanilla Iced Coffee with Cake Batter Foam packs all the delicious nostalgia of your favorite cake into each easy glass.",
                recipeYield: "1 serving",
                datePublished: "Mon, 05/06/2024 - 20:52",
                prepTime: "PT4M",
                totalTime: "PT4M",
                recipeIngredient: [
                    "6 oz Starbucks® Iced Coffee Blend coffee, brewed according to instructions",
                    "1 Tbsp Vanilla Syrup",
                    "1 Tbsp Starbucks® Vanilla Flavored Creamer",
                    "Ice",
                    "3 Tbsp 2% milk",
                    "0.25 tsp cake batter flavored extract (or ½ tsp butter flavored extract and ½ tsp almond extract)*​"
                ],
                recipeInstructions: [
                    Instruction(name: "STEP 01", text: "Fill a 16-oz tumbler (glass not recommended) with ice, about ¾ of the way."),
                    Instruction(name: "STEP 02", text: "Brew Starbucks® Vanilla Iced Coffee Blend K-Cup® Pod (as directed) into the tumbler using the 6-oz iced setting on the brewer. Use the strong or iced button if available. Or, if using Starbucks® Iced Coffee Blend Ground Coffee, brew 3 Tbsp coffee grounds per 6 oz of water in your brewer of choice. Pour coffee into the tumbler."),
                    Instruction(name: "STEP 03", text: "Using any cold frothing method, froth together Starbucks® Vanilla Flavored Creamer, milk and desired flavored extracts."),
                    Instruction(name: "STEP 04", text: "Add as much or as little foam as you desire to the top of your drink.​")
                ],
                category: "ICED BEVERAGES"
            )
        ]
        
        categories = ["ICED BEVERAGES", "HOT BEVERAGES", "FRAPPUCCINO"]
    }
}
