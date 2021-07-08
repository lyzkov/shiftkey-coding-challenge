//
//  ModuleViewable.swift
//  
//
//  Created by lyzkov on 07/07/2021.
//

import Foundation
import SwiftUI

public protocol ModuleViewable: Module {
    associatedtype TrunkView: View
    
    static func trunkView() -> TrunkView
}
