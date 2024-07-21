//
//  Instruction.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 07.07.2024.
//

import Foundation

struct Instruction: Decodable, Equatable, Hashable, Encodable {
    let name: String
    let text: String
}
