//
//  ProductDetailView.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 08.07.2024.
//

import SwiftUI
import Kingfisher

struct ProductDetailView: View {
    var recipe: Recipe
    @Environment(\.presentationMode) var presentationMode
    @State private var offset: CGFloat = 0
    @State private var isDragging: Bool = false
    @GestureState private var dragState = DragState.inactive

    var body: some View {
        ZStack(alignment: .topTrailing) {
            KFImage(URL(string: recipe.image))
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .clipped()
                .edgesIgnoringSafeArea([.top, .bottom])

            VStack {
                Spacer()
                
                DetailScrollContent(recipe: recipe)
                    .cornerRadius(20)
                    .offset(y: self.offset)
            }
        }
    }
}

