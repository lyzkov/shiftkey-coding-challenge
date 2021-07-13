//
//  ShiftItem.swift
//  CodingChallange
//
//  Created by lyzkov on 10/06/2021.
//

import Foundation

import Common

extension List {
    
    public struct Item: Identifiable {
        public let id: UUID
        public let start: Date
        public let end: Date
        public let facility: String
    }
    
}

extension List.Item: Viewable {
    
    public init(from entity: Shift) {
        id = entity.id
        start = entity.start
        end = entity.end
        facility = entity.facility.name
    }
    
}

extension List.Item: Fakeable {
    
    public static func fake() -> Self {
        Self(
            id: UUID(),
            start: Date(),
            end: Date().addingTimeInterval(5),
            facility: "Skilled Nursing Facility"
        )
    }
    
}

