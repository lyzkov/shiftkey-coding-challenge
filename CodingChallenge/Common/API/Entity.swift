//
//  File.swift
//  
//
//  Created by lyzkov on 21/07/2021.
//

import Foundation

public protocol Entity {
    associatedtype Raw: Decodable
    init(from raw: Raw)
}
