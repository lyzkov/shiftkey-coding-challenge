//
//  File.swift
//  
//
//  Created by lyzkov on 13/07/2021.
//

import Foundation
import SwiftUI

import ComposableArchitecture

extension CaseLet {
    
    public init(
      state toLocalState: @escaping (GlobalState) -> LocalState?,
      @ViewBuilder then content: @escaping (Store<LocalState, LocalAction>) -> Content
    ) where LocalAction == GlobalAction {
        self.init(state: toLocalState, action: { $0 }, then: content)
    }
    
}
