//
//  ModuleFactory.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/15.
//

import UIKit

protocol ModuleFactoryProtocol {
    func makeLoginViewController() -> UIViewController
    func makeWelcomeViewController() -> UIViewController
    func makeMyPageViewController() -> UIViewController
    func makeMainHomeViewController() -> UIViewController
    func makeHomeViewController() -> UIViewController
}

final class ModuleFactory: ModuleFactoryProtocol {
    static let shared = ModuleFactory()
    private init() {}

    func makeLoginViewController() -> UIViewController {
        let useCase = DefaultLoginUseCase()
        let viewModel: LoginViewModel = DefaultLoginViewModel(useCase: useCase)
        let viewController = LoginViewController(viewModel: viewModel)
        return viewController
    }

    func makeWelcomeViewController() -> UIViewController {
        let viewController = WelcomeViewController()
        return viewController
    }

    func makeMyPageViewController() -> UIViewController {
        let viewModel = MyPageViewModel()
        let viewController = MyPageViewController(viewModel: viewModel)
        return viewController
    }

    func makeMainHomeViewController() -> UIViewController {
        let viewController = MainHomeViewController()
        return viewController
    }

    func makeHomeViewController() -> UIViewController {
        let repository = DefaultMovieRespository(networkService: BaseService.shared)
        let useCase = DefaultMovieUseCase(repository: repository)
        let viewModel = DefaultMainHomeViewModel(useCase: useCase)
        let viewController = HomeViewController(viewModel: viewModel)
        return viewController
    }
}
