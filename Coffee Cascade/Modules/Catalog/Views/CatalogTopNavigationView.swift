//
//  CatalogTopNavigationView.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 09.07.2024.
//

import SwiftUI

struct CatalogTopNavigationView: View {
    var body: some View {
        HStack {
            Text("MENU POINT")
                .foregroundStyle(.black)
                .font(CustomFont.custom(.interSemiBold, size: 24))
            
            Spacer()
            
            Button(action: {
                // Действие для второй кнопки
            }) {
                Image("nav-search-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 26, height: 26)
                    .foregroundColor(.white)
                    .padding()
            }
        }
        .padding(.leading, 20)
    }
}
