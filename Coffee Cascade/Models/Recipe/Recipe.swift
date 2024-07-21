//
//  Recipe.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 07.07.2024.
//

import Foundation
import UIKit
import SwiftUI

struct Recipe: Identifiable, Decodable, Equatable, Hashable, Encodable {
    
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
    let volume: String = "400"
    let price: Double = 2.99
    
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
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(productID)
        hasher.combine(name)
        hasher.combine(image)
        hasher.combine(description)
        hasher.combine(recipeYield)
        hasher.combine(datePublished)
        hasher.combine(prepTime)
        hasher.combine(totalTime)
        hasher.combine(recipeIngredient)
        hasher.combine(recipeInstructions)
        hasher.combine(category)
        hasher.combine(imageData)
    }
    
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.productID == rhs.productID &&
               lhs.name == rhs.name &&
               lhs.image == rhs.image &&
               lhs.description == rhs.description &&
               lhs.recipeYield == rhs.recipeYield &&
               lhs.datePublished == rhs.datePublished &&
               lhs.prepTime == rhs.prepTime &&
               lhs.totalTime == rhs.totalTime &&
               lhs.recipeIngredient == rhs.recipeIngredient &&
               lhs.recipeInstructions == rhs.recipeInstructions &&
               lhs.category == rhs.category &&
               lhs.imageData == rhs.imageData
    }
}
