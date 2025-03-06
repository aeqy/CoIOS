//
//  LoginView.swift
//  Co
//
//  Created by A on 06/03/2025.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = AuthViewModel() //使用StateObject，只有第一次创建view时才创建viewModel
    @State private var isLoading = false // 添加加载状态
    @State private var isLoggedIn = false // 添加登录状态

    var body: some View {
        
        if isLoggedIn {
            ContentView() // 如果登录成功，显示首页
                .environmentObject(viewModel.authService) // 传递 AuthService 实例
        } else {
            VStack {
                TextField("用户名", text: $viewModel.username)
                    .padding()
                    .autocapitalization(.none) //关闭自动首字母大写
                    .disableAutocorrection(true) //关闭自动纠正
                    .keyboardType(.emailAddress) //设置键盘类型
                SecureField("密码", text: $viewModel.password)
                    .padding()
                Button(action: {
                    isLoading = true
                    viewModel.login {
                        isLoading = false
                        if viewModel.authService.isLoggedIn {
                            // 登录成功后的操作，例如导航到主视图
                            print("登录成功")
                            isLoggedIn = true // 确保正确更新 isLoggedIn
                            print("登录成功，isLoggedIn: \(isLoggedIn)") // 添加打印语句
                                               
                        } else {
                            // 登录失败，错误信息已经在viewModel.authService.errorMessage
                            print("登录失败")
                        }
                    }
                }) {
                    if isLoading {
                        ProgressView()
                    } else {
                        Text("登录")
                    }
                }
                .padding()
                if let errorMessage = viewModel.authService.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
            }
            .padding()
        }
    }
}

#Preview {
    LoginView()
}
