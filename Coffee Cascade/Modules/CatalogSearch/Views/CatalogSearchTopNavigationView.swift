//
//  CatalogSearchTopNavigationView.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 09.07.2024.
//

import SwiftUI

struct CatalogSearchTopNavigationView: View {
    var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image("arrow-back-icon")
                    .resizable()
                    .frame(width: 20, height: 14)
                    .foregroundColor(.pink)
            }
            Text("MENU POINT")
                .foregroundColor(.black)
                .font(.custom("Inter-SemiBold", size: 24))
            
            Spacer()
        }
    }
}
