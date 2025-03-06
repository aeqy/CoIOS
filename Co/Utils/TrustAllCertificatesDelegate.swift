//
//  TrustAllCertificatesDelegate.swift
//  Co
//
//  Created by A on 06/03/2025.
//

import Foundation

class TrustAllCertificatesDelegate: NSObject, URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust,
           let serverTrust = challenge.protectionSpace.serverTrust {
            let card = URLCredential(trust: serverTrust)
            completionHandler(.useCredential, card)
        } else {
            completionHandler(.performDefaultHandling, nil)
        }
    }
}
