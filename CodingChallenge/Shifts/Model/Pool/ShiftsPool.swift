//
//  ShiftsPool.swift
//  
//
//  Created by lyzkov on 15/07/2021.
//

import Foundation
import Combine

import Common

import IdentifiedCollections

class ShiftsPool {
    
    // TODO: Endpoint abstraction
    private let url: URL = {
        // Notice: building URLs in NSSwift is so imperative and prone to type unsafe typos!
        var compomemets = URLComponents()
        compomemets.scheme = "https"
        compomemets.host = "dev.shiftkey.com"
        compomemets.path = "/api/v2/available_shifts"
        compomemets.queryItems = []
        compomemets.queryItems?.append(URLQueryItem(name: "address", value: "Dallas, Tx"))
        compomemets.queryItems?.append(URLQueryItem(name: "start", value: "2021-07-25"))
        compomemets.queryItems?.append(URLQueryItem(name: "type", value: "week"))
        
        return compomemets.url!
    }()
    
    private lazy var request = URLRequest(url: url)
    
    private lazy var client = Client(session: .shared, decoder: .shiftsDecoder)
    
    func shifts() -> LoadPublisher<IdentifiedArrayOf<Shift>, ShiftsError> {
        client.decoded(from: request)
            .mapFault(ShiftsError.init(from:))
            .eraseToLoadPublisher()
    }
    
    func shift(id: Shift.ID) -> LoadPublisher<Shift, ShiftsError> {
        client.decoded(from: request)
            .mapItem { (shifts: IdentifiedArrayOf<Shift>) in
                guard let shift = shifts[id: id] else {
                    throw ShiftsError.badIdentifier(id: id)
                }
                
                return shift
            }
            .mapFault(ShiftsError.init(from:))
            .eraseToLoadPublisher()
    }
    
}
