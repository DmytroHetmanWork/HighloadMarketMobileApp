//
//  CartItem.swift
//  HighloadMarket
//
//  Created by Dmytro Hetman on 30.04.2025.
//

import Foundation

struct Product: Codable {
    let id: String
    let name: String
    let price: Double
    let category: String
    let image: String
    let isLimited: Bool
}

struct ProductDetail: Codable {
    let id: String
    let name: String
    let price: Double
    let category: String
    let image: String
    let isLimited: Bool
    let description: String
    let stockQuantity: Int
    let reservedQuantity: Int
    let hasQueue: Bool
    let queueLength: Int
}

struct CartItem: Codable {
    let id: String
    let productId: String
    let product: Product
    let quantity: Int
    let price: Double
    let isReserved: Bool
    let reservationId: String
    let reservationExpiresAt: String // ISO date string
}

struct QueueInfo: Codable {
    let inQueue: Bool
    let position: Int
    let totalInQueue: Int
    let requestId: String
    let estimatedTime: Int
}

struct QueueDetail: Codable {
    let productId: String
    let queueLength: Int
    let userPosition: Int
    let userRequestId: String
    let availableStock: Int
    let reservedStock: Int
    let estimatedWaitTime: Int
}

enum QueueStatus: String, Codable {
    case pending, processing, completed, failed
}

struct QueueRequestStatus: Codable {
    let requestId: String
    let userId: String
    let productId: String
    let status: QueueStatus
    let position: Int
    let createdAt: String
    let updatedAt: String
    let completedAt: String
}

enum ReservationStatus: String, Codable {
    case active, expired, completed
}

struct Reservation: Codable {
    let id: String
    let userId: String
    let productId: String
    let quantity: Int
    let createdAt: String
    let expiresAt: String
    let status: ReservationStatus
}

struct ReservationDetail: Codable {
    let id: String
    let userId: String
    let productId: String
    let quantity: Int
    let createdAt: String
    let expiresAt: String
    let status: ReservationStatus
    let product: Product
    let timeLeft: Int
    let cartId: String
}

struct User: Codable {
    let id: String
    let email: String
    let name: String
    let createdAt: String
}

struct Pagination: Codable {
    let page: Int
    let limit: Int
    let totalItems: Int
    let totalPages: Int
}


struct Cart: Codable {
    let id: String
    let userId: String
    let items: [CartItem]
    let totalPrice: Double
    let createdAt: String
    let updatedAt: String
}
