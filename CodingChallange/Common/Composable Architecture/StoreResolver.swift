//
//  StoreResolver.swift
//  
//
//  Created by lyzkov on 02/07/2021.
//

import Foundation

import ComposableArchitecture

public final class StoreResolver {
    
    private static var reducer: Reducer<AppState, AppAction, AppEnvironment> = .empty
    
    private static var appState: AppState = .init()
    
    private static var appEnvironment: AppEnvironment = .init()
    
    public static var shared = StoreResolver()
    
    private let appStore: Store<AppState, AppAction>
    
    public init() {
        appStore = .init(
            initialState: Self.appState,
            reducer: StoreResolver.reducer,
            environment: Self.appEnvironment
        )
    }
    
    public static func register<State: MainState, Action: MainAction, Environment: MainEnvironemnt>(
        reducer: Reducer<State, Action, Environment>
    ) {
        appState.register(State.self)
        appEnvironment.register(Environment.self)
        Self.reducer = Self.reducer.combined(with: reducer.pullbackToRoot())
    }
    
    public func resolve<State: MainState, Action: MainAction>() -> Store<State, Action> {
        appStore.subscope()
    }
    
}

@propertyWrapper
public struct Register<State: MainState, Action: MainAction, Environment: MainEnvironemnt> {
    public var wrappedValue: Reducer<State, Action, Environment>
    
    public init(wrappedValue reducer: Reducer<State, Action, Environment>) {
        StoreResolver.register(reducer: reducer)
        wrappedValue = reducer
    }
    
}

@propertyWrapper
public struct Resolve<ScopedState, ScopedAction> {
    
    public var wrappedValue: Store<ScopedState, ScopedAction>
    
    public init<State: MainState, Action: MainAction>(
        state: @escaping (State) -> ScopedState,
        action: @escaping (ScopedAction) -> Action
    ) {
        wrappedValue = StoreResolver.shared.resolve()
            .scope(state: state, action: action)
    }
    
    public init() where ScopedState: MainState, ScopedAction: MainAction {
        wrappedValue = StoreResolver.shared.resolve()
    }
    
}
