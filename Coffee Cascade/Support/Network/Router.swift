//
//  File.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 07.07.2024.
//

import Foundation

enum URLRouter {
    case recipe
    
    var path: String {
        switch self {
        case .recipe: return "recipes"
        }
    }
}
