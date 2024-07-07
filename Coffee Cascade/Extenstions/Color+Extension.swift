//
//  Color+Extension.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 07.07.2024.
//

import SwiftUI

extension Color {
    
    static func custom(_ custom: CustomColor) -> Color {
        Color(custom.name)
    }
    
}
