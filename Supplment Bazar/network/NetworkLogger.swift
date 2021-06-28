//
//  NetworkLogger.swift
//  Dizney
//
//  Created by Ameer on 1/4/21.
//

import Foundation

class NetworkLogger {
    
    static func printRequest(request: URLRequest) {
        print("request")
        print(request.allHTTPHeaderFields)
        print("body" ,String(data: request.httpBody ?? Data(), encoding: .utf8))
        print("end request")
    }
    
    static func printResponse(response: Data) {
        print("response")
        print(String(data: response, encoding: .utf8))
        print("end response")
    }
    
}
