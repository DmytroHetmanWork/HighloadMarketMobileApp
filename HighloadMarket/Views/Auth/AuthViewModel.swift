//
//  AuthViewModel.swift
//  HighloadMarket
//
//  Created by Dmytro Hetman on 30.04.2025.
//

import SwiftUI

@MainActor
class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var user: User?
    @Published var errorMessage: String?

    func login(email: String, password: String) async {
        let loginRequest = LoginRequest(email: email, password: password)
        do {
            let response: AuthResponse = try await NetworkService.shared.sendRequest(
                .loginUser(data: loginRequest),
                responseModel: AuthResponse.self
            )
            self.errorMessage = nil
            self.user = User(id: response.id, email: response.email, name: response.name, createdAt: response.createdAt)
            self.isAuthenticated = true
        } catch {
            self.errorMessage = "Login failed: \(error.localizedDescription)"
            self.isAuthenticated = false
        }
    }

    func register(name: String, email: String, password: String) async {
        let registerRequest = RegisterRequest(name: name, email: email, password: password)
        do {
            let response: AuthResponse = try await NetworkService.shared.sendRequest(
                .registerUser(data: registerRequest),
                responseModel: AuthResponse.self
            )
            self.errorMessage = nil
            self.user = User(id: response.id, email: response.email, name: response.name, createdAt: response.createdAt)
            self.isAuthenticated = true
        } catch {
            self.errorMessage = "Registration failed: \(error.localizedDescription)"
            self.isAuthenticated = false
        }
    }

    func logout() {
        isAuthenticated = false
        user = nil
        errorMessage = nil
    }
}
