//
//  Store+View.swift
//  CodingChallenge
//
//  Created by lyzkov on 13/07/2021.
//

import Foundation

import ComposableArchitecture

extension Store {

    public func scopeToView<ViewableState: ViewItem>() -> Store<ViewableState, Action>
        where State == ViewableState.Core {
        scope { state in ViewableState(from: state) }
    }

}
