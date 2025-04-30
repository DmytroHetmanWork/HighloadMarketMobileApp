//
//  ProductDetailView.swift
//  HighloadMarket
//
//  Created by Dmytro Hetman on 30.04.2025.
//

import SwiftUI

struct ProductDetailView: View {
    let productId: String
    @StateObject private var viewModel = ProductDetailViewModel()

    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Loading product...")
            } else if let error = viewModel.errorMessage {
                VStack {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                    Text("Error loading product: \(error)")
                }
            } else if let product = viewModel.productDetail {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        AsyncImage(url: URL(string: product.image)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(16)
                                .shadow(radius: 8)
                        } placeholder: {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 240)
                        }

                        Text(product.name)
                            .font(.title)
                            .bold()

                        Text("$\(product.price, specifier: "%.2f")")
                            .font(.title2)
                            .foregroundColor(.green)

                        if !product.description.isEmpty {
                            Text(product.description)
                                .font(.body)
                        }

                        Divider()

                        HStack {
                            Text("In stock: \(product.stockQuantity)")
                            Spacer()
                            Text("Reserved: \(product.reservedQuantity)")
                        }
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                        if product.hasQueue {
                            HStack {
                                Image(systemName: "clock.arrow.circlepath")
                                Text("Queue: \(product.queueLength) people")
                            }
                            .font(.callout)
                            .padding(8)
                            .background(Color.yellow.opacity(0.2))
                            .cornerRadius(8)
                        }

                        Button(action: {
                            Task {
                                try await CartService.shared.addToCart(productId: product.id, quantity: 1)
                            }
                        }) {
                            Text(product.stockQuantity > 0 ? "Add to Cart" : "Join Queue")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(product.stockQuantity > 0 ? Color.blue : Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        .padding(.top, 8)
                    }
                    .padding()
                }
                .navigationTitle("Product Detail")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .onAppear {
            viewModel.loadProductDetail(productId: productId)
        }
    }
}
