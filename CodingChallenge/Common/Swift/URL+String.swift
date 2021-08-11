//
//  URL+String.swift
//  
//
//  Created by lyzkov on 25/07/2021.
//

import Foundation

extension URL: ExpressibleByStringLiteral {

    public init(stringLiteral value: String) {
        guard let url = URL(string: value) else {
            preconditionFailure("Unable to convert address \(value) to valid URL")
        }

        self = url
    }
}
