//
//  ProductListView.swift
//  HighloadMarket
//
//  Created by Dmytro Hetman on 30.04.2025.
//

import SwiftUI

struct ProductListView: View {
    @StateObject private var viewModel = ProductViewModel()

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                } else {
                    List(viewModel.products, id: \.id) { product in
                        NavigationLink(destination: ProductDetailView(productId: product.id)) {
                            HStack {
                                AsyncImage(url: URL(string: product.image)) { image in
                                    image.resizable().scaledToFit()
                                } placeholder: {
                                    Color.gray.opacity(0.2)
                                }
                                .frame(width: 50, height: 50)

                                VStack(alignment: .leading) {
                                    Text(product.name).bold()
                                    Text("$\(product.price, specifier: "%.2f")").font(.subheadline)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Products")
        }
        .onAppear {
            viewModel.loadProducts()
        }
    }
}
