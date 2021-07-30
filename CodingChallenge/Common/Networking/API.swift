//
//  API.swift
//
//
//  Created by lyzkov on 25/07/2021.
//

import Foundation

public protocol API {
    static var configuration: APIConfiguration { get }
}

public struct APIConfiguration {
    let url: URL
    let parameters: Parameters
    let headers: Headers

    public init(url: URL, parameters: Parameters = [:], headers: Headers = [:]) {
        self.url = url
        self.parameters = parameters
        self.headers = headers
    }

}
