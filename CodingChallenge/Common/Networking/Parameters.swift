//
//  File.swift
//  
//
//  Created by lyzkov on 25/07/2021.
//

import Foundation

public typealias Parameters = [String: Any]

public protocol ParametersEncoding {
    func encode(_ urlRequest: URLRequest, with parameters: Parameters?) throws -> URLRequest
}

public enum HTTPRequestParametersEncoder {
    case queryURL
}

extension HTTPRequestParametersEncoder: ParametersEncoding {
    
    public func encode(
        _ urlRequest: URLRequest,
        with parameters: Parameters?
    ) throws -> URLRequest {
        switch self {
        case .queryURL:
            return try QueryURLParameterEncoder().encode(urlRequest, with: parameters)
        }
    }
    
}

struct QueryURLParameterEncoder: ParametersEncoding {
    
    func encode(_ urlRequest: URLRequest, with parameters: Parameters?) throws -> URLRequest {
        var request = urlRequest

        guard let parameters = parameters,
            var url = urlRequest.url?.absoluteString else {
                return request
        }

        let pathComponents = parameters
            .reduce("") { pathComponents, parameter in
                let (name, value) = parameter
                return pathComponents + "&\(name)=\(value)"
            }
            .dropFirst()
        
        url = "\(url)?\(pathComponents)"
        request.url = URL(string: url)

        return request
    }
    
}
