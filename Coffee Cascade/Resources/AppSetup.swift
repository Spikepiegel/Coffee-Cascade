//
//  Coffee_CascadeApp.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 07.07.2024.
//

import SwiftUI

@main
struct AppSetup: App {
    var body: some Scene {
        WindowGroup {
            setupInitialView()
        }
    }
    
    @ViewBuilder
    private func setupInitialView() -> some View {
        let dataRepository: IDataRepository = DataRepository()
        let recipeService: IRecipeService = RecipeService(dataRepository: dataRepository)
        let viewModel = CatalogViewModel(recipeService: recipeService)
        CatalogView(viewModel: viewModel)
    }
}
