//
//  ModuleFactory.swift
//  SOPT-32st-Assignment
//
//  Created by 김민재 on 2023/04/07.
//

import Foundation

protocol ModuleFactoryProtocol {
    func makeFirstViewController() -> ViewController
    func makeSecondViewController() -> SecondViewController
    
}

final class ModuleFactory: ModuleFactoryProtocol {
    static let shared = ModuleFactory()
    private init() {}

    func makeFirstViewController() -> ViewController {
        let viewModel: FirstViewModel = DefaultFirstViewModel()
        let viewController = ViewController(viewModel: viewModel)
        return viewController
    }

    func makeSecondViewController() -> SecondViewController {
        let secondViewController = SecondViewController()
        return secondViewController
    }
}
