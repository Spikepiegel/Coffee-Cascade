//
//  CoffeeSearchView.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 12.07.2024.
//

import SwiftUI
import Kingfisher

struct CoffeeSearchView: View {
    let recipe: Recipe
    
    var body: some View {
        VStack {
            KFImage(URL(string: recipe.image))
                .resizable()
                .scaledToFill()
                .frame(width: 170, height: 120)
                .clipped()
                .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 10) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(recipe.name)
                        .font(CustomFont.custom(.interLight, size: 10))
                        .font(.headline)
                        .padding(.top, 4)
                    Text("\(recipe.volume) ml")
                        .font(CustomFont.custom(.interLight, size: 10))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                HStack {
                    Text("$ \(recipe.price)")
                        .font(CustomFont.custom(.interBold, size: 14))
                        .padding(.top, 2)
                    
                    Spacer()
                    
                    Button(action: {
                    }) {
                        Image("add-to-cart-icon")
                    }
                    .padding(.trailing, 5)
                }
            }
            .padding([.leading, .bottom], 8)
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 2)
    }
}
