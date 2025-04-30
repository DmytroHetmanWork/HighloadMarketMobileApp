//
//  CartView.swift
//  HighloadMarket
//
//  Created by Dmytro Hetman on 30.04.2025.
//

import SwiftUI

struct CartView: View {
    @StateObject private var viewModel = CartViewModel()

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let error = viewModel.errorMessage {
                Text("Error: \(error)")
            } else if let cart = viewModel.cart {
                List(cart.items, id: \.id) { item in
                    CartItemRow(item: item)
                }
                Text("Total: $\(cart.totalPrice, specifier: "%.2f")")
                    .font(.title2)
                    .padding()
            }
        }
        .navigationTitle("Cart")
        .onAppear {
            viewModel.loadCart()
        }
    }
}

struct CartItemRow: View {
    let item: CartItem

    var body: some View {
        HStack {
            Text(item.product.name)
            Spacer()
            Text("x\(item.quantity)")
        }
    }
}
