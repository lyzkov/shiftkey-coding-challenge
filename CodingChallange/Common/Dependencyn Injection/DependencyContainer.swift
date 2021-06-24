//
//  DependencyContainer.swift
//  CodingChallange
//
//  Created by lyzkov on 22/06/2021.
//

import Foundation

final class DependencyContainer {
    private var dependencies = [String: (() -> AnyObject)]()
    private static var shared = DependencyContainer()

    static func register<T>(_ dependency: T) where T: AnyObject {
        shared.register(dependency)
    }

    static func resolve<T>() -> T {
        shared.resolve()
    }

    private func register<T>(_ dependency: T) where T: AnyObject {
        let key = String(describing: T.self)
        dependencies[key] = { [weak dependency] in dependency as AnyObject }
    }

    private func resolve<T>() -> T {
        let key = String(describing: T.self)
        let dependency = dependencies[key]?() as? T

        precondition(dependency != nil, "No dependency found for \(key)! must register a dependency before resolve.")

        return dependency!
    }
}
