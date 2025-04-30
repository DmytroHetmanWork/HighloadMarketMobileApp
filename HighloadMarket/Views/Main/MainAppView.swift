//
//  MainAppView.swift
//  HighloadMarket
//
//  Created by Dmytro Hetman on 30.04.2025.
//

import SwiftUI

struct MainAppView: View {
    @State private var showCart = false
    @State private var showProfile = false

    var body: some View {
        NavigationView {
            ProductListView()
                .navigationTitle("Products")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: { showProfile = true }) {
                            Image(systemName: "person.crop.circle")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { showCart = true }) {
                            Image(systemName: "cart")
                        }
                    }
                }
                .sheet(isPresented: $showProfile) {
                    NavigationView {
                        ProfileView()
                    }
                }
                .sheet(isPresented: $showCart) {
                    NavigationView {
                        CartView()
                    }
                }
        }
    }
}
