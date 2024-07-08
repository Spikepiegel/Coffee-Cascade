//
//  DetailRecipeIngredientView.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 09.07.2024.
//

import SwiftUI

struct DetailRecipeIngredientView: View {
    let recipeIngredients: [String]
    
    var body: some View {
        VStack(spacing: 7) {
            ForEach(Array(recipeIngredients.enumerated()), id: \.element) { index, ingredient in
                HStack(alignment: .top) {
                    Text("\(index + 1).")
                        .font(.headline)
                        .padding(.trailing, 5)
                    
                    VStack(alignment: .leading) {
                        Text(ingredient)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.vertical, 5)
                .foregroundStyle(.white)
                .cornerRadius(8)
            }
        }
    }
}
