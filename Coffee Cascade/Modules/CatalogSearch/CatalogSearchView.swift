//
//  CatalogSearchView.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 09.07.2024.
//

import SwiftUI
import Kingfisher

struct CatalogSearchView<ViewModel: ICatalogSearchViewModel>: View {
    @StateObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var searchText = ""
    @State private var selectedRecipe: Recipe?

    var body: some View {
        VStack {
            CatalogSearchTopNavigationView(presentationMode: presentationMode)
                .padding()
                .background(Color.white)
            
            CatalogSearchBar(searchText: $searchText)
                .padding(.horizontal)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 170), spacing: 16)]) {
                    ForEach(viewModel.recipes.filter {
                        searchText.isEmpty ? true : $0.name.lowercased().contains(searchText.lowercased())
                    }) { recipe in
                        CoffeeSearchView(recipe: recipe)
                            .frame(width: 170, height: 250)
                            .onTapGesture {
                                selectedRecipe = recipe
                            }
                    }
                }
                .padding()
            }
            .padding()
            .fullScreenCover(item: $selectedRecipe) { recipe in
                ProductDetailView(recipe: recipe)
            }
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}
