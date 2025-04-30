//
//  ProductViewModel.swift
//  HighloadMarket
//
//  Created by Dmytro Hetman on 30.04.2025.
//

import SwiftUI

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func loadProducts() {
        Task {
            do {
                await MainActor.run {
                    isLoading = true
                }
                let result = try await NetworkService.shared.sendRequest(.getProducts, responseModel: [Product].self, decoder: .iso8601WithFractionalSeconds)
                await MainActor.run {
                    self.products = result
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
