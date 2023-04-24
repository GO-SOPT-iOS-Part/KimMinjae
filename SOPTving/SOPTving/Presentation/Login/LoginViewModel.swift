//
//  LoginViewModel.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/15.
//

import Foundation

protocol LoginViewModelInput {
    func emailText(email: String)
    func passwordText(password: String)
}

protocol LoginViewModelOutput {
    var isLoginButtonEnableUpdated: ((Bool) -> Void)? { get set }
}

protocol LoginViewModel: LoginViewModelInput, LoginViewModelOutput {}

final class DefaultLoginViewModel: LoginViewModel {

    // MARK: - Output

    var isLoginButtonEnableUpdated: ((Bool) -> Void)?

    var isLoginButtonEnable: Bool = false {
        didSet {
            isLoginButtonEnableUpdated?(isLoginButtonEnable)
        }
    }

    private var isValidEmail = false

    private var isValidPassword = false
    
    private let useCase: LoginUseCase

    init(useCase: LoginUseCase) {
        self.useCase = useCase
    }
}

// MARK: - Input

extension DefaultLoginViewModel {
    func emailText(email: String) {
        isValidEmail = useCase.checkIsValidEmail(email: email)
        isLoginButtonEnable = isValidEmail && isValidPassword
    }

    func passwordText(password: String) {
        isValidPassword = useCase.checkIsValidPassword(password: password)
        isLoginButtonEnable = isValidEmail && isValidPassword
    }
}
