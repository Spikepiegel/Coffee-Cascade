//
//  GestureHandlingView.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 08.07.2024.
//

import SwiftUI


struct GestureHandlingView<Content: View>: View {
    var content: () -> Content

    var body: some View {
        content()
            .contentShape(Rectangle())
    }
}
