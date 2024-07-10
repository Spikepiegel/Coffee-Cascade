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
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150, maximum: 200), spacing: 16)]) {
                    ForEach(viewModel.recipes.filter {
                        searchText.isEmpty ? true : $0.name.lowercased().contains(searchText.lowercased())
                    }) { recipe in
                        VStack {
                            KFImage(URL(string: recipe.image))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 200)
                                .clipped()
                                .cornerRadius(12)
                            Text(recipe.name)
                                .font(CustomFont.custom(.interSemiBold, size: 14))
                                .padding(.top, 8)
                        }
                        .frame(width: 150, height: 250) // Устанавливаем фиксированные размеры для ячеек
                        .background(Color.white)
                        .cornerRadius(12) // Закругление углов для всей ячейки
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2) // Тень для ячеек
                        .onTapGesture {
                            selectedRecipe = recipe
                        }
                    }
                }
                .padding()
            }
            .fullScreenCover(item: $selectedRecipe) { recipe in
                ProductDetailView(recipe: recipe)
            }
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}
