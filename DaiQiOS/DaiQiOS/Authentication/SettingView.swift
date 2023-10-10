//
//  SettingView.swift
//  DaiQiOS
//
//  Created by Đinh Trần Việt Anh on 10/10/2023.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    
    func signOut()  throws {
        try AuthenticationManager.shared.signOut()
    }
    func resetPassword() async throws {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
}

struct SettingView: View {
    @StateObject private var settingsViewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List {
            Button("log out") {
                Task {
                    do {
                        try settingsViewModel.signOut()
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
            }
            
            Button("reset password") {
                Task {
                    do {
                        try await settingsViewModel.resetPassword()
                        print("PASSWORD RESET")
                    } catch {
                        print(error)
                    }
                }
            }
        }
        .navigationTitle("Settings")
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingView(showSignInView: .constant(false))
        }
    }
}
