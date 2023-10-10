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
    
    func signIn() {
        guard !email.isEmpty, !password.isEmpty else {
        print("No email or password found")
        return
    }
        Task {
            do {
                let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print("Success")
                print(returnedUserData)
            } catch {
                print("error: \(error)")
            }
        }
    }
}
struct SignInEmailView: View {
    
    @StateObject private var signInEmailViewModel = SignInEmailViewModel()
    
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
                signInEmailViewModel.signIn()
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
            SignInEmailView()
        }
    }
}
