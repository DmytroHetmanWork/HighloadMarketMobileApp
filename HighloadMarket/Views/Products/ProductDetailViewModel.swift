//
//  ProductDetailViewModel.swift
//  HighloadMarket
//
//  Created by Dmytro Hetman on 30.04.2025.
//

import SwiftUI

class ProductDetailViewModel: ObservableObject {
    @Published var productDetail: ProductDetail?
    @Published var isLoading = false
    @Published var errorMessage: String?

    func loadProductDetail(productId: String) {
        Task {
            do {
                isLoading = true
                let product = try await NetworkService.shared.sendRequest(
                    .getProductDetails(productId: productId),
                    responseModel: ProductDetail.self,
                    decoder: .iso8601WithFractionalSeconds
                )
                await MainActor.run {
                    self.productDetail = product
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
