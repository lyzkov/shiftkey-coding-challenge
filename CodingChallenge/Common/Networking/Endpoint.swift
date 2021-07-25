//
//  Endpoint.swift
//
//
//  Created by lyzkov on 25/07/2021.
//

import Foundation

public protocol Endpoint: URLRequestConvertible {
    static var api: API.Type { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters { get }
    var encoding: HTTPRequestParametersEncoder { get }
    var headers: Headers { get }
}

public extension Endpoint {
    
    var headers: Headers {
        return [:]
    }

    var parameters: Parameters {
        return [:]
    }

    func asURLRequest() throws -> URLRequest {
        let base = Self.api.configuration

        var request = URLRequest(
            url: base.url + path
        )
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = base.headers + headers

        return try encoding.encode(request, with: base.parameters + parameters)
    }

}

public protocol Resource: Endpoint {
    associatedtype Raw: Decodable
}

public protocol URLRequestConvertible {
    func asURLRequest() throws -> URLRequest
}

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}
