//
//  HighloadMarketApp.swift
//  HighloadMarket
//
//  Created by Dmytro Hetman on 30.04.2025.
//

import SwiftUI

@main
struct HighloadMarketApp: App {
    @StateObject var auth = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            if auth.isAuthenticated {
                MainAppView()
                    .environmentObject(auth)
            } else {
                LoginView()
                    .environmentObject(auth)
            }
        }
    }
}
