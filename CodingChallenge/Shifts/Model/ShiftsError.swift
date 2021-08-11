//
//  ShiftsError.swift
//  CodingChallenge
//
//  Created by lyzkov on 15/07/2021.
//

import Foundation

public enum ShiftsError: Error, Equatable {
    case unknown
    case badIdentifier(id: Shift.ID)

    init(from error: Error) {
        if let error = error as? Self {
            self = error
        } else {
            self = .unknown
        }
    }

}
