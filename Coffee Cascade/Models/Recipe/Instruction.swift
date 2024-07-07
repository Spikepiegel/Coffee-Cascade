//
//  Instruction.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 07.07.2024.
//

import Foundation

struct Instruction: Decodable, Equatable, Hashable {
    let name: String
    let text: String
}
