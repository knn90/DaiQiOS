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
    
    func updateEmail() async throws {
        let email = "asd@gmail.com"
        try await AuthenticationManager.shared.updateEmail(email: email)
    }
    func updatePassword() async throws {
        let password = "asd123"
        try await AuthenticationManager.shared.updatePassword(password: password)
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
            changeSection
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
extension SettingView {
    private var changeSection: some View {
        Section(header: Text("Changes")) {
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
            
            Button("update password") {
                Task {
                    do {
                        try await settingsViewModel.updatePassword()
                        print("PASSWORD UPDATED")
                    } catch {
                        print(error)
                    }
                }
            }
            
            Button("update email") {
                Task {
                    do {
                        try await settingsViewModel.updateEmail()
                        print("EMAIL UPDATED ")
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
}
