import UIKit

var greeting = "Hello, playground"


// 整型
var intType: Int = 11
print(intType)

// 浮点型
var floatType: Float = 3.14e3 // 10进制中，e表示10的n次方，3.14 * (10^3) = 3140.0
print(floatType)
    
var floatType2: Float = 0x2p3 // 16进制中，p表示2的n次方，2 * (2^3) = 16.0
print(floatType2)

// 布尔型
var boolType = true // or false
print(boolType)

// 元组
var person: (name: String, age: Int) = ("William", 18)
print("name:", person.name, ", age:", person.age)

// 元组不指定参数名称
var city: (String, Int) = ("Shanghai", 200000)
// 使用下标访问
print(city.0, city.1)

// 分解元组
var (name, code) = city
print(name, code)

// 单个 Optional 绑定，if-let 结构
var obj: String? = "Wuhan"
if let temp = obj {
    // 当 obj 不为 nil 时，将 obj 赋值给 temp
    print("hello", temp)
} else {
    // 否则重新为 obj 赋值
    obj = "hello, if-let"
    print(obj)
}

// 多个 Optional 绑定
var obj1:Int? = 1
var obj2:Int? = 2
if let temp1 = obj1, let temp2 = obj2, temp1 < temp2 {
    // 当全部不为 nil 且满足子句 temp1 < temp2
    print(temp1, temp2)
} else {
    print("obj1 or obj2 may be nil")
}

// Optional，可空，需要拆包
var obj4:Int?
obj4 = 3
// 编译异常，没有进行拆包
// print(obj4 + 1)
// 以下会自动拆包
var obj5:Int! // or Int
obj5 = 3
print(obj5 + 2)

// 类型别名，灵活使用可以优化代码的可读性
typealias Weight = String
var weight:Weight = "50kg"
print(weight)


// 自动推断类型
var a = 10, b:Int = 20, c = "hello swift"
print(a, b , c)

// 在数值前可加 0 进行位数填充，可加入下划线，增加可读性
var number1 = 001.234 // 1.234
var number2 = 1_234 // 1234
// 打印多个值使用逗号分隔
print(number1, number2) // 1.234 1234

// 二进制
var type_2 = 0b01
// 八进制
var type_8 = 0o02
// 十进制
var type_10 = 3
// 十六进制
var type_16 = 0x04
print(type_2, type_8 , type_10, type_16)
