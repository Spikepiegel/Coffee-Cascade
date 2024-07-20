//
//  CartView.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 20.07.2024.
//

import SwiftUI

struct CartView<ViewModel: ICartViewModel>: View {
    @StateObject
    var viewModel: ViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
