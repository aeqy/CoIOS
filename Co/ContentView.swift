//
//  ContentView.swift
//  Co
//
//  Created by A on 06/03/2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authService: AuthService // 使用 EnvironmentObject

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            if let username = authService.accessToken { // 使用 accessToken
                        Text("欢迎，\(username)！")
                Text("Co 欢迎你")
                                .font(.title)
                        }
        
        }
        .padding()
        
        InventoryListView()
       
    }
}

#Preview {
    ContentView()
}
