//
//  ListView.swift
//  CodingChallenge
//
//  Created by lyzkov on 4/7/21.
//

import SwiftUI

import Common

import ComposableArchitecture

extension Shifts.List {

    public struct View: ComposableView {

        public typealias State = Feed<Item, Main.Error, Date>

        @Resolve(state: \Main.State.list, action: Main.Action.list)
        public var store: Store<State, Action>

        @SwiftUI.State var selected: Item?

        public var body: some SwiftUI.View {
            NavigationView {
                FeedView(with: store, onAppearSend: .show()) { pageStore in
                    PageView(with: pageStore, load: Shifts.List.Action.show) { itemStore in
                        let item = itemStore.state
                        List.ItemView(item: item)
                            .onTapGesture {
                                selected = item
                            }
                    } progress: { value in
                        ProgressView(value: value)
                    } header: { date in
                        HStack {
                            Text(date, style: .date)
                            Text(date, style: .time)
                        }
                    }
                }
                .sheet(item: $selected) { item in
                    Details.View(id: item.id)
                }
                .navigationTitle("Shifts")
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }

}

#if DEBUG

extension Shifts.List.View: FakeView {

    public static func fake(with state: State) -> Self {
        var view = Self.init()
        view.store = .init(
            initialState: state,
            reducer: .empty,
            environment: Shifts.List.Environment()
        )

        return view
    }

}

struct ListView_Previews: PreviewProvider {

    static let fakes = (3...60).map { _ in Shifts.List.Item(from: .fake()) }

    static var previews: some SwiftUI.View {
        Shifts.List.View.fake(
            with: [
                Page(index: Date(), items: .completed(.success(.init(uniqueElements: fakes))))
            ]
        )
    }

} // Nice parenthesis doom!

#endif
