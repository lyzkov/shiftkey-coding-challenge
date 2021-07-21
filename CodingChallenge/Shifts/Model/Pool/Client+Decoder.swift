//
//  File.swift
//  
//
//  Created by lyzkov on 21/07/2021.
//

import Foundation

import Common

extension Client {
    
    private static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        return decoder
    }()
    
    public convenience init() {
        self.init(decoder: Self.decoder)
    }
    
}
