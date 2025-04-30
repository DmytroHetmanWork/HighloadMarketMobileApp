//
//  CartService.swift
//  HighloadMarket
//
//  Created by Dmytro Hetman on 01.05.2025.
//

import Foundation

final class CartService {
    static let shared = CartService()

    func addToCart(productId: String, quantity: Int) async throws {
        let body = CartItemRequest(productId: productId, quantity: quantity)
        _ = try await NetworkService.shared.sendRequest(
            .addItemToCart(item: body),
            responseModel: QueueInfo.self
        )
    }
}
