//
//  SuccessOrderViewModel.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 20.07.2024.
//

import SwiftfulRouting
import SwiftUI

protocol ISuccessOrderViewModel: ObservableObject {
    func closeScreen()
}

final class SuccessOrderViewModel: ISuccessOrderViewModel {
    // MARK: - Private Properties

    private let router: AnyRouter
    
    // MARK: - Initializers

    init(router: AnyRouter) {
        self.router = router
    }
    
    // MARK: - Public Methods
    
    func closeScreen() {
        router.dismissScreen()
    }
}
