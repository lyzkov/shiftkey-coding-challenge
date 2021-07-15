//
//  Viewable.swift
//  CodingChallange
//
//  Created by lyzkov on 17/06/2021.
//

import Foundation

import SwiftUI

public protocol Viewable: Equatable {
    associatedtype Core
    
    init(from entity: Core)
}

public protocol ViewableError: Viewable, Error where Core: Error {
}

public protocol ComposableView: View {
    associatedtype State: Viewable
}
