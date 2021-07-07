//
//  Container.swift
//  TestUI
//
//  Created by Luca Berardinelli on 06/07/21.
//

import Foundation
/// The closure executed by a `Container` to resolve a registered type.
public typealias FactoryClosure = (Container) -> AnyObject

public enum ContainerResolveMode {
    /// Instantiates a new instance on every call to resolve.
    case newInstance
    /// Instantiates a single instance on the first call to resolve, then returns always the same instance.
    case lazily
}

/// The common interface for a `Container`.
public protocol ContainerProtocol {
    
    /// It registers a type and stores the closure needed to resolve it.
    /// - Parameters:
    ///   - type: The type to register.
    ///   - mode: The mode used to resolve the type.
    ///   - factoryClosure: The closure to resolve the registered type.
    func register<Service>(type: Service.Type, mode: ContainerResolveMode, factoryClosure: @escaping FactoryClosure)
    
    /// It resolves the concrete instance for a registered type.
    ///
    /// If it cannot resolve the type, it throws a fatal error.
    /// - Parameter type: The type to resolve.
    func resolve<Service>(type: Service.Type) -> Service
}

open class Container: ContainerProtocol {

    private var registrations = Dictionary<String, ServiceRegistration>()
    
    public init() {}
    
    open func register<Service>(type: Service.Type, mode: ContainerResolveMode = .newInstance, factoryClosure: @escaping FactoryClosure) {
        registrations["\(type)"] = ServiceRegistration(closure: factoryClosure, mode: mode, resolvedInstance: nil)
    }
    
    open func resolve<Service>(type: Service.Type) -> Service {
        guard let registration = registrations["\(type)"] else {
            fatalError("\(type) cannot be resolved!")
        }
        switch registration.mode {
        case .newInstance:
            guard let service = registration.closure(self) as? Service else {
                fatalError("\(type) cannot be resolved!")
            }
            return service
        case .lazily:
            if let instance = registration.resolvedInstance {
                guard let service = instance as? Service else {
                    fatalError("\(type) cannot be resolved!")
                }
                return service
            } else {
                guard let service = registration.closure(self) as? Service else {
                    fatalError("\(type) cannot be resolved!")
                }
                registrations["\(type)"] = ServiceRegistration(closure: registration.closure, mode: registration.mode, resolvedInstance: service as AnyObject)
                return service
            }
        }
    }

}

extension Container {
    private struct ServiceRegistration {
        let closure: FactoryClosure
        let mode: ContainerResolveMode
        let resolvedInstance: AnyObject?
    }
}
