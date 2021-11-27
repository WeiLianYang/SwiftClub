import UIKit
import Foundation

var greeting = "Hello, playground"


// 安全特性，内存安全检查：独占访问权限。
// 当两个变量访问同一块内存时，会产生独占内存访问限制。
// 发生读写权限冲突的情况：
// 1. inout 参数读写冲突
var inputStr = "input"
func plusSlef1(_ param: inout String) {
    // 在 >= Swift4 版本会抛异常：同时访问0x103ed30a0，但是修改需要独占访问。
    param += inputStr
}
// 调用下面的代码会崩溃
// plusSlef1(&inputStr)

// 同时访问同一个内存地址，造成读写冲突
func plusSlef2(_ param1: inout String, _ param2: inout String) {
    // 在 >= Swift4 版本会抛异常：重叠访问'inputStr'，但修改需要独占访问；考虑复制到一个局部变量
    let result = param1 + param2
    print(result)
}
// 调用下面的代码会崩溃
// plusSlef2(&inputStr, &inputStr)

// 2. 结构体中函数修改成员属性读写冲突
struct StructA {
    var field: Int
    
    // mutating 修饰可修改成员属性，inout 开放写访问，会产生读写冲突
    mutating func edit(_ param: inout StructA) {
        field = param.field
    }
}

var structA = StructA(field: 100)
// 调用下面的代码会产生编译错误：
// 1. Inout参数不允许彼此别名
// 2. 重叠访问'structA'，但修改需要独占访问;考虑复制到一个局部变量
// structA.edit(&structA)


// 3. 值类型属性读写冲突
class ClassA {
    // 定义元组，属于值类型
    var tuple = (key1: 1, key2 : 2)
    
    func test1(_ param1: inout Int, _ param2: inout Int) {
        print(param1, param2)
    }
    
    func test2() {
        // 如果被调用会崩溃，同时访问0x600000667cd0，但是修改需要独占访问。
        test1(&tuple.key1, &tuple.key2)
    }
    
    func test3() {
        // 访问 局部 值变量 可以正常使用
        var localTuple = (key1: 3, key2 : 4)
        test1(&localTuple.key1, &localTuple.key2)
    }
}

let cla = ClassA()
// 调用下面的代码会崩溃
// cla.test2()
cla.test3() // 正常调用，打印 3 4


// 多行字符串，同 kotlin 的原始字符串，不需要手动添加换行符。可用于排版
var text1 = """
start
\(1)
2
end
"""
print(text1)


// 转义符
var text2 = "对单引号进行转义\'"
print(text2) // 对单引号进行转义'

// 使用界定符代替转义符
var text3 = #"对单引号进行转义'"#
print(text3) // 对单引号进行转义'

// 使用界定符时，转义符失去作用
var text4 = #"换行符1 \n 换行符2"#
print(text4) // 换行符1 \n 换行符2

// 使用界定符时，使用 \# 保留转义符的作用
var text5 = #"换行符1 \#n 换行符2"#
print(text5) // 会换行打印: 换行符1 换行符2


// 动态成员查找
@dynamicMemberLookup // 使用 @dynamicMemberLookup 为类增加动态查找成员的能力
@dynamicCallable // 使用 @dynamicCallable 为类增加动态方法调用的能力
class Data {
    var field1: Int = 0
    var field2: String = ""
    
    subscript(dynamicMember member: Int) -> String {
        return "class don't have the field: \(member), type int"
    }
    
    subscript(dynamicMember member: String) -> String {
        return "class don't have the field: \(member), type String"
    }
    
    // 传入一组参数
    func dynamicallyCall(withArguments argArray: [Int]) {
        print("invoke unknown func with args: \(argArray)")
    }
    
    // 传入键值对参数
    func dynamicallyCall(withKeywordArguments pairs: KeyValuePairs<String, Int>) {
        let argPairs = pairs.map{ key, value in
            return "\(key): \(value)"
        }
        print(argPairs)
    }
}

let data = Data()
// 当访问不存在的属性时，就会调用对应的 subscript 方法返回对应类型的值
// class don't have the field: someInt, type String. class don't have the field: someString, type String
print(data.someInt, data.someString)


// 调用不存在的方法，把实例当做方法调用
// 传入一组参数
data(1, 2, 3) // invoke unknown func with args: [1, 2, 3]
// 传入键值对参数
data(key1: 1, key2: 2) // ["key1: 1", "key2: 2"]


// 使用多个协议界定参数
protocol ProtocolA {
    var field: String {get set}
}
protocol ProtocolB {
    func method()
}
// 实现多个协议
class ClassImpl : ProtocolA, ProtocolB {
    var field: String = "impl field"
    
    func method() {
        print("impl method")
    }
}
// 使用 & 界定多个协议
func testImpl(impl: ProtocolA & ProtocolB) {
    print(impl.field)
    impl.method()
}

testImpl(impl: ClassImpl())

