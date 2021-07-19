//
//  File.swift
//  
//
//  Created by lyzkov on 16/07/2021.
//

import Foundation

public typealias Loadable<Item, Fault: Error> = Optional<Status<Result<Item, Fault>>>
