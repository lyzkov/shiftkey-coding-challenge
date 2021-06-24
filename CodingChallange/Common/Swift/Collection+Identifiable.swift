//
//  Collection+Identifiable.swift
//  CodingChallange
//
//  Created by lyzkov on 23/06/2021.
//

import Foundation

extension Collection where Element: Identifiable {
    
    public func first(by id: Element.ID) -> Element? {
        first { element in
            element.id == id
        }
    }
    
}
