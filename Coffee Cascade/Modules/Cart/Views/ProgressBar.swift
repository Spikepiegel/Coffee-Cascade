//
//  ProgressBar.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 20.07.2024.
//

import SwiftUI

struct ProgressBar: View {
    var value: Double

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color.custom(.progressBarGray))

                Rectangle().frame(
                    width: min(CGFloat(self.value) * geometry.size.width, geometry.size.width),
                    height: geometry.size.height
                )
                .foregroundColor(Color.custom(.progressBarGreen))
                .animation(.linear, value: value)
            }
        }
    }
}
