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
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .overlay(
                            Capsule()
                                .stroke(category == selectedCategory ? Color.red : Color.clear, lineWidth: 2)
                        )
                        .onTapGesture {
                            selectedCategory = category == selectedCategory ? nil : category
                        }
                }
            }
            .padding(.horizontal)
        }
    }
}


//struct CategoriesScrollView: View {
//    @Binding var categories: [String]
//    @Binding var selectedCategory: String?
//    
//    var body: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            LazyHStack(spacing: 10) {
//                ForEach(categories, id: \.self) { category in
//                    Text(category)
//                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .clipShape(Capsule())
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 16)
//                                .stroke(category == selectedCategory ? Color.black : Color.clear, lineWidth: 2)
//                        )
//                        .onTapGesture {
//                            selectedCategory = category == selectedCategory ? nil : category
//                        }
//                }
//            }
//            .padding(.horizontal)
//        }
//    }
//}
