//
//  APIEndpoint.swift
//  HighloadMarket
//
//  Created by Dmytro Hetman on 30.04.2025.
//


import Foundation

// MARK: - Prod: http://api.example.com/v1
// MARK: - Dev: http://dev-api.example.com/v1

enum ServerProvider {
    static let prod = "https://api.example.com/v1"
    static let dev = "https://dev-api.example.com/v1"
}

enum APIEndpoint {
    static let baseURL = URL(string: ServerProvider.prod)!

    case getProducts
    case getProductDetails(productId: String)
    case getProductAvailability(productId: String)

    case getCart
    case addItemToCart(item: CartItemRequest)
    case removeItemFromCart(itemId: String)

    case getProductQueue(productId: String)
    case getQueueRequestStatus(requestId: String)

    case getReservations
    case getReservationDetails(reservationId: String)

    case registerUser(data: RegisterRequest)
    case loginUser(data: LoginRequest)
    case getCurrentUser

    var request: URLRequest {
        var url: URL
        var request: URLRequest
        switch self {
        case .getProducts:
            url = APIEndpoint.baseURL.appendingPathComponent("/products")
            request = URLRequest(url: url)

        case .getProductDetails(let productId):
            url = APIEndpoint.baseURL.appendingPathComponent("/products/\(productId)")
            request = URLRequest(url: url)

        case .getProductAvailability(let productId):
            url = APIEndpoint.baseURL.appendingPathComponent("/products/\(productId)/availability")
            request = URLRequest(url: url)

        case .getCart:
            url = APIEndpoint.baseURL.appendingPathComponent("/carts")
            request = URLRequest(url: url)

        case .addItemToCart(let item):
            url = APIEndpoint.baseURL.appendingPathComponent("/carts/items")
            request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = try? JSONEncoder().encode(item)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        case .removeItemFromCart(let itemId):
            url = APIEndpoint.baseURL.appendingPathComponent("/carts/items/\(itemId)")
            request = URLRequest(url: url)
            request.httpMethod = "DELETE"

        case .getProductQueue(let productId):
            url = APIEndpoint.baseURL.appendingPathComponent("/queues/products/\(productId)")
            request = URLRequest(url: url)

        case .getQueueRequestStatus(let requestId):
            url = APIEndpoint.baseURL.appendingPathComponent("/queues/requests/\(requestId)")
            request = URLRequest(url: url)

        case .getReservations:
            url = APIEndpoint.baseURL.appendingPathComponent("/reservations")
            request = URLRequest(url: url)

        case .getReservationDetails(let reservationId):
            url = APIEndpoint.baseURL.appendingPathComponent("/reservations/\(reservationId)")
            request = URLRequest(url: url)

        case .registerUser(let data):
            url = APIEndpoint.baseURL.appendingPathComponent("/users/register")
            request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = try? JSONEncoder().encode(data)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        case .loginUser(let data):
            url = APIEndpoint.baseURL.appendingPathComponent("/users/login")
            request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = try? JSONEncoder().encode(data)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        case .getCurrentUser:
            url = APIEndpoint.baseURL.appendingPathComponent("/users/me")
            request = URLRequest(url: url)
        }

        request.httpMethod = request.httpMethod ?? "GET"
        return request
    }
}
