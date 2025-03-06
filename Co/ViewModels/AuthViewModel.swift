//
//  AuthViewModel.swift
//  Co
//
//  Created by A on 06/03/2025.
//

import Foundation

class AuthViewModel: ObservableObject {
    let authService = AuthService()
    @Published var username = "admin"
    @Published var password = "Admin@123"

    func login(completion: @escaping () -> Void) {
        authService.login(username: username, password: password, completion: completion)
    }
}
