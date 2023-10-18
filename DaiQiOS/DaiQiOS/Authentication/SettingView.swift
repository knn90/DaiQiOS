//
//  SettingView.swift
//  DaiQiOS
//
//  Created by Đinh Trần Việt Anh on 10/10/2023.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    
    @Published var authProviders: [AuthProviderOption] = []
    @Published var authUser : AuthDataResultModel? = nil
    
    func loadAuthProviders() {
        if let providers = try? AuthenticationManager.shared.getProviders() {
            authProviders = providers
        }
    }
     
    func loadAuthUser() {
        self.authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
    }
    
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
        let email = "a7vavava@gmail.com"
        try await AuthenticationManager.shared.updateEmail(email: email)
    }
    func updatePassword() async throws {
        let password = "yeuthuy123"
        try await AuthenticationManager.shared.updatePassword(password: password)
    }
    func linkGoogleAccount() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        self.authUser = try await AuthenticationManager.shared.linkGoogle(tokens: tokens)
    
    }
    func linkEmailAccount() async throws {
       let email = "a7vavava@gmail.com"
        let password = "yeuthuy123"
        self.authUser =  try await AuthenticationManager.shared.linkEmail(email: email, password: password)
    }
}

struct SettingView: View {
    @StateObject private var settingsViewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    @StateObject var addTaskViewModel: AddTaskViewModel = AddTaskViewModel()
    @StateObject var editTaskViewModel: EditTaskViewModel = EditTaskViewModel()
    
    var body: some View {
        
        NavigationStack {
            TodayChecklist()
                .environmentObject(listViewModel)
                .environmentObject(addTaskViewModel)
                .environmentObject(editTaskViewModel)
        }
        Spacer()
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
            if settingsViewModel.authProviders.contains(.email) {
                changeSection
            }
            
            if settingsViewModel.authUser?.isGuest == true {
                guestSection
            }
        }
        .onAppear {
            settingsViewModel.loadAuthProviders()
            settingsViewModel.loadAuthUser()
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
    private var guestSection: some View {
        Section(header: Text("Create account")) {
            Button("Link Google account") {
                Task {
                    do {
                        try await settingsViewModel.linkGoogleAccount()
                        print("GOOGLE LINKED")
                    } catch {
                        print(error)
                    }
                }
            }
            
            Button("Link Email account") {
                Task {
                    do {
                        try await settingsViewModel.linkEmailAccount()
                        print("EMAIL LINKED")
                    } catch {
                        print(error)
                    }
                }
            }
            
        }
    }
}
