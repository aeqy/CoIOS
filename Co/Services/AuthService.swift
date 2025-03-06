//
//  AuthService.swift
//  Co
//
//  Created by A on 06/03/2025.
//

import Foundation

class AuthService: ObservableObject {
    @Published var accessToken: String?
    @Published var refreshToken: String?
    @Published var isLoggedIn = false
    @Published var errorMessage: String?

    func login(username: String, password: String, completion: @escaping () -> Void) {
        guard let url = URL(string: "https://127.0.0.1:7172/connect/token") else {
            errorMessage = "无效的 URL"
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        let parameters = "grant_type=password&username=\(username)&password=\(password)&scope=openid&client_id=my-client&client_secret=your-client-secret"
        request.httpBody = parameters.data(using: .utf8)

        
        let session = URLSession(configuration: .default, delegate: TrustAllCertificatesDelegate(), delegateQueue: nil)

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "登录失败：\(error.localizedDescription)"
                }
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    self.errorMessage = "登录失败：无效的响应"
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "登录失败：没有数据"
                }
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let accessToken = json["access_token"] as? String,
                   let refreshToken = json["refresh_token"] as? String {
                    DispatchQueue.main.async {
                        self.accessToken = accessToken
                        self.refreshToken = refreshToken
                        self.isLoggedIn = true
                        self.errorMessage = nil
                        print("登录成功，accessToken: \(accessToken)") // 添加打印语句
                        completion()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.errorMessage = "登录失败：无效的 JSON 响应"
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "登录失败：JSON 解析错误"
                }
            }
        }
        task.resume()
    }
    


    func refreshTokenIfNeeded(completion: @escaping (Bool) -> Void) {
            guard let refreshToken = refreshToken, let url = URL(string: "https://127.0.0.1:7172/connect/token") else {
                completion(false)
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

            let parameters = "grant_type=refresh_token&refresh_token=\(refreshToken)&client_id=my-client&client_secret=your-client-secret"
            request.httpBody = parameters.data(using: .utf8)
            let session = URLSession(configuration: .default, delegate: TrustAllCertificatesDelegate(), delegateQueue: nil)

            let task = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        print("刷新令牌失败：\(error.localizedDescription)") // 打印错误信息
                        completion(false)
                    }
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    DispatchQueue.main.async {
                        print("刷新令牌失败：无效的响应") // 打印错误信息
                        completion(false)
                    }
                    return
                }

                guard let data = data else {
                    DispatchQueue.main.async {
                        print("刷新令牌失败：没有数据") // 打印错误信息
                        completion(false)
                    }
                    return
                }

                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let accessToken = json["access_token"] as? String,
                   let refreshToken = json["refresh_token"] as? String{
                    DispatchQueue.main.async {
                        self.accessToken = accessToken
                        self.refreshToken = refreshToken
                        completion(true)
                    }
                }else{
                    DispatchQueue.main.async {
                        print("刷新令牌失败：JSON解析失败") // 打印错误信息
                        completion(false)
                    }
                }
            }
        task.resume()
    }
}
