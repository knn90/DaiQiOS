//
//  SigninEmailView.swift
//  DaiQiOS
//
//  Created by Đinh Trần Việt Anh on 07/10/2023.
//

import SwiftUI

@MainActor
final class SignInEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
       try await AuthenticationManager.shared.createUser(email: email, password: password)
    }
    func signIp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
       try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
}
struct SignInEmailView: View {
    
    @StateObject private var signInEmailViewModel = SignInEmailViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack {
            TextField("Email...", text: $signInEmailViewModel.email)
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
            SecureField("Password...", text: $signInEmailViewModel.password)
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
            
            Button {
                Task {
                    do {
                        try await  signInEmailViewModel.signUp()
                        showSignInView = false
                        return
                    } catch {
                       print(error)
                    }
                    
                    do {
                        try await  signInEmailViewModel.signIp()
                        showSignInView = false
                        return
                    } catch {
                       print(error)
                    }
                }
            } label: {
                Text("Sign in")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.purple.opacity(0.4))
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Sign In With Email")
    }
}

struct SignInEmailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignInEmailView(showSignInView: .constant(false))
        }
    }
}
