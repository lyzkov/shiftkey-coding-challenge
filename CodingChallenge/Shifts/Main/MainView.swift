//
//  MainView.swift
//  CodingChallenge
//
//  Created by lyzkov on 19/07/2021.
//

import Foundation
import SwiftUI

import Common

extension Main {

    public enum Error: ViewableError {
        case unknown(reason: String)

        public init(from coreError: ShiftsError) {
            self = .unknown(reason: coreError.localizedDescription)
        }

        var localizedDescription: String {
            switch self {
            case .unknown(let reason):
                return reason
            }
        }

    }

    static public func trunkView() -> some SwiftUI.View {
        List.View()
    }

    public typealias View = TransparentView<Main.State, Void>

}
