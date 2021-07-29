//
//  File.swift
//  File
//
//  Created by lyzkov on 29/07/2021.
//

import Foundation

import IdentifiedCollections

public typealias Feed<Item, Fault, Index> = IdentifiedArrayOf<Page<Item, Fault, Index>>
where Item: Identifiable, Fault: Error, Index: Hashable
