//
//  NetworkEnginw.swift
//  Banan Ekyc iOS
//
//  Created by Ameer on 4/23/20.
//  Copyright © 2020 enjaz. All rights reserved.
//

import Foundation

let tokenExpire = "tokenExpire"

enum ErrorType {
    case ERROR, CONNECTIONERROR, INTERNETERROR
}

enum RequestMethod: String {
    case get = "get"
    case post = "post"
    case patch = "patch"
    case delete = "delete"
    case put = "put"
}

class NetworkEngine {
    
    static func buildRequest(url: String,method: RequestMethod) -> URLRequest? {
        guard let urlR = URL(string: url) else { return nil }
        var request = URLRequest(url: urlR)
        request.httpMethod = method.rawValue
        request.addValue(Locale.current.languageCode ?? "en", forHTTPHeaderField: "Accept-Language")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if let token = UserUD.token {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        return request
    }
    
    static func makeRequestWithBody<R: Decodable, X: Encodable>(url: String,method: RequestMethod,body: X? = nil, completion:@escaping ((GenericAPIResponse<R>?,String?) -> Void)) {
        if var request = buildRequest(url: url,method: method) {
            if method == RequestMethod.post, let body = body {
                let encode = try? JSONEncoder().encode(body)
                request.httpBody = encode
            }
            NetworkLogger.printRequest(request: request)
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.sync {
                    if let error = error as NSError? {
                        if error.code == NSURLErrorNotConnectedToInternet {
                            completion(nil,"internet_failure".getLocalized())
                        } else {
                            completion(nil,"connection_failure".getLocalized())
                        }
                        return
                    }
                    if let data = data {
                        NetworkLogger.printResponse(response: data)
                        let decoder = try? JSONDecoder().decode(GenericAPIResponse<R>.self, from: data)
                        if let result = decoder {
                            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                                completion(nil,"connection_failure".getLocalized())
                                return
                            }
                            if 200...300 ~= statusCode {
                                 completion(result,nil)
                            } else if statusCode == 401 {
                                if UserUD.isLogin {
                                    completion(nil,tokenExpire)
                                } else {
                                    completion(nil, result.message)
                                }
                            } else if statusCode == 511 {
                                completion(nil,tokenExpire)
                            } else {
                                completion(nil,result.message)
                            }
                        } else {
                            completion(nil,"connection_failure".getLocalized())
                        }
                    }
                }
            }.resume()
        }
    }
    
    static func makeMetaRequestWithBody<R: Decodable, X: Encodable>(url: String,method: RequestMethod,body: X? = nil, completion:@escaping ((GenericMetaAPIResponse<R>?,String?) -> Void)) {
        if var request = buildRequest(url: url,method: method) {
            if method == RequestMethod.post, let body = body {
                let encode = try? JSONEncoder().encode(body)
                request.httpBody = encode
            }
            NetworkLogger.printRequest(request: request)
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.sync {
                    if let error = error as NSError? {
                        if error.code == NSURLErrorNotConnectedToInternet {
                            completion(nil,"internet_failure".getLocalized())
                        } else {
                            completion(nil,"connection_failure".getLocalized())
                        }
                        return
                    }
                    if let data = data {
                        NetworkLogger.printResponse(response: data)
                        let decoder = try? JSONDecoder().decode(GenericMetaAPIResponse<R>.self, from: data)
                        if let result = decoder {
                            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                                completion(nil,"connection_failure".getLocalized())
                                return
                            }
                            if 200...300 ~= statusCode {
                                 completion(result,nil)
                            } else if statusCode == 401 {
                                if UserUD.isLogin {
                                    completion(nil,tokenExpire)
                                }
                            } else if statusCode == 511 {
                                completion(nil,tokenExpire)
                            } else {
                                completion(nil,result.message)
                            }
                        } else {
                            completion(nil,"connection_failure".getLocalized())
                        }
                    }
                }
            }.resume()
        }
    }
    
    static func request(url: String,method: RequestMethod, completion:@escaping ((Any?,String?) -> Void)) {
        if let request = buildRequest(url: url,method: method) {
            NetworkLogger.printRequest(request: request)
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.sync {
                    if let error = error as NSError? {
                        if error.code == NSURLErrorNotConnectedToInternet {
                            completion(nil,"internet_failure".getLocalized())
                        } else {
                            completion(nil,"connection_failure".getLocalized())
                        }
                        return
                    }
                    if let data = data {
                        NetworkLogger.printResponse(response: data)
                        let json = try? JSONSerialization.jsonObject(with: data, options: [])
                        if let result = json {
                            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                                completion(nil,"connection_failure".getLocalized())
                                return
                            }
                            if 200...300 ~= statusCode {
                                 completion(result,nil)
                            } else if statusCode == 401 {
                                if UserUD.isLogin {
                                    completion(nil,tokenExpire)
                                }
                            }
                        } else {
                            completion(nil,"connection_failure".getLocalized())
                        }
                    }
                }
            }.resume()
        }
    }
}
