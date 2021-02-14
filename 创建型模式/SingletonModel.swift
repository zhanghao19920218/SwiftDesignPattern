import Foundation

/// The Singleton class defines the `shared` field that lets clients access the
/// unique singleton instance.
class Singleton {
    /// The static field that controls the access to the singleton instance.
    ///
    /// This implementation let you extend the Singleton class while keeping
    /// just one instance of each subclass around.
    static let shared: Singleton = {
        let instance = Singleton()

        return instance
    }()

    /// The Singleton's initializer should always be private to prevent direct
    /// construction calls with the `new` operator.
    private init() {}
    
    /// Finally, any singleton should define some business logic, which can be
    /// executed on its instance.
    func someBusinessLogic() -> String {
        return "Result of the 'someBusinessLogic' call"
    }
    
}

/// 单例模式不能被克隆
extension  Singleton: NSCopying, Equatable  {

    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }

    /// MARK: - Equatable
    static func == (lhs: Singleton, rhs: Singleton) -> Bool {
        return lhs.someBusinessLogic() == lhs.someBusinessLogic()
    }
    
}

/// The client code
class Client {
    static func someClientCode() {
        let instance1 = Singleton.shared
        let instance2 = Singleton.shared

        if (instance1 == instance2) {
            print("Singleton works, both variables contain the same instance.")
        } else {
            print("Singleton failed, variables contain different instances.")
        }
    }
}

Client.someClientCode()