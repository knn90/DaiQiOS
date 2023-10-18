//
//  AuthenticationManager.swift
//  DaiQiOS
//
//  Created by Đinh Trần Việt Anh on 06/10/2023.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid : String
    let email : String?
    let photoURL: String?
    let isGuest: Bool
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoURL = user.photoURL?.absoluteString
        self.isGuest = user.isAnonymous
    }
}

enum  AuthProviderOption: String {
    case email = "password"
    case google = "google.com"
}

final class AuthenticationManager {
    static let shared = AuthenticationManager()
    private init() {}
    
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard  let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
    //google.com
    //password
    func getProviders() throws -> [AuthProviderOption]{
        guard let providerData = Auth.auth().currentUser?.providerData else {
            throw URLError(.badServerResponse)
        }
        var providers: [AuthProviderOption] = []
        for provider in providerData {
            if let option = AuthProviderOption(rawValue: provider.providerID) {
                providers.append(option)
            }else {
                assertionFailure("Provider option not found: \(provider.providerID)")
            }
        }
        return providers
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
}
//mark: sign in email
extension AuthenticationManager {
    @discardableResult
    func createUser(email:String , password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
       return  AuthDataResultModel(user: authDataResult.user)
    }
     
    @discardableResult
    func signInUser(email:String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return  AuthDataResultModel(user: authDataResult.user)
    }
    
    func resetPassword(email: String) async throws  {
      try await  Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func updatePassword(password: String) async throws {
       guard let user = Auth.auth().currentUser else {
           throw URLError(.badServerResponse)
        }
      try await  user.updatePassword(to: password)
    }
    
    func updateEmail(email: String) async throws {
       guard let user = Auth.auth().currentUser else {
           throw URLError(.badServerResponse)
        }
      try await  user.updateEmail(to: email)
    }
}
//mark: sign in sso
extension AuthenticationManager {
    @discardableResult
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken,accessToken: tokens.accessToken)
        return try await signIn(credential: credential)
    }
    
    func signIn(credential: AuthCredential) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(with: credential)
       return  AuthDataResultModel(user: authDataResult.user)
    }
}
//mark: sign in guest
extension AuthenticationManager {
    @discardableResult
    func signInGuest() async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signInAnonymously()
       return  AuthDataResultModel(user: authDataResult.user)
    }
}
