//
//  CategoriesScrollView.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 07.07.2024.
//

import SwiftUI

struct CategoriesScrollView: View {
    @Binding var categories: [String]
    @Binding var selectedCategory: String?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(categories, id: \.self) { category in
                    Text(category)
                        .font(CustomFont.custom(.interLight, size: 12))
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(category == selectedCategory ? Color.custom(.darkGrayComponent) : Color.custom(.grayComponent))
                        .foregroundColor(category == selectedCategory ? Color.white : Color.black)
                        .clipShape(Capsule())
                        .onTapGesture {
                            selectedCategory = category == selectedCategory ? nil : category
                        }
                }
            }
            .padding(.horizontal)
        }
    }
}
