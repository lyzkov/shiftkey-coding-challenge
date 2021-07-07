//
//  File.swift
//  
//
//  Created by lyzkov on 07/07/2021.
//

import Foundation
import SwiftUI

public protocol Module {
    associatedtype View: SwiftUI.View
    
    var view: View { get }
    
    init()
}
