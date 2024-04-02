//
//  AuthViewModel.swift
//  GitHubProvider
//
//  Created by 濱野遥斗 on 2024/04/03.
//

import SwiftUI
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    
    @Published var isShowPostPage = false
    
    var provider = OAuthProvider(providerID: "github.com")
    
    // イニシャライザメソッドを呼び出して、アプリの起動時に認証状態をチェックする
    init() {
        observeAuthChanges()
    }
    
    func logIn(){
        provider.getCredentialWith(nil) { credential, error in
            guard let credential = credential, error == nil else {
                print("Error: \(error as Optional)")
                return
            }
            Auth.auth().signIn(with: credential) { (result, error) in
                // signIn後の処理
            }
        }
    }

    private func observeAuthChanges() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.isAuthenticated = user != nil
            }
        }
    }
    
    // ログインするメソッド
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                if result != nil, error == nil {
                    self?.isAuthenticated = true
                }
            }
        }
    }
    
    // 新規登録するメソッド
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                if result != nil, error == nil {
                    self?.isAuthenticated = true
                }
            }
        }
    }
    
    // パスワードをリセットするメソッド
    func resetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("Error in sending password reset: \(error)")
            }
        }
    }
    
    // ログアウトするメソッド
    func signOut() {
        do {
            try Auth.auth().signOut()
            isAuthenticated = false
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func getUserID() -> String{
        return Auth.auth().currentUser?.uid ?? "!!!"
    }
}
