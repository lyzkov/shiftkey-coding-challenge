//
//  ShiftDetailsCore.swift
//  CodingChallange
//
//  Created by lyzkov on 23/06/2021.
//

import Foundation

import Common

import ComposableArchitecture

public enum Details: Core {
    
    public enum Error: ViewableError {
        case unknown(reason: String)
        
        public init(from error: Swift.Error) {
            self = .unknown(reason: error.localizedDescription)
        }
        
        var localizedDescription: String {
            switch self {
            case .unknown(let reason):
                return reason
            }
        }
        
    }
    
    public typealias State = Status<Result<Shift, Error>>

    public enum Action {
        case load(id: Shift.ID)
        case progress(ratio: Ratio)
        case show(item: Shift)
        case unload
    }
    
    public typealias Environment = Main.Environment

    public static var reducer: Details.Reducer {
        .effectless { state, action, environment in
            switch (action, state) {
            case (.progress(let ratio), .pending):
                state = .pending(ratio)
            case (.show, .pending):
                state = .completed(.failure(.unknown(reason: "Operation couldn't be completed.")))
            case (.unload, _):
                state = .idle
            default:
                break
            }
        }
    }
    
}
