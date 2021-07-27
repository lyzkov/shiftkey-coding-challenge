//
//  ListCore.swift
//  CodingChallenge
//
//  Created by lyzkov on 23/06/2021.
//

import Foundation

import Common

import ComposableArchitecture

public enum List: Core {
    
    public typealias PageByDate<Elememt, Error> = Page<Date, Elememt, Error>
    where Elememt: Identifiable, Error: Swift.Error
    
    public typealias State = IdentifiedArrayOf<PageByDate<Shift, ShiftsError>>
    
    public enum Action {
        case show(from: Date = Date())
        case load(State.Element)
    }
    
    public typealias Environment = Main.Environment
    
    public static var reducer: List.Reducer {
        .init { state, action, environment in
            switch action {
            case .show(let date):
                return environment.pool.shifts(from: date)
                    .map { items in PageByDate(index: date, items: items) }
                    .map(Action.load)
                    .receive(on: environment.mainQueue)
                    .eraseToEffect()
            case .load(let page):
                state[id: page.id] = page
                if let next = page.next {
                    state.append(next)
                }
            }
            return .none
        }
    }
    
}

extension Page where Index == Date {
    
    var currentDate: Date {
        index
    }
    
    var nextDate: Date {
        index.advanced(by: 60*60*24*7) // TODO: declarative date interval (from third party?)
    }
    
    public var next: Page? {
        items.succeeded() && !isEmpty ? Page(index: nextDate, items: .none) : nil
    }
    
    public var isEmpty: Bool {
        items.isEmpty()
    }
    
}
