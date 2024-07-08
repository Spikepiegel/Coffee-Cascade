//
//  CloseButtonImage.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 09.07.2024.
//

import SwiftUI

struct CloseButtonImage: View {
    let width: CGFloat
    let height: CGFloat
    let padding: CGFloat
    
    var body: some View {
        Image(systemName: "xmark")
            .resizable()
            .scaledToFit()
            .frame(width: width, height: height)
            .padding(padding)
            .background(Color.white.opacity(0.6))
            .clipShape(Circle())
            .foregroundStyle(.black)
    }
}
