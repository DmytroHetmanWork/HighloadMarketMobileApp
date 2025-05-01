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
                if MockDataConfig.isMocked {
                    await MainActor.run {
                        self.productDetail = ProductDetail.mockDetail
                    }
                } else {
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

extension ProductDetail {
    static var mockDetail: ProductDetail {
        ProductDetail(
            id: "prod001",
            name: "Wireless Headphones",
            price: 59.99,
            category: "Electronics",
            image: "headphones.jpg",
            isLimited: false,
            description: "High-quality wireless headphones with noise cancellation.",
            stockQuantity: 4,
            reservedQuantity: 7,
            hasQueue: false,
            queueLength: 0
        )
    }
}
