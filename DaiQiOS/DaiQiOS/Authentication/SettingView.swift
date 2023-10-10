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
