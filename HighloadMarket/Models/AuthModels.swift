//
//  AuthModels.swift
//  HighloadMarket
//
//  Created by Dmytro Hetman on 30.04.2025.
//

import Foundation

struct LoginRequest: Codable {
    let email: String
    let password: String
}

struct RegisterRequest: Codable {
    let name: String
    let email: String
    let password: String
}

struct AuthResponse: Codable {
    let id: String
    let email: String
    let name: String
    let createdAt: String
}

struct CartItemRequest: Codable {
    let productId: String
    let quantity: Int
}
