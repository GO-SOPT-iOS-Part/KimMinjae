//
//  ModuleFactory.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/15.
//

import Foundation

protocol ModuleFactoryProtocol {
    func makeLoginViewController() -> LoginViewController
    func makeWelcomeViewController() -> WelcomeViewController

}

final class ModuleFactory: ModuleFactoryProtocol {
    static let shared = ModuleFactory()
    private init() {}

    func makeLoginViewController() -> LoginViewController {
        let useCase = LoginUseCase()
        let viewModel: LoginViewModel = DefaultLoginViewModel(useCase: useCase)
        let viewController = LoginViewController(viewModel: viewModel)
        return viewController
    }

    func makeWelcomeViewController() -> WelcomeViewController {
        let viewController = WelcomeViewController()
        return viewController
    }
}
