//
//  ShiftItem.swift
//  CodingChallange
//
//  Created by Piotr Bogusław Łyczba on 10/06/2021.
//

import Foundation

struct ShiftItem: Identifiable {
    let id = UUID()
    let start: Date
    let end: Date
    let facility: String
}

extension ShiftItem: Fakeable {
    
    static func fake() -> Self {
        ShiftItem(
            start: Date(),
            end: Date().addingTimeInterval(5),
            facility: "Skilled Nursing Facility"
        )
    }
    
}
