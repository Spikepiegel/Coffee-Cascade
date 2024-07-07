//
//  RecipeScrollView.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 07.07.2024.
//

import SwiftUI
import Kingfisher

struct RecipeScrollView: View {
    @Binding 
    var recipes: [Recipe]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16) {
                ForEach($recipes) { $recipe in
                    VStack {
                        ZStack {
                            CoffeeView(image: recipe.image)
                        }
                        .containerRelativeFrame(.horizontal)
                        .clipShape(RoundedRectangle(cornerRadius: 36))
                        Text(recipe.name)
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .contentMargins(25)
        .scrollTargetBehavior(.paging)
    }
}

