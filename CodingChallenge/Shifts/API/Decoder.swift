//
//  Decoder.swift
//  
//
//  Created by lyzkov on 21/07/2021.
//

import Foundation

import Common

extension JSONDecoder {
    
    static let shiftsDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        return decoder
    }()
    
}
