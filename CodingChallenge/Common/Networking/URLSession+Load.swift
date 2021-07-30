//
//  URLSession+Load.swift
//  
//
//  Created by lyzkov on 25/07/2021.
//

import Foundation
import Combine

public extension URLSession {
    
    struct DataTaskLoadPublisher: Publisher {
        public typealias Output = Load<Data, Error>
        public typealias Failure = Never
        
        private let session: URLSession
        
        private let request: URLRequest
        
        public init(session: URLSession, request: URLRequest) {
            self.session = session
            self.request = request
        }
        
        public func receive<S: Subscriber>(
            subscriber: S
        ) where S.Input == Output, S.Failure == Failure {
            subscriber.receive(
                subscription: Subscription(
                    session: session,
                    request: request,
                    downstream: subscriber
                )
            )
            
            _ = subscriber.receive(.pending(0))
        }
        
    }
    
    func dataTaskLoadPublisher(for request: URLRequest) -> DataTaskLoadPublisher {
        .init(session: self, request: request)
    }
    
}

extension URLSession.DataTaskLoadPublisher {
    
    fileprivate class Subscription: Combine.Subscription {
        
        let dataTask: URLSessionDataTask
        
        let progressObservation: NSKeyValueObservation
        
        init<S: Subscriber>(
            session: URLSession,
            request: URLRequest,
            downstream: S
        ) where S.Input == Output, S.Failure == Failure {
            dataTask = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    _ = downstream.receive(.failure(error))
                } else if let data = data {
                    _ = downstream.receive(.success(data))
                }
                downstream.receive(completion: .finished)
            }
            
            progressObservation = dataTask.progress
                .observe(\.fractionCompleted) { progress, _ in
                    _ = downstream.receive(.pending(Float(progress.fractionCompleted)))
                }
            
            dataTask.resume()
        }
        
        func request(_ demand: Subscribers.Demand) {
        }
        
        func cancel() {
            progressObservation.invalidate()
            dataTask.cancel()
        }
        
    }
    
}
