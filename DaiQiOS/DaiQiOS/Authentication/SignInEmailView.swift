//
//  SigninEmailView.swift
//  DaiQiOS
//
//  Created by Đinh Trần Việt Anh on 07/10/2023.
//

import SwiftUI

final class SignInEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
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
