//
//  DragState.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 09.07.2024.
//

import Foundation

struct DragState {
    var translation: CGSize
    var isDragging: Bool

    static var inactive: DragState {
        DragState(translation: .zero, isDragging: false)
    }

    static func dragging(translation: CGSize) -> DragState {
        DragState(translation: translation, isDragging: true)
    }
}
