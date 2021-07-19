//
//  File.swift
//  
//
//  Created by lyzkov on 08/07/2021.
//

import Foundation

public protocol Module: Core where State: Resolvable, Action: Resolvable, Environment: Resolvable {
    static func register()
}
