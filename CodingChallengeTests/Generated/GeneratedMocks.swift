// MARK: - Mocks generated from file: CodingChallenge/Shifts/Model/Pool/ShiftsPool.swift at 2021-08-10 22:07:18 +0000

//
//  ShiftsPool.swift
//  
//
//  Created by lyzkov on 15/07/2021.
//

import Cuckoo
@testable import CodingChallenge
@testable import Shifts

import Combine
import Common
import Foundation
import IdentifiedCollections


 class MockShiftsPool: ShiftsPool, Cuckoo.ProtocolMock {
    
     typealias MocksType = ShiftsPool
    
     typealias Stubbing = __StubbingProxy_ShiftsPool
     typealias Verification = __VerificationProxy_ShiftsPool

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: ShiftsPool?

     func enableDefaultImplementation(_ stub: ShiftsPool) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func shifts(from date: Date) -> LoadPublisher<IdentifiedArrayOf<Shift>, ShiftsError> {
        
    return cuckoo_manager.call("shifts(from: Date) -> LoadPublisher<IdentifiedArrayOf<Shift>, ShiftsError>",
            parameters: (date),
            escapingParameters: (date),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.shifts(from: date))
        
    }
    
    
    
     func shift(id: Shift.ID) -> LoadPublisher<Shift, ShiftsError> {
        
    return cuckoo_manager.call("shift(id: Shift.ID) -> LoadPublisher<Shift, ShiftsError>",
            parameters: (id),
            escapingParameters: (id),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.shift(id: id))
        
    }
    

	 struct __StubbingProxy_ShiftsPool: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func shifts<M1: Cuckoo.Matchable>(from date: M1) -> Cuckoo.ProtocolStubFunction<(Date), LoadPublisher<IdentifiedArrayOf<Shift>, ShiftsError>> where M1.MatchedType == Date {
	        let matchers: [Cuckoo.ParameterMatcher<(Date)>] = [wrap(matchable: date) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockShiftsPool.self, method: "shifts(from: Date) -> LoadPublisher<IdentifiedArrayOf<Shift>, ShiftsError>", parameterMatchers: matchers))
	    }
	    
	    func shift<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.ProtocolStubFunction<(Shift.ID), LoadPublisher<Shift, ShiftsError>> where M1.MatchedType == Shift.ID {
	        let matchers: [Cuckoo.ParameterMatcher<(Shift.ID)>] = [wrap(matchable: id) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockShiftsPool.self, method: "shift(id: Shift.ID) -> LoadPublisher<Shift, ShiftsError>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_ShiftsPool: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func shifts<M1: Cuckoo.Matchable>(from date: M1) -> Cuckoo.__DoNotUse<(Date), LoadPublisher<IdentifiedArrayOf<Shift>, ShiftsError>> where M1.MatchedType == Date {
	        let matchers: [Cuckoo.ParameterMatcher<(Date)>] = [wrap(matchable: date) { $0 }]
	        return cuckoo_manager.verify("shifts(from: Date) -> LoadPublisher<IdentifiedArrayOf<Shift>, ShiftsError>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func shift<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.__DoNotUse<(Shift.ID), LoadPublisher<Shift, ShiftsError>> where M1.MatchedType == Shift.ID {
	        let matchers: [Cuckoo.ParameterMatcher<(Shift.ID)>] = [wrap(matchable: id) { $0 }]
	        return cuckoo_manager.verify("shift(id: Shift.ID) -> LoadPublisher<Shift, ShiftsError>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class ShiftsPoolStub: ShiftsPool {
    

    

    
     func shifts(from date: Date) -> LoadPublisher<IdentifiedArrayOf<Shift>, ShiftsError>  {
        return DefaultValueRegistry.defaultValue(for: (LoadPublisher<IdentifiedArrayOf<Shift>, ShiftsError>).self)
    }
    
     func shift(id: Shift.ID) -> LoadPublisher<Shift, ShiftsError>  {
        return DefaultValueRegistry.defaultValue(for: (LoadPublisher<Shift, ShiftsError>).self)
    }
    
}



 class MockDefaultShiftsPool: DefaultShiftsPool, Cuckoo.ClassMock {
    
     typealias MocksType = DefaultShiftsPool
    
     typealias Stubbing = __StubbingProxy_DefaultShiftsPool
     typealias Verification = __VerificationProxy_DefaultShiftsPool

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: DefaultShiftsPool?

     func enableDefaultImplementation(_ stub: DefaultShiftsPool) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func shifts(from date: Date) -> LoadPublisher<IdentifiedArrayOf<Shift>, ShiftsError> {
        
    return cuckoo_manager.call("shifts(from: Date) -> LoadPublisher<IdentifiedArrayOf<Shift>, ShiftsError>",
            parameters: (date),
            escapingParameters: (date),
            superclassCall:
                
                super.shifts(from: date)
                ,
            defaultCall: __defaultImplStub!.shifts(from: date))
        
    }
    
    
    
     override func shift(id: Shift.ID) -> LoadPublisher<Shift, ShiftsError> {
        
    return cuckoo_manager.call("shift(id: Shift.ID) -> LoadPublisher<Shift, ShiftsError>",
            parameters: (id),
            escapingParameters: (id),
            superclassCall:
                
                super.shift(id: id)
                ,
            defaultCall: __defaultImplStub!.shift(id: id))
        
    }
    

	 struct __StubbingProxy_DefaultShiftsPool: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func shifts<M1: Cuckoo.Matchable>(from date: M1) -> Cuckoo.ClassStubFunction<(Date), LoadPublisher<IdentifiedArrayOf<Shift>, ShiftsError>> where M1.MatchedType == Date {
	        let matchers: [Cuckoo.ParameterMatcher<(Date)>] = [wrap(matchable: date) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockDefaultShiftsPool.self, method: "shifts(from: Date) -> LoadPublisher<IdentifiedArrayOf<Shift>, ShiftsError>", parameterMatchers: matchers))
	    }
	    
	    func shift<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.ClassStubFunction<(Shift.ID), LoadPublisher<Shift, ShiftsError>> where M1.MatchedType == Shift.ID {
	        let matchers: [Cuckoo.ParameterMatcher<(Shift.ID)>] = [wrap(matchable: id) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockDefaultShiftsPool.self, method: "shift(id: Shift.ID) -> LoadPublisher<Shift, ShiftsError>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_DefaultShiftsPool: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func shifts<M1: Cuckoo.Matchable>(from date: M1) -> Cuckoo.__DoNotUse<(Date), LoadPublisher<IdentifiedArrayOf<Shift>, ShiftsError>> where M1.MatchedType == Date {
	        let matchers: [Cuckoo.ParameterMatcher<(Date)>] = [wrap(matchable: date) { $0 }]
	        return cuckoo_manager.verify("shifts(from: Date) -> LoadPublisher<IdentifiedArrayOf<Shift>, ShiftsError>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func shift<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.__DoNotUse<(Shift.ID), LoadPublisher<Shift, ShiftsError>> where M1.MatchedType == Shift.ID {
	        let matchers: [Cuckoo.ParameterMatcher<(Shift.ID)>] = [wrap(matchable: id) { $0 }]
	        return cuckoo_manager.verify("shift(id: Shift.ID) -> LoadPublisher<Shift, ShiftsError>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class DefaultShiftsPoolStub: DefaultShiftsPool {
    

    

    
     override func shifts(from date: Date) -> LoadPublisher<IdentifiedArrayOf<Shift>, ShiftsError>  {
        return DefaultValueRegistry.defaultValue(for: (LoadPublisher<IdentifiedArrayOf<Shift>, ShiftsError>).self)
    }
    
     override func shift(id: Shift.ID) -> LoadPublisher<Shift, ShiftsError>  {
        return DefaultValueRegistry.defaultValue(for: (LoadPublisher<Shift, ShiftsError>).self)
    }
    
}

