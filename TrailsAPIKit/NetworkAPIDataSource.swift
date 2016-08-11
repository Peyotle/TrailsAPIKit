//
//  NetworkClient.swift
//  CycleNZ
//
//  Created by Oleg Chernyshenko on 8/07/16.
//  Copyright © 2016 Oleg Chernyshenko. All rights reserved.
//

import UIKit

public enum Result<T, Error> {
    case success(T)
    case failure(Error)
}

public protocol APIDataSource: class {

    func getTrails(completion:(Result<Data, Error>) -> Void)// (trailsData: Data?, error: Error?) -> Void)

    func postTrail(data: Data, completion: (Result<Data, Error>) -> Void)
    func deleteTrail(with id: String, completion: (Result<Bool, Error>) -> Void)
    
    func getSites(completion: (Result<Data, Error>) -> Void)
    func getSites(for region: (x0: Double, x1: Double, y0: Double, y1: Double), completion: (Result<Data, Error>) -> Void)
    func postSite(data: Data, completion: (Result<Data, Error>) -> Void)
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

    public func getTrails(completion: (Result<Data, Error>) -> Void) {
        let request = jsonRequest(with: trailsPath)
        let session = URLSession(configuration: self.authorizedConfiguration())
        dataTask = session.dataTask(with: request) {data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let httpResponse = response as? HTTPURLResponse,
                let data = data {
                if httpResponse.statusCode == 200 {
                    completion(.success(data))
                } else if httpResponse.statusCode == 401 {
                    completion(.failure(ServerError.NotAuthenticated))
                }
            } else {
                completion(.failure(ServerError.UnknownError))
            }
        }
        dataTask?.resume()
    }

    public func deleteTrail(with id: String, completion: (Result<Bool, Error>) -> Void) {
        let trailIdPath = "\(trailsPath)/\(id)"
        var request = jsonRequest(with: trailIdPath)
        request.httpMethod = "DELETE"

        let session = URLSession(configuration: self.authorizedConfiguration())

        dataTask = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(ServerError.UnknownError))
                return
            }
            guard httpResponse.statusCode == 200 else {
                completion(.failure(ServerError.NotAuthenticated))
                return
            }
            completion(.success(true))
        }
        dataTask?.resume()
    }

    public func postTrail(data: Data, completion: (Result<Data, Error>) -> Void) {
        var request = jsonRequest(with: trailsPath)
        request.httpMethod = "POST"
        request.httpBody = data

        let urlSession = URLSession(configuration: self.authorizedConfiguration())

        let dataTask = urlSession.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200, let data = data {
                    completion(.success(data))
                } else if httpResponse.statusCode == 401 {
                    completion(.failure(ServerError.NotAuthenticated))
                }
            }
        }
        dataTask.resume()
    }
    
    public func getSites(completion: (Result<Data, Error>) -> Void) {
        let request = jsonRequest(with: sitesPath)
        let session = URLSession(configuration: self.authorizedConfiguration())
        dataTask = session.dataTask(with: request) {data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let httpResponse = response as? HTTPURLResponse,
                let data = data {
                if httpResponse.statusCode == 200 {
                    completion(.success(data))
                } else if httpResponse.statusCode == 401 {
                    completion(.failure(ServerError.NotAuthenticated))
                }
            } else {
                completion(.failure(ServerError.UnknownError))
            }
        }
        dataTask?.resume()
    }


    public func getSites(for region: (x0: Double, x1: Double, y0: Double, y1: Double), completion: (Result<Data, Error>) -> Void) {
        let query = self.siteQuery(for: region)

        self.run(query: query, completion: completion)
    }

    func siteQuery(for region: (x0: Double, x1: Double, y0: Double, y1: Double)) -> String {
        let boxQuery = "{\"$geoWithin\":{\"$box\":[[\(region.x0),\(region.y0)],[\(region.x1),\(region.y1)]]}}"
        let locationInBox = "{\"coordinates\":\(boxQuery)}"
        let escapedLocation = locationInBox.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)

        let query = "?query=\(escapedLocation!)"
        return query
    }

    func run(query: String, completion: (Result<Data, Error>) -> Void) {
        let requestString = "\(sitesPath)/\(query)"
        let request = jsonRequest(with: requestString)
        let session = URLSession(configuration: self.authorizedConfiguration())
        dataTask = session.dataTask(with: request) {data, response, error in
            if let error = error {
                print(error)
                completion(.failure(error))
            } else if let httpResponse = response as? HTTPURLResponse, let data = data {
                if httpResponse.statusCode == 200 {
                    completion(.success(data))
                } else if httpResponse.statusCode == 401 {
                    completion(.failure(ServerError.NotAuthenticated))
                } else {
                    completion(.failure(ServerError.UnknownError))
                }
            }
        }
        dataTask?.resume()
    }

    public func postSite(data: Data, completion: (Result<Data, Error>) -> Void) {
        var request = jsonRequest(with: sitesPath)
        request.httpMethod = "POST"
        request.httpBody = data
        
        let urlSession = URLSession(configuration: self.authorizedConfiguration())
        
        let dataTask = urlSession.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200, let data = data {
                    completion(.success(data))
                } else if httpResponse.statusCode == 401 {
                    completion(.failure(ServerError.NotAuthenticated))
                } else {
                    completion(.failure(ServerError.UnknownError))
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
