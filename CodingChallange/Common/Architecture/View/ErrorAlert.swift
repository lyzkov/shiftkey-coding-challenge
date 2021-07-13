//
//  File.swift
//  
//
//  Created by lyzkov on 11/07/2021.
//

import Foundation
import SwiftUI

public struct ErrorAlert: View {
    @State var isPresented: Bool = true

    let error: Error
    let dismiss: () -> Void
    let retry: () -> Void

    public var body: some View {
        Text("Oooops... Something went wrong!")
            .alert(isPresented: $isPresented) {
                Alert(
                    title: Text("Error"),
                    message: Text(error.localizedDescription),
                    primaryButton: .default(Text("OK"), action: dismiss),
                    secondaryButton: .default(Text("Retry"), action: retry)
                )
            }
    }
    
    public init(_ error: Error, dismiss: @escaping () -> Void, retry: @escaping () -> Void) {
        self.error = error
        self.dismiss = dismiss
        self.retry = retry
    }

}
