import UIKit

var greeting = "Hello, playground"

// 1. Swift5 存储属性
class Phone {
    var system = "iOS"
    
    // 常量存储属性，一旦实例化，不能修改
    let brand: String
    
    // 存储属性，可以修改
    var price: Int
    
    // 当类被实例化时，要保证所有的属性都初始化完成，除非属性有默认值
    init(brand: String, price: Int) {
        self.brand = brand
        self.price = price
        print("brand: \(brand), price: \(price)")
    }
}

// 修改类的属性值
let iPhone = Phone(brand: "iPhone", price: 5999)
iPhone.price -= 600

// 延时存储属性：当类初始化时，延时存储属性不被初始化，当被调用时才初始化
class Consumer {
    var money: Int
    lazy var phone: Phone = Phone(brand: "iPhone", price: 6999)
    
    init(money: Int) {
        self.money = money
    }
}

// 只初始化了money
var richMan = Consumer(money: 100_000)
// 延时属性 phone 被初始化
print(richMan.phone) // brand: iPhone, price: 6999


// 2. Swift5 计算属性
class Android {
    // 常量存储属性，一旦实例化，不能修改
    let system: String = "android"
    // 存储属性
    var version = "12"
    // api 级别
    var apiLevel: String = "31"
    
    // 计算属性，向外提供接口访问类实例的某种状态，这种状态和类实例的属性值相关联
    var info: String {
        get {
            return "system: \(system), version: \(version), level: \(apiLevel)"
        }
        set {
            // 默认使用 newValue 指代新值
            version = newValue.split(separator: "-").first?.description ?? ""
            apiLevel = newValue.split(separator: "-").last?.description ?? ""
        }
    }
    
    // 计算属性 价格，简单模拟
    var price: ClosedRange<Int> {
        get {
            // 当版本高于30时，价格在[4000,6999]之间
            if (apiLevel > "30") {
                return 4000...6999
            } else {
                return 1000...3999
            }
        }
        // 自定义传值名称 newPrice
        set(newPrice) {
            // 当价格高于3999时，版本为31
            if (newPrice.lowerBound > 3999) {
                apiLevel = "31"
                version = "12"
            } else {
                apiLevel = "30"
                version = "11"
            }
        }
    }

}

var newPhone = Android()
print(newPhone.info) // system: android, version: 12, level: 31

newPhone.info = "11-30"
print(newPhone.info) // system: android, version: 11, level: 30

newPhone.price = 4000...4999
print(newPhone.info) // system: android, version: 12, level: 31


// 3. Swift5 属性监听器
class iOS {
     
    var brand: String {
        // 此属性将要被赋值时会调用，默认带一个 newValue 字段。
        // 注意：初始化时不会被调用，从第二次赋值时才开始被调用
        willSet {
            print("new value : \(newValue)")
        }
        // 此属性已经被赋值后会调用，默认带一个 oldValue 字段
        didSet {
            print("old value : \(oldValue)")
        }
    }
    
    var price: Int {
        // 自定义传值名称
        willSet(newPrice) {
            print("new price : \(newPrice)")
        }
        // 自定义传值名称
        didSet(oldPrice) {
            print("old price : \(oldPrice)")
        }
    }
        
    init(brand: String, price: Int) {
        self.brand = brand
        self.price = price
        print("brand: \(brand), price: \(price)")
    }
}

let newIPhone = iOS(brand: "iphone 12", price: 5999)
newIPhone.brand = "iphone 13"
newIPhone.price = 6999


// 4. Swift5 属性包装器
@propertyWrapper
struct StringNotEmpty {
    var value: String
    
    init() {
        self.value = "default string"
    }
    
    var wrappedValue: String {
        get { return value }
        set {
            if (newValue.count > 0) {
                self.value = newValue
            } else {
                self.value = "default string"
            }
        }
    }
}

class Student: CustomStringConvertible {
    @StringNotEmpty
    var name: String
    
    var description: String {
        return "student's name is \(name)"
    }
}

let student = Student()
student.name = ""
print(student) // student's name is default string


// 5. Swift5 静态属性与静态方法
class BaseClass {
    // 静态存储属性
    static var param = "param"
    
    // 静态计算属性
    static var computeParam: String {
        return "computeParam"
    }
    
    // 可被继承的静态计算属性
    class var openParam: String {
        return "openParam"
    }
    
    // 声明静态方法，即类方法
    static func method() {
        print("static method")
    }
    
    // 声明可被继承的静态方法
    class func openMethod() {
        print("static openMethod")
    }
}

class SubClass : BaseClass {
    // 重写父类的 openParam 属性，类似于 Kotlin 的 open 修饰
    override class var openParam: String {
        return "SubClass openParam"
    }
    
    override class func openMethod() {
        print("SubClass openMethod")
    }
}

// 调用静态属性
BaseClass.param
BaseClass.computeParam
BaseClass.openParam
SubClass.openParam

// 调用静态方法
BaseClass.method()
BaseClass.openMethod()
SubClass.openMethod()


// 6. Swift5 下标方法
// 为自定义的数据类型使用 subscript 定义下标访问元素的方法
class CustomList {
    var list: Array<String>
    init(list: String...) {
        self.list = list
    }
    
    // 定义下标方法
    subscript(index: Int) -> String {
        set {
            list[index] = newValue
        }
        // 可以只定义get
        get {
            return list[index]
        }
    }
}

let list = CustomList(list: "1", "2", "3")
list[0] = "item 1"
print(list[1])


