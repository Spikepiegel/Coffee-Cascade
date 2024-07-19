//
//  Binding+Extension.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 20.07.2024.
//

import SwiftUI

extension Binding where Value == Int? {
    func unwrap(or defaultValue: Int) -> Binding<Int> {
        Binding<Int>(
            get: { self.wrappedValue ?? defaultValue },
            set: { newValue in self.wrappedValue = newValue }
        )
    }
}
