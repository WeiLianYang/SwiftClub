import UIKit

var greeting = "Hello, playground"

// 只需要少量的简单数据类型的属性
// 在传输数据时需要复制而不是影响原变量
// 不需要继承其他类

// 定义结构体
struct Phone {
    
    // 定义价格属性
    var price: Int
    
    // 定义品牌属性
    var brand: String
    
    // 定义型号属性
    var model: String
    
    // 定义降价促销方法
    mutating func discount() {
        price -= 800
    }
}

// 调用默认的构造方法，创建结构体实例
let iPhone = Phone(price: 6999, brand: "iPhone", model: "iPhone 13")
print("手机品牌：\(iPhone.brand), 型号：\(iPhone.model)，价格：\(iPhone.price)" )

// 结构体属于值类型，用 let 修饰后无法修改 phone 的属性值
var phone = iPhone
phone.price -= 1000
// 值修改后不会影响原结构体的值，iPhone.price: 6999, phone.price: 5999
print("iPhone.price: \(iPhone.price), phone.price: \(phone.price)")


// 定义一个类
class PhoneClass {
    
    // 定义价格属性
    var price: Int = 0
    
    // 定义品牌属性
    var brand: String = ""
    
    // 定义型号属性
    var model: String = ""
    
    // 定义降价促销方法
    func discount() {
        price -= 800
    }
    
    // 当三个属性都有默认值的时候，可以不写 init
    init(price: Int, brand: String, model: String) {
        self.price = price
        self.brand = brand
        self.model = model
    }
}
// 创建 class 实例
var huaweiPhone = PhoneClass(price: 5999, brand: "huawei", model: "p40 pro")

// 类属于引用类型，变量传递后，修改值会影响引用的变量
let huaweiNewPhone = huaweiPhone
huaweiPhone.price += 1000
// 值修改后会影响原变量的值，huaweiPhone.price: 6999, huaweiNewPhone.price: 6999
print("huaweiPhone.price: \(huaweiPhone.price), huaweiNewPhone.price: \(huaweiNewPhone.price)")


