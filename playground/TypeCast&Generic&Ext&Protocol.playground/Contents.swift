import UIKit

var greeting = "Hello, playground"


// Swift 判断值类型
var anyObj: Any = 1
if anyObj is Int {
    print("anyObj's type is Int")
} else if anyObj is String {
    print("anyObj's type is String")
}

// Swift 判断引用类型
class Base {
    var text = "base text"
}
class Sub1: Base {
    var subText1 = "sub1 text"
}
class Sub2: Base {
    var subText2 = "sub2 text"
    func subFunc() {
        print("sub func invoke")
    }
}

// Swift 判断类型并转换调用对应属性
var obj = Base()
var subObj1 = Sub1()
var subObj2 = Sub2()

// Swift 数组中类型为 Base 的都可以存入
var arrayObj: [Base] = [obj, subObj1, subObj2]

for index in 0..<arrayObj.count {
    let obj = arrayObj[index]
    if obj is Sub1 {
        // 如果是 Sub1 就转换为 Sub1 类型，向下转型
        let subObj = obj as! Sub1
        print(subObj.subText1)
    } else if obj is Sub2 {
        let subObj = obj as! Sub2
        print(subObj.subText2)
    } else {
        print(obj.text)
    }
}

// Swift 使用 AnyObject 类型声明数组，其中可以存放任何引用类型，不可以存放值类型
var arrayAnyObj: [AnyObject] = [obj, subObj1, subObj2]

// Swift 使用 Any 类型声明数组，其中可以存放任何类型，包含 值类型 和 引用类型
var arrayAny: [Any] = [1, "2", true, obj, (0, 0), {(param: Int) -> Int in return param}]


// Swift 使用泛型定义方法，打印自身
func printSelf<T>(_ param: T) {
    print(param)
}
printSelf("text")
printSelf(1000)

// Swift 使用泛型定义结构体，实现简单集合
struct List<T> {
    private var datas: [T] = []
    
    mutating func add(_ newEle: T) {
        datas.append(newEle)
    }
    
    mutating func get(_ index: Int) -> T {
        return datas[index]
    }
}

// Swift 使用扩展，给结构体添加一个扩展方法
extension List {
    func getDatas() -> [T] {
        return datas
    }
}

// 定义整型的集合
var list = List<Int>()
// 添加元素
list.add(1)
list.add(2)
list.add(3)
// 读取元素
var ele = list.get(1)
print(ele) // 2

// 调用扩展方法
var datas = list.getDatas()
print(datas) // [1, 2, 3]


// Swift 添加泛型约束
// 定义一个存放 Base 子类的结构体
struct ObjList<T: Base> {
    private var datas: [T] = []
    
    mutating func add(_ newEle: T) {
        datas.append(newEle)
    }
    
    mutating func get(_ index: Int) -> T {
        return datas[index]
    }
}
var objList = ObjList<Sub1>()
objList.add(subObj1)



// Swift 定义协议 protocol，类似于 java, kotlin 中定义接口
protocol BaseProtocol {
    // 实现协议时才指定类型
    associatedtype T
    // 定义普通方法
    func printType(input: T) -> Void
    
    // 定义计算属性
    var field1: T {get}
    var field2: String {get set}
    
    // 定义静态方法
    static func method()
    
}

// 协议继承，自动继承 BaseProtocol 中的属性和方法
protocol SubProtocol: BaseProtocol {
}
// claProtocol 只能被类遵守
protocol claProtocol: AnyObject {
}

class ClassImpl: BaseProtocol {
    func printType(input: String) {
        print(input)
    }
    // 实现计算属性
    var field1: String {
        get {return "field1"}
        set {}
    }
    var field2: String {
        get {return "field2"}
        set {}
    }
    // 实现静态方法
    static func method() {}
}

// 为类扩展属性和方法
extension ClassImpl {
    var extField: Int {
        get {
            return 100
        }
    }
    
    func extFunc() {
        print("ext func")
    }
}

var implCla = ClassImpl()

implCla.printType(input: "input text")
print(implCla.extField)
implCla.extFunc()



// 定义可选实现
@objc protocol OptionalProtocol: AnyObject {
    @objc optional func method();
}

extension OptionalProtocol {
    func method() {
        print("default method extension")
    }
}

class ClassOptPro: OptionalProtocol {
    func method() {
        print("default method ClassOptPro")
    }
}

var claOptIns = ClassOptPro()
claOptIns.method()



// 定义多个泛型约束
class MultipleType<T, R> where T: BaseProtocol, R: SubProtocol {
}


