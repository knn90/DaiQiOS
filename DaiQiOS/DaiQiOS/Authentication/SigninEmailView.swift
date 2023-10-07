//
//  SigninEmailView.swift
//  DaiQiOS
//
//  Created by Đinh Trần Việt Anh on 07/10/2023.
//

import SwiftUI

final class SigninEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
}
struct SigninEmailView: View {
    
    @StateObject private var signinEmailViewModel = SigninEmailViewModel()
    
    var body: some View {
        VStack {
            TextField("Email...", text: $signinEmailViewModel.email)
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
            SecureField("Password...", text: $signinEmailViewModel.password)
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
        }
        .padding()
        .navigationTitle("Sign In With Email")
    }
}

struct SigninEmailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SigninEmailView()
        }
    }
}
