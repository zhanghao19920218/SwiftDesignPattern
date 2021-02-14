/// 适配器模式
/// 可担任两个对象间的封装器
/// 接收对于一个对象的调用， 并将其转换为另一个对象可识别的格式和接口。

/// 使用示例： 适配器模式在 Swift 代码中很常见。 基于一些遗留代码的系统常常会使用该模式。 在这种情况下， 适配器让遗留代码与现代的类得以相互合作。

/// The Target defines the domain-specific interface used by the client code
class Target {
    
    func request() -> String {
        return "Target: The default target's behavior" //默认目标表现
    }

}

/// The Adaptee contains some useful behavior, but its interface is incompatible
/// with the existing client code. The Adaptee needs some adaptation before the
/// client code can use it.
class Adaptee {
    
    public func specificRequest() -> String {
        return ".eetpadA eht fo roivaheb laicepS"
    }

}

/// The Adapter makes the Adaptee's interface compatible with the Target's
/// interface.
class Adapter: Target {

    private var adaptee: Adaptee  //需要适配的对象

    init(_ adaptee: Adaptee) {
        self.adaptee = adaptee
    }

    override func request() -> String {
        return "Adapter: (TRANSLATION)" + adaptee.specificRequest().reversed()
    }

}

class Client {
    static func someClientCode(target: Target) {
        print(target.request())
    }
}

print("Client: I can work just fine with the Target objects:")
Client.someClientCode(target: Target())

let adaptee = Adaptee()
print("Client: The Adaptee class has a weird interface. See, I don't understand it:")
print("Adaptee: " + adaptee.specificRequest())

let adapter = Adapter(adaptee)
print("适配后的模式")
print(adapter.request())