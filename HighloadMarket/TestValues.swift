//
//  TestValues.swift
//  HighloadMarket
//
//  Created by Dmytro Hetman on 30.04.2025.
//

import Foundation

struct MockData {
    static let products: [Product] = (1...50).map { index in
        Product(
            id: UUID().uuidString,
            name: "Product \(index)",
            price: Double(index) * 1.99,
            category: "Category \(index % 5)",
            image: "https://via.placeholder.com/100?text=Item+\(index)",
            isLimited: index % 3 == 0
        )
    }
}
