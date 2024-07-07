//
//  CatalogBottomNavigator.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 07.07.2024.
//

import SwiftUI

struct CatalogBottomNavigator: View {
    var body: some View {
        HStack(spacing: 30) {
            Button(action: {
                // Действие для первой кнопки
            }) {
                Image("shop-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.gray)
                    .clipShape(Circle())
            }
            
            Button(action: {
                // Действие для второй кнопки
            }) {
                Image("search-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.gray)
                    .clipShape(Circle())
            }
        }
        .background(
            BlurView(style: .systemChromeMaterialDark)
                .padding([.top, .bottom], -8)
                .padding([.leading, .trailing], -15)
        )
    }
}


#Preview {
    CatalogBottomNavigator()
}
