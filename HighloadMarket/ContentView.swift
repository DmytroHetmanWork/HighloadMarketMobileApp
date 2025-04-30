//
//  ContentView.swift
//  HighloadMarket
//
//  Created by Dmytro Hetman on 30.04.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .task {
            Task {
                do {
                    let products: [Product] = try await NetworkService.shared.sendRequest(.getProducts, responseModel: [Product].self)
                    print(products)
                } catch {
                    print("Error: \(error)")
                }
            }

        }
    }
}

#Preview {
    ContentView()
}
