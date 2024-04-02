//
//  ContentView.swift
//  GitHubProvider
//
//  Created by 濱野遥斗 on 2024/04/03.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = AuthViewModel()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button(action: {viewModel.logIn()}){
                Text("login")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
