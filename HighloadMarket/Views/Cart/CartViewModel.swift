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
                await MainActor.run {
                    isLoading = true
                }
                let result = try await NetworkService.shared.sendRequest(.getCart, responseModel: Cart.self, decoder: .iso8601WithFractionalSeconds)
                await MainActor.run {
                    self.cart = result
                    self.isLoading = false
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
