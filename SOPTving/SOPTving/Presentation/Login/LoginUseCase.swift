//
//  LoginUseCase.swift
//  SOPTving
//
//  Created by 김민재 on 2023/04/15.
//

import Foundation


final class LoginUseCase {

    func checkIsValidEmail(email: String) -> Bool {
        return email.isValidEmail()
    }

    func checkIsValidPassword(password: String) -> Bool {
        return !password.isEmpty
    }
}
