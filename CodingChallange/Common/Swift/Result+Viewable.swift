//
//  File.swift
//  
//
//  Created by lyzkov on 13/07/2021.
//

import Foundation

extension Result: Viewable where Success: Viewable, Failure: Equatable {
    
    public init(from entity: Result<Success.Core, Failure>) {
        self = entity.map(Success.init(from:))
    }
    
}
