//
//  DevAPI.swift
//  
//
//  Created by lyzkov on 25/07/2021.
//

import Foundation

import Common

enum API: Common.API {
    
    // TODO: base url from info property list
    static var configuration = APIConfiguration(url: "https://dev.shiftkey.com/api/v2")
    
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        return formatter
    }()
    
    static func availableShifts(from start: Date) -> Get<Raw.Shifts> {
            .init(
                path: "/available_shifts",
                parameters: [
                    "address": "Dallas,%20Tx",
                    "start": formatter.string(from: start),
                    "type": "week",
                ]
            )
    }
    
}

extension Endpoint {
    static var api: Common.API.Type { API.self }
}

extension API {
    
    struct Get<Raw: Decodable>: Resource {
        let method: HTTPMethod = .get
        let encoding: HTTPRequestParametersEncoder = .queryURL
        let path: String
        let parameters: Parameters
    }
    
}
