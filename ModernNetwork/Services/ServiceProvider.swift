//
//  ServiceProvider.swift
//  ModernNetwork
//
//  Created by Xi Chen on 10.01.20.
//  Copyright © 2020 Xi Chen. All rights reserved.
//

import Foundation

public typealias RequestCompletion = (_ result: Result<Data, NetworkError>) -> Void

public protocol Cancellable {
    func cancel()
}

extension URLSessionTask: Cancellable {}

public protocol ServiceProviderType: AnyObject {
    associatedtype Endpoint: EndpointType

    /**
     Execute the network request.
     - Parameter endpoint: The endpoint object contains the necessary information to construct the network request.
     - Parameter callbackQueue: The dispatch queue you want the completion handler to be called within. The default value is the main dispatch queue.
     - Parameter completion: The completion handler to call when the network request is completed.
     - Returns: A reference object that can be used to cancel an on-going request.
     */
    func request(_ endpoint: Endpoint,
                 callbackQueue: DispatchQueue?,
                 completion: @escaping RequestCompletion) -> Cancellable?
}

public class ServiceProvider<Endpoint: EndpointType>: ServiceProviderType {
    public init() { }

    public func request(_ endpoint: Endpoint,
                        callbackQueue: DispatchQueue? = DispatchQueue.main,
                        completion: @escaping RequestCompletion) -> Cancellable? {
        
        let session = URLSession.shared
        var task: URLSessionTask? = nil
        
        do {
            let request = try self.buildRequest(for: endpoint)

            task = session.dataTask(with: request, completionHandler: { [weak self] data, response, error in
                
                if let error = error  {
                    callbackQueue?.async {
                        completion(.failure(error.toNetworkError()))
                    }
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    callbackQueue?.async {
                        completion(.failure(NetworkError.serviceUnavailable))
                    }
                    return
                }
                
                if let networkError = self?.extractError(from: response) {
                    callbackQueue?.async {
                        completion(.failure(networkError))
                    }
                } else {
                    if let data = data {
                        callbackQueue?.async {
                            completion(.success(data))
                        }
                    } else {
                        callbackQueue?.async {
                            completion(.failure(NetworkError.badResponse))
                        }
                    }
                }
            })

            task?.resume()

        } catch {
            callbackQueue?.async {
                completion(.failure(error.toNetworkError()))
            }
        }
        
        return task
    }
}

extension ServiceProvider {
    private func extractError(from response: HTTPURLResponse) -> NetworkError? {
        switch response.statusCode {
        case 200...299: return nil
        case 401...403: return .unauthorized
        case 500...599: return .serviceUnavailable
        default: return .general(description: "HTTP Code: \(response.statusCode)")
        }
    }
    
    private func buildRequest(for endpoint: Endpoint) throws -> URLRequest {
        let fullURL = endpoint.baseURL.appendingPathComponent(endpoint.path)
        var request = URLRequest(url: fullURL,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 15.0)
        
        request.httpMethod = endpoint.httpMethod.upperCasedStringValue
        
        switch endpoint.task {
        case .requestWith(let payload, let encoding):
            switch encoding {
            case .URLEncoding:
                request = try URLParameterEncoder.encode(request: request, with: payload)
            case .JSONEncoding:
                request = try JSONParameterEncoder.encode(request: request, with: payload)
            }
        default: break
        }
        
        if let headers: HTTPHeaders = endpoint.headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }

        return request
    }
}
