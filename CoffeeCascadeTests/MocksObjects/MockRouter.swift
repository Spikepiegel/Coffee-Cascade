//
//  MockRouter.swift
//  Coffee Cascade
//
//  Created by Николай Лермонтов on 21.07.2024.
//

import SwiftfulRouting
import SwiftUI

final class MockRouter: Router {
    var didShowScreen = false

    func enterScreenFlow(_ routes: [AnyRoute]) {
        didShowScreen = true
    }

    func showNextScreen() throws {
        didShowScreen = true
    }

    func dismissScreen() {
        didShowScreen = true
    }

    func dismissEnvironment() {
        didShowScreen = true
    }

    func dismissScreenStack() {
        didShowScreen = true
    }

    func pushScreenStack(destinations: [PushRoute]) {
        didShowScreen = true
    }

    func showResizableSheet(
        sheetDetents: Set<PresentationDetentTransformable>,
        selection: Binding<PresentationDetentTransformable>?,
        showDragIndicator: Bool,
        onDismiss: (() -> Void)?,
        destination: @escaping (AnyRouter) -> some View
    ) {
        didShowScreen = true
    }

    func showAlert(
        _ option: DialogOption,
        title: String,
        subtitle: String?,
        alert: @escaping () -> some View,
        buttonsiOS13: [Alert.Button]?
    ) {
        didShowScreen = true
    }

    func dismissAlert() {
        didShowScreen = true
    }

    func showModal(
        id: String? = nil,
        transition: AnyTransition,
        animation: Animation,
        alignment: Alignment,
        backgroundColor: Color?,
        ignoreSafeArea: Bool,
        destination: @escaping () -> some View
    ) {
        didShowScreen = true
    }

    func dismissModal(id: String? = nil) {
        didShowScreen = true
    }

    func dismissAllModals() {
        didShowScreen = true
    }

    func showSafari(_ url: @escaping () -> URL) {
        didShowScreen = true
    }
    
    func didDismissScreen() -> Bool {
        return true
    }
}
