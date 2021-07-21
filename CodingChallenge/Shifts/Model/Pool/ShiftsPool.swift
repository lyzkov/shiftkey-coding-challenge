//
//  ShiftsPool.swift
//  
//
//  Created by lyzkov on 15/07/2021.
//

import Foundation
import Combine

import Common

class ShiftsPool {
    
    typealias PoolPublisher<Success, Fault> = AnyPublisher<Status<Result<Success, Fault>>, Never>
        where Fault: Error
    
    lazy var client = Client()
    
    // TODO: Endpoint abstraction
    let url: URL = {
        // Notice: building URLs in NSSwift is so imperative and prone to type unsafe typos!
        var compomemets = URLComponents()
        compomemets.scheme = "https"
        compomemets.host = "dev.shiftkey.com"
        compomemets.path = "/api/v2/available_shifts"
        compomemets.queryItems = []
        compomemets.queryItems?.append(URLQueryItem(name: "address", value: "Dallas, Tx"))
        compomemets.queryItems?.append(URLQueryItem(name: "start", value: "2021-07-19"))
        compomemets.queryItems?.append(URLQueryItem(name: "type", value: "week"))
        
        return compomemets.url!
    }()
    
    func shifts() -> PoolPublisher<[Shift], PoolError> {
        client
            .decoded(from: URLRequest(url: url))
            .map { status in
                status.mapError { error in
                    .unknown // TODO: convertible pool errors
                }
            }
            .eraseToAnyPublisher()
    }
    
    func shift(id: Shift.ID) -> PoolPublisher<Shift, PoolError> {
        shifts()
            .map { status in
                status.compactMap(replaceNil: .unknown) { shifts in
                    shifts.first(by: id)
                }
            }
            .eraseToAnyPublisher()
    }
    
}
