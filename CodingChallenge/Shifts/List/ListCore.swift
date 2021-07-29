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
    
    public typealias State = Feed<Shift, ShiftsError, Date>
    
    public enum Action {
        case show(from: Date = .currentStartOfWeekInDallas())
        case load(State.Element)
    }
    
    public typealias Environment = Main.Environment
    
    public static var reducer: List.Reducer {
        .init { state, action, environment in
            switch action {
            case .show(let date):
                return environment.pool.shifts(from: date)
                    .map { items in
                        Page(index: date, items: items)
                    }
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
    
    var next: Page? {
        !isEmpty ? Page(index: index.nextWeek()) : nil
    }
    
    var isEmpty: Bool {
        items.isEmpty()
    }
    
}
