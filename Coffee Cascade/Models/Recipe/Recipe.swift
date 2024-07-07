//
//  Recipe.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 07.07.2024.
//

import Foundation
import UIKit
import SwiftUI

struct Recipe: Identifiable, Decodable {
    let id = UUID()
    let productID: String
    let name: String
    let image: String
    let description: String
    let recipeYield: String
    let datePublished: String
    let prepTime: String
    let totalTime: String
    let recipeIngredient: [String]
    let recipeInstructions: [Instruction]
    let category: String
    var imageData: Data?
    
    enum CodingKeys: String, CodingKey {
        case productID = "_id"
        case name
        case image
        case description
        case recipeYield
        case datePublished
        case prepTime
        case totalTime
        case recipeIngredient
        case recipeInstructions
        case category
    }
}
