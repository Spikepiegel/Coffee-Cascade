//
//  DetailsRecipeInstructionsView.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 09.07.2024.
//

import SwiftUI

struct DetailsRecipeInstructionsView: View {
    let recipeInstruction: [Instruction]
    
    var body: some View {
        VStack(spacing: 7) {
            ForEach(Array(recipeInstruction.enumerated()), id: \.element) { index, instruction in
                HStack(alignment: .top) {
                    Text("\(index + 1).")
                        .font(.headline)
                        .padding(.trailing, 5)
                    
                    VStack(alignment: .leading) {
                        Text(instruction.text)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.vertical, 5)
                .foregroundStyle(.white)
                .cornerRadius(8)
            }
        }
    }
}
