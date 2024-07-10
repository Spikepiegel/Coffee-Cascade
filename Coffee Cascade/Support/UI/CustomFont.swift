//
//  CustomFont.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 09.07.2024.
//

import SwiftUI

struct CustomFont {
    static func custom(_ customFont: FontName, size: CGFloat) -> Font {
        return Font.custom(customFont.rawValue, size: size)
    }

    enum FontName: String {
        case interLight = "Inter-Light"
        case interSemiBold = "Inter-SemiBold"
        case interBold = "Inter-Bold"
    }
}
