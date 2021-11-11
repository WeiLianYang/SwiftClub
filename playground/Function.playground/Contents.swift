import UIKit
import CoreFoundation

var greeting = "Hello, playground"


// 创建函数，无参，无返回值，同 func func1() -> Void
func func1() {
    print("no params func")
}

func1()

// 创建函数，带参，带返回类型
func func2(param: Int) -> Bool {
    return param > 60
}

func2(param: 80)

// 创建函数，带多个参数，返回类型为元组
func func3(param1: String, param2: Int) -> (result1: String, result2: Int) {
    return (param1 + "11", param2 + 20)
}

let tuple = func3(param1: "param", param2: 60)
if tuple.result1.starts(with: "param") {
    print(tuple.result2)
}

// 创建函数，带参，返回类型为 Optional
func func4(param: Int) -> Int? {
    guard param > 2 else {
        return nil
    }
    return param + 2
}

if let result = func4(param: 3) {
    print(result)
}


// 函数内外参数命名
// 函数参数指定外部名称
func outerNameFunc(name1 param1: Int, name2 param2: Int, param3: Int) {
    print(param1, param2, param3)
}
// 函数参数使用外部名称
outerNameFunc(name1: 1, name2: 2, param3: 3)

func normalFunc(param1: Int, param2: Int, param3: Int) {
    print(param1, param2, param3)
}
// 默认函数参数的内部名称和外部名称一致，调用函数时需要指定参数名称
normalFunc(param1: 1, param2: 2, param3: 3)

// 调用函数时省略参数名称
func annoFunc(_ param1: Int, _ param2: Int, _ param3: Int) {
    print(param1, param2, param3)
}
annoFunc(1, 2, 3)


// 函数参数指定默认值
func func5(param1: Int, param2: Int = 2, param3: Int = 3) {
    print(param1, param2, param3)
}
// 调用时，可以只传入没有默认值的参数
func5(param1: 1)
// 调用时，参数位置要严格对应
func5(param1: 1, param2: 22)


// 函数参数指定默认值
func func6(param1: Int, param2: Int = 2, param3: Int) {
    print(param1, param2, param3)
}
// 调用时，参数位置要严格对应
func6(param1: 1, param3: 33)


// 函数传入多个可变数量的参数，类似于 Kotlin 的 vararg
func mutableParamFunc(param: Int...) {
    var sum = 0
    for ele in param {
        sum += ele
    }
    print(sum)
}
mutableParamFunc(param: 1, 2)
mutableParamFunc(param: 1, 2, 3, 4)

// swift 的函数参数值（除引用类型外）默认是不可修改的
func immutableParam(param: Int) {
//    param += 1 // 编译失败 error: left side of mutating operator isn't mutable: 'param' is a 'let' constant
}

// 为了可以在函数参数内部修改参数值，可以使用 inout 修饰参数
func immutableParam(param:inout Int) {
    param += 1 // 编译通过
    print(param) // 2
}
// 调用时需要使用 & 符号
var number = 1
immutableParam(param: &number)
print(number) // 2, number的值也被修改了



// 函数可以作为类型进行声明，就像使用其他类型一样
let func7Name: (Int, Int) -> Bool
// 将闭包赋值给函数变量
func7Name = {(param1: Int, param2: Int) in
    return param1 > param2
}
// 调用函数变量
func7Name(1, 2) // false

// 函数作为参数传入
func func8(funParam: (Int, Int) -> Bool) {
    print(funParam(2, 1)) // true
}
// 将 func7 传入 func8
func8(funParam: func7Name)

// 函数作为返回值类型
func func9() -> (Int, Int) -> Bool {
    return func7Name // 将 func7Name 返回
}

// 函数嵌套
func outerFunc() {
    let outerScope = "outer scope"
    func innerFunc() {
        print(outerScope, "in inner func")
    }
    // 在外部函数内调用内部嵌套函数，在外部函数以外无法调用它
    innerFunc()
}
// 调用外部函数
outerFunc()




// 定义闭包，类似于 Kotlin 的 lambda 表达式。
// 闭包一般是为了处理回调，传递功能代码块
// 闭包标准语法结构：{(param list) -> valueType in block}
let closureFunc1 = {(param1: Int, param2: Int) -> Int in
    return param1 + param2
}

// 调用闭包
closureFunc1(1, 2) // 3

// 闭包可省略返回值
let closureFunc2 = {(param1: Int, param2: Int) in
    return param1 + param2
}
closureFunc2(1, 3) // 4


// 如果闭包只有一行代码，可以省略 return
let closureFunc3 = {(param1: Int, param2: Int) in
    return param1 < param2
}
closureFunc3(1, 2) // true


// 入参为闭包
func func10(closureParam: (Int, Int) -> Bool) {
   closureParam(2, 1)
}
// 使用默认参数名
func10(closureParam: { $0 > $1 }) // true

// 后置闭包，当最后一个参数为闭包时，简化写法：
func10() {
    $0 > $1
}

// 非逃逸闭包：函数的生命周期结束后，闭包也将被销毁
// 定义的闭包默认都是非逃逸的


// 逃逸闭包：函数的执行结束后，闭包在函数外仍可使用
// 定义逃逸闭包使用 @escaping ，一般用于异步回调
func func11(closureParam: @escaping (Int, Int) -> Bool) {
   
}

// 定义自动闭包使用 @autoclosure，对简单闭包的自动生成。
// 自动闭包默认非逃逸。自动闭包不能够有参数，单表达式
func autoCloseFunc(closureParam: @autoclosure () -> Int) {
    print(closureParam()) // 6
}
autoCloseFunc(closureParam: 1 + 2 + 3)

