//
//  SuccessOrderViewModelTests.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 21.07.2024.
//

@testable import Coffee_Cascade
import SwiftfulRouting
import XCTest

final class SuccessOrderViewModelTests: XCTestCase {
    var viewModel: SuccessOrderViewModel!
    var mockRouter: MockRouter!
    var router: AnyRouter!

    override func setUpWithError() throws {
        mockRouter = MockRouter()
        router = AnyRouter(object: mockRouter)
        viewModel = SuccessOrderViewModel(router: router)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        router = nil
    }

    func testCloseScreen() throws {
        viewModel.closeScreen()
        XCTAssertTrue(mockRouter.didDismissScreen())
    }
}
