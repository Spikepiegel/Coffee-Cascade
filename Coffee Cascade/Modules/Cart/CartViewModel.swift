//
//  CartViewModel.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 20.07.2024.
//

import SwiftfulRouting
import SwiftUI

protocol ICartViewModel: ObservableObject {}

final class CartViewModel: ICartViewModel {
    // MARK: - Public Properties

    let router: AnyRouter
    
    // MARK: - Private Properties

    private var cartService = ProductCart.shared

    // MARK: - Initializers

    init(router: AnyRouter) {
        self.router = router
    }
}
