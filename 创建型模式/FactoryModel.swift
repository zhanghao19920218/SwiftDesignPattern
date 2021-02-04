// Creator协议表明工厂方法允许返回一个Product类
// Creator的遵循者通常提供这个方法的具体实现
protocol Creator {
    
    /// Creator同样可以提供一些默认的实现工厂方法
    func factoryMethod() -> Product

    /// Also note that, despite its name, the Creator's primary responsibility
    /// is not creating products. Usually, it contains some core business logic
    /// that relies on Product objects, returned by the factory method.
    /// Subclasses can indirectly change that business logic by overriding the
    /// factory method and returning a different type of product from it.
    func someOperation() -> String
}

/// The Product protocol declares the operations that all concrete products must
/// implement.
protocol Product {

    func operation() -> String

}

/// This extension implements the default behavior of the Creator. This behavior
/// can be overridden in subclasses.
extension Creator {
    func someOperation() -> String {
        // Call the factory method to create a Product object
        let product = factoryMethod()

        // Now, use the product
        return "Creator: The same creator's code has just worked with " + product.operation()
    }
}

/// Concrete Products provide various implementations of the Product protocol.
class ConcreteProduct1: Product {

    func operation() -> String {
        return "{Result of the ConcreteProduct1}"
    }
}


/// Concrete Creators override the factory method in order to change the
/// resulting product's type.
class ConcreteCreator1: Creator {

    /// Note that the signature of the method still uses the abstract product
    /// type, even though the concrete product is actually returned from the
    /// method. This way the Creator can stay independent of concrete product
    /// classes.
    public func factoryMethod() -> Product {
        return ConcreteProduct1()
    }

}

let creator = ConcreteCreator1().someOperation()
print(creator);