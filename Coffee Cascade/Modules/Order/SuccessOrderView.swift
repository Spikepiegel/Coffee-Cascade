//
//  SuccessOrderView.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 20.07.2024.
//

import SwiftUI

struct SuccessOrderView<ViewModel: ISuccessOrderViewModel>: View {
    @StateObject
    var viewModel: ViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("The order has been successfully placed")
                .font(CustomFont.custom(.interBold, size: 26))
                .foregroundColor(.black)
                .padding(.horizontal, 30)
                .padding(.top, 20)
                .multilineTextAlignment(.center)

            Text("The most delicious coffee will be ready in 10-15 minutes")
                .font(CustomFont.custom(.interLight, size: 16))
                .foregroundColor(.gray)
                .padding(.horizontal, 30)
                .multilineTextAlignment(.center)
            
            
            Image("coffee-image")
                .resizable()
                .frame(width: 80, height: 120)
                .padding(.top, 15)
            
            Spacer()

            Button(action: { viewModel.closeScreen() }) {
                Text("Okay")
                    .font(CustomFont.custom(.interSemiBold, size: 20))
                    .foregroundColor(.black)
                    .frame(width: 250, height: 50)
                    .background(Color.white)
                    .cornerRadius(25)
            }
            .padding(.bottom, 20)
            .shadow(color: Color.black.opacity(0.1), radius: 3, x: 2, y: 2)
        }
        .padding(.horizontal, 20)
    }
}
