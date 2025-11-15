//
//  LoginValidator.swift
//  sopt-37th-02Seminar
//
//  Created by JIN on 11/15/25.
//

import Foundation

class LoginValidator {

    // MARK: - Properties

    private let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
    private let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?]).{8,}$"

    // MARK: - Validation Methods

    func isValidEmail(_ string: String?) -> Bool {
        guard let string = string else { return false }

        return string.range(of: self.emailRegex, options: .regularExpression) != nil
    }

    func isValidPassword(_ string: String?) -> Bool {
        guard let string = string else { return false }

        return string.range(of: self.passwordRegex, options: .regularExpression) != nil
    }
}
