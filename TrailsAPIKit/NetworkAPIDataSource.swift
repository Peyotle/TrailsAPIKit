//
//  NetworkClient.swift
//  CycleNZ
//
//  Created by Oleg Chernyshenko on 8/07/16.
//  Copyright © 2016 Oleg Chernyshenko. All rights reserved.
//

import UIKit

public protocol APIDataSource: class {
    func getTrails(completion: (trailsData: Data?, error: Error?) -> Void)
    func postTrail(data: Data, completion: (result: Data?, error: Error?) -> Void)
    func deleteTrail(with id: String, completion: (success: Bool, error: Error?) -> Void)
    
    func getSites(completion: (sitesData: Data?, error: Error?) -> Void)
    func postSite(data: Data, completion: (result: Data?, error: Error?) -> Void)
}

public final class NetworkAPIDataSource: APIDataSource {

    enum ServerError: Error {
        case NotAuthenticated
        case UnknownError
    }

    let baseUrl = URL(string:"http://localhost:3000/api/")!
    let trailsPath = "trails"
    let sitesPath = "sites"

    var defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    var dataTask: URLSessionTask?

    public init() {
        
    }
    
    public func getTrails(completion: (trailsData: Data?, error: Error?) -> Void) {
        let request = jsonRequest(with: trailsPath)
        let session = URLSession(configuration: self.authorizedConfiguration())
        dataTask = session.dataTask(with: request) {data, response, error in
            if let error = error {
                completion(trailsData: nil, error: error)
            } else if let httpResponse = response as? HTTPURLResponse,
                let data = data {
                if httpResponse.statusCode == 200 {
                    completion(trailsData: data, error: nil)
                } else if httpResponse.statusCode == 401 {
                    completion(trailsData: nil, error: ServerError.NotAuthenticated)
                }
            } else {
                completion(trailsData: nil, error: ServerError.UnknownError)
            }
        }
        dataTask?.resume()
    }

    public func deleteTrail(with id: String, completion: (success: Bool, error: Error?) -> Void) {
        let trailIdPath = "\(trailsPath)/\(id)"
        var request = jsonRequest(with: trailIdPath)
        request.httpMethod = "DELETE"

        let session = URLSession(configuration: self.authorizedConfiguration())

        dataTask = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(success: false, error: error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(success: false, error: nil)
                return
            }
            guard httpResponse.statusCode == 200 else {
                completion(success: false, error: ServerError.NotAuthenticated)
                return
            }
            completion(success: true, error: nil)
        }
        dataTask?.resume()
    }

    public func postTrail(data: Data, completion: (result: Data?, error: Error?) -> Void) {
        var request = jsonRequest(with: trailsPath)
        request.httpMethod = "POST"
        request.httpBody = data

        let urlSession = URLSession(configuration: self.authorizedConfiguration())

        let dataTask = urlSession.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(result: nil, error: error)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    completion(result: data, error: nil)
                } else if httpResponse.statusCode == 401 {
                    completion(result: nil, error: ServerError.NotAuthenticated)
                }
            }
        }
        dataTask.resume()
    }
    
    public func getSites(completion: (sitesData: Data?, error: Error?) -> Void) {
        let request = jsonRequest(with: sitesPath)
        let session = URLSession(configuration: self.authorizedConfiguration())
        dataTask = session.dataTask(with: request) {data, response, error in
            if let error = error {
                completion(sitesData: nil, error: error)
            } else if let httpResponse = response as? HTTPURLResponse,
                let data = data {
                if httpResponse.statusCode == 200 {
                    completion(sitesData: data, error: nil)
                } else if httpResponse.statusCode == 401 {
                    completion(sitesData: nil, error: ServerError.NotAuthenticated)
                }
            } else {
                completion(sitesData: nil, error: ServerError.UnknownError)
            }
        }
        dataTask?.resume()
    }
    
    public func postSite(data: Data, completion: (result: Data?, error: Error?) -> Void) {
        var request = jsonRequest(with: sitesPath)
        request.httpMethod = "POST"
        request.httpBody = data
        
        let urlSession = URLSession(configuration: self.authorizedConfiguration())
        
        let dataTask = urlSession.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(result: nil, error: error)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    completion(result: data, error: nil)
                } else if httpResponse.statusCode == 401 {
                    completion(result: nil, error: ServerError.NotAuthenticated)
                }
            }
        }
        dataTask.resume()
    }

    func jsonRequest(with path: String) -> URLRequest {
        let url = URL(string: path, relativeTo: baseUrl)!
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        return request
    }

    func authorizedConfiguration() -> URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        let authString = self.authorizationString(userName: "Oleg", password: "pas")
        config.httpAdditionalHeaders = ["Authorization" : authString]
        return config
    }

    func authorizationString(userName: String, password: String) -> String {
        let userPasswordString = "\(userName):\(password)"
        let userPasswordData = userPasswordString.data(using: String.Encoding.utf8)
        let base64EncodedCredential = userPasswordData!.base64EncodedString()
        let authString = "Basic \(base64EncodedCredential)"
        return authString
    }

    func showNetworkActivity(isVisible: Bool) {
        DispatchQueue.main.async(execute: {
            UIApplication.shared.isNetworkActivityIndicatorVisible = isVisible
        })
    }
}
