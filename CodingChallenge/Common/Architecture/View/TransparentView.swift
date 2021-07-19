//
//  File.swift
//  
//
//  Created by lyzkov on 11/07/2021.
//

import Foundation
import SwiftUI

public struct TransparentView<CoreState>: ComposableView {

    public struct State: Viewable, Equatable {
        public init(from entity: CoreState) {
        }
    }

    public var body: some View {
        Color.clear
    }
    
    public init() where CoreState == Void {
    }

}
