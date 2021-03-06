//
//  StoreResolver.swift
//  
//
//  Created by lyzkov on 02/07/2021.
//

import Foundation

import ComposableArchitecture

public final class StoreResolver {

    private static var reducer: RootReducer = .empty

    private static var appState: RootState = .init()

    private static var appEnvironment: RootEnvironment = .init()

    public static var shared = StoreResolver()

    private let appStore: RootStore

    public init() {
        appStore = .init(
            initialState: Self.appState,
            reducer: StoreResolver.reducer,
            environment: Self.appEnvironment
        )
    }

    public static func register<State, Action, Environment>(
        reducer: Reducer<State, Action, Environment>
    ) where State: Resolvable, Environment: Resolvable {
        appState.register(State.self)
        appEnvironment.register(Environment.self)
        Self.reducer = Self.reducer.combined(with: reducer.pullbackToRoot())
    }

    public func resolve<State: Resolvable, Action>() -> Store<State, Action> {
        appStore.subscope()
    }

}

@propertyWrapper
public struct Register<State: Resolvable, Action, Environment: Resolvable> {
    public var wrappedValue: Reducer<State, Action, Environment>

    public init(wrappedValue reducer: Reducer<State, Action, Environment>) {
        StoreResolver.register(reducer: reducer)
        wrappedValue = reducer
    }

}

@propertyWrapper
public struct Resolve<ScopedState, ScopedAction> {

    public var wrappedValue: Store<ScopedState, ScopedAction>

    public init() where ScopedState: Resolvable {
        wrappedValue = StoreResolver.shared.resolve()
    }

}

extension Resolve where ScopedState: ViewItem {

    public init<State: Resolvable, Action>(
        state toState: @escaping (State) -> ScopedState.Core,
        action toAction: @escaping (ScopedAction) -> Action
    ) {
        wrappedValue = StoreResolver.shared.resolve()
            .scope(state: toState, action: toAction)
            .scopeToView()
    }

}
