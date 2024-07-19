//
//  DetailScrollOverlayContent.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 09.07.2024.
//

import SwiftUI

struct DetailScrollOverlayContent: View {
    let recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                Text(recipe.name)
                    .foregroundStyle(.white)
                    .font(CustomFont.custom(.interBold, size: 24))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.leading, .trailing], 15)
                
                Text(recipe.description)
                    .foregroundStyle(.white)
                    .font(CustomFont.custom(.interSemiBold, size: 18))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.leading, .trailing], 15)
                
                Text("Ingredients")
                    .foregroundStyle(.white)
                    .font(CustomFont.custom(.interBold, size: 24))
                    .frame(maxWidth: .infinity, alignment: .center)
                
                DetailRecipeIngredientView(recipeIngredients: recipe.recipeIngredient)
                
                Text("Recipe Instructions")
                    .foregroundStyle(.white)
                    .font(CustomFont.custom(.interBold, size: 24))
                    .frame(maxWidth: .infinity, alignment: .center)
                
                DetailsRecipeInstructionsView(recipeInstruction: recipe.recipeInstructions)
                
                
                Spacer(minLength: 50)
            }
            
            Spacer(minLength: 20)
        }
    }
}
