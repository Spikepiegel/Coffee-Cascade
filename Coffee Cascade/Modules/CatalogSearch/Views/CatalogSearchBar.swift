//
//  CatalogSearchBar.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 10.07.2024.
//

import SwiftUI

struct CatalogSearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            TextField("Find your favorite coffee", text: $searchText)
                .font(CustomFont.custom(.interSemiBold, size: 12))
                .padding(8)
                .padding(.leading, 28)
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .overlay(
                    HStack {
                        Image("search-icon")
                            .frame(width: 16, height: 16)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 12)
                        Spacer()
                    }
                )
        }
    }
}
