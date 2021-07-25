//
//  Operators.swift
//
//
//  Created by lyzkov on 25/07/2021.
//

import Foundation

func + (url: URL, path: String) -> URL {
    return url.appendingPathComponent(path)
}

func + (defaults: Parameters, custom: Parameters) -> Parameters {
    return defaults.merging(custom, uniquingKeysWith: { _, new in new })
}

func + (defaults: Headers, custom: Headers) -> Headers {
    return defaults.merging(custom, uniquingKeysWith: { _, new in new })
}
