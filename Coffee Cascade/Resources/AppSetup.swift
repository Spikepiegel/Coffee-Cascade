//
//  Coffee_CascadeApp.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 07.07.2024.
//

import SwiftfulRouting
import SwiftUI

@main
struct AppSetup: App {
    var body: some Scene {
        WindowGroup {
            RouterAppView()
        }
    }
}

struct RouterAppView: View {
    var body: some View {
        RouterView(addNavigationView: true) { router in
            let dataRepository: IDataRepository = DataRepository()
            let recipeService: IRecipeService = RecipeService(dataRepository: dataRepository)
            let viewModel = CatalogViewModel(router: router, recipeService: recipeService)
            return CatalogView(viewModel: viewModel)
        }
    }
}
