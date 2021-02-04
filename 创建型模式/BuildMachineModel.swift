// 使用函数链方式来生成, Swift配置选项

// 一个抽象类和实例化的类
// 一个主管来组成常用的Object生成步骤
// 模式的各个元素以创建步骤联系

/// The Builder interface specifies methods for creating the different parts of
/// the Product objects.
protocol Builder {
    
    func producePartA() // 创建产品a
    func producePartB() // 创建产品b
    func producePartC() // 创建产品c

}

/// The Concrete Builder classes follow the Builder interface and provide
/// specific implementations of the building steps. Your program may have
/// several variations of Builders, implemented differently.
class ConcreteBuilder: Builder {
    /// A fresh builder instance should contain a blank product object, which is
    /// used in further assembly.

    private var product = Product1()

    // 重新设置
    func reset() {
        product = Product1()
    }

    /// All production steps work with the same product instance.
    func producePartA() {
        product.add(part: "PartA")
    }

    func producePartB() {
        product.add(part: "PartB")
    }

    func producePartC() {
        product.add(part: "PartC")
    }

    // Concrete Builders are supposed to provide their own methods for
    /// retrieving results. That's because various types of builders may create
    /// entirely different products that don't follow the same interface.
    /// Therefore, such methods cannot be declared in the base Builder interface
    /// (at least in a statically typed programming language).
    ///
    /// Usually, after returning the end result to the client, a builder
    /// instance is expected to be ready to start producing another product.
    /// That's why it's a usual practice to call the reset method at the end of
    /// the `getProduct` method body. However, this behavior is not mandatory,
    /// and you can make your builders wait for an explicit reset call from the
    /// client code before disposing of the previous result.
    func retrieveProduct() -> Product1 {
        let result = self.product
        reset()
        return result
    }
}

/// It makes sense to use the Builder pattern only when your products are quite
/// complex and require extensive configuration.
///
/// Unlike in other creational patterns, different concrete builders can produce
/// unrelated products. In other words, results of various builders may not
/// always follow the same interface.
class Product1 {

    private var parts = [String]()

    func add(part: String) {
        self.parts.append(part)
    }

    func listParts() -> String {
        return "Product parts: " + parts.joined(separator: ", ") + "\n"
    }
}

/// The Director is only responsible for executing the building steps in a
/// particular sequence. It is helpful when producing products according to a
/// specific order or configuration. Strictly speaking, the Director class is
/// optional, since the client can control builders directly.
class Director {

    private var builder: Builder?

    /// The Director works with any builder instance that the client code passes
    /// to it. This way, the client code may alter the final type of the newly
    /// assembled product.
    func update(builder: Builder) {
        self.builder = builder
    }

    /// The Director can construct several product variations using the same
    /// building steps.
    func buildMinimalViableProduct() {
        builder?.producePartA()
    }

    func buildFullFeaturedProduct() {
        builder?.producePartA()
        builder?.producePartB()
        builder?.producePartC()
    }

}

/// The client code creates a builder object, passes it to the director and then
/// initiates the construction process. The end result is retrieved from the
/// builder object.
class Client {
    static func someClientCode(director: Director) {
        let builder = ConcreteBuilder() // 创建一个构建类
        director.update(builder: builder)

        print("标准基本产品:")
        director.buildMinimalViableProduct()
        print(builder.retrieveProduct().listParts())

        print("标准全部属性产品")
        director.buildFullFeaturedProduct()
        print(builder.retrieveProduct().listParts())

        print("自定义产品:")
        builder.producePartA()
        builder.producePartB()
        print(builder.retrieveProduct().listParts())
    }
}

Client.someClientCode(director: Director())