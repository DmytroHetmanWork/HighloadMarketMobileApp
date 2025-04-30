//
//  ProfileView.swift
//  HighloadMarket
//
//  Created by Dmytro Hetman on 30.04.2025.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var auth: AuthViewModel

    var body: some View {
        VStack(spacing: 16) {
            if let user = auth.user {
                Text("Name: \(user.name)")
                Text("Email: \(user.email)")
                Text("Joined: \(user.createdAt)")

                Button("Logout") {
                    auth.logout()
                }
                .foregroundColor(.red)
            }
        }
        .padding()
        .navigationTitle("Profile")
    }
}
