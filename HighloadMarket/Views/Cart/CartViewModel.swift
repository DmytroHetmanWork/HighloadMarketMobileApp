//
//  CartViewModel.swift
//  HighloadMarket
//
//  Created by Dmytro Hetman on 30.04.2025.
//

import SwiftUI

class CartViewModel: ObservableObject {
    @Published var cart: Cart?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func loadCart() {
        Task {
            do {
                if MockDataConfig.isMocked {
                    await MainActor.run {
                        self.cart = Cart.mock
                    }
                } else {
                    await MainActor.run {
                        isLoading = true
                    }
                    let result = try await NetworkService.shared.sendRequest(.getCart, responseModel: Cart.self, decoder: .iso8601WithFractionalSeconds)
                    await MainActor.run {
                        self.cart = result
                        self.isLoading = false
                    }
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }

}

extension Cart {
    static var mock: Cart {
        let product1 = Product.mock1
        let product2 = Product.mock2

        let item1 = CartItem(
            id: "cartItem1",
            productId: product1.id,
            product: product1,
            quantity: 2,
            price: product1.price,
            isReserved: true,
            reservationId: "res1",
            reservationExpiresAt: ISO8601DateFormatter().string(from: Date().addingTimeInterval(3600))
        )

        let item2 = CartItem(
            id: "cartItem2",
            productId: product2.id,
            product: product2,
            quantity: 1,
            price: product2.price,
            isReserved: false,
            reservationId: "",
            reservationExpiresAt: ""
        )

        return Cart(
            id: "cart123",
            userId: "user456",
            items: [item1, item2],
            totalPrice: item1.price * Double(item1.quantity) + item2.price * Double(item2.quantity),
            createdAt: ISO8601DateFormatter().string(from: Date().addingTimeInterval(-3600)),
            updatedAt: ISO8601DateFormatter().string(from: Date())
        )
    }
}

extension Product {
    static var mock1: Product {
        Product(
            id: "prod001",
            name: "Wireless Headphones",
            price: 59.99,
            category: "Electronics",
            image: "headphones.jpg",
            isLimited: false
        )
    }

    static var mock2: Product {
        Product(
            id: "prod002",
            name: "Eco Water Bottle",
            price: 19.99,
            category: "Accessories",
            image: "bottle.jpg",
            isLimited: true
        )
    }
}

extension ProductDetail {
    static var mock: ProductDetail {
        ProductDetail(
            id: "prod001",
            name: "Wireless Headphones",
            price: 59.99,
            category: "Electronics",
            image: "headphones.jpg",
            isLimited: false,
            description: "High-quality wireless headphones with noise cancellation.",
            stockQuantity: 100,
            reservedQuantity: 10,
            hasQueue: false,
            queueLength: 0
        )
    }
}

extension CartItem {
    static var mock: CartItem {
        CartItem(
            id: "item123",
            productId: Product.mock1.id,
            product: Product.mock1,
            quantity: 1,
            price: Product.mock1.price,
            isReserved: true,
            reservationId: "reservation789",
            reservationExpiresAt: ISO8601DateFormatter().string(from: Date().addingTimeInterval(1800))
        )
    }
}
