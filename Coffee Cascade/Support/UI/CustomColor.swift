//
//  CustomColor.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 07.07.2024.
//

import Foundation
import SwiftUI

enum CustomColor: String {
    case mainTopGradient = "MainTopGradient"
    case mainBottomGradient = "MainBottomGradient"
    case categoryColor = "CategoryColor"
    
    var name: String {
        return self.rawValue
    }
}
