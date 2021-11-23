import UIKit

var greeting = "Hello, playground"


// 1. 引用类型的内存销毁时机
class ClassDemo {
    var a = "value a"
    deinit {
        // 实例被释放
        print("deinit class a")
    }
}

// 可空类型
var ins1: ClassDemo? = ClassDemo()
var ins2 = ins1
var ins3 = ins2

ins1 = nil // 取消 ins1 引用
ins2 = nil // 取消 ins2 引用
print(String(describing: ins3?.a)) // 此处 ins3 引用的实例依然在，Optional("value a")

// 对实例引用被全部取消，ClassA 实例此处才销毁
ins3 = nil // deinit class a


// 2. 单向引用
class ClassA {
    
    deinit {
        print("deinit ClassA")
    }
    
    func foo() {
        print("func foo in ClassA")
    }
}

class ClassB {
    // 此处引用 ClassA 的实例
    var ins: ClassA?
    
    init(ins: ClassA?) {
        self.ins = ins
    }
    
    deinit {
        print("deinit ClassB")
    }
}

var clzA: ClassA? = ClassA()
var clzB: ClassB? = ClassB(ins: clzA)

// 此处 clzA 所引用的内存并未释放
clzA = nil
// 依然可以调用 clzB 中的 clzA 实例的 foo 方法
clzB?.ins?.foo() // func foo in ClassA
// 此时 ClassB 实例被释放，不再有引用指向 ClassA 随即所占内存也被释放
clzB = nil // deinit ClassB \n deinit ClassA


// 3. 循环引用
class ClassC {
    var insD: ClassD?
    
    deinit {
        print("deinit ClassC")
    }
    
    func foo() {
        print("func foo in ClassC")
    }
}

class ClassD {
    // 此处引用 ClassC 的实例
    var insC: ClassC?
    
    init(ins: ClassC?) {
        self.insC = ins
    }
    
    deinit {
        print("deinit ClassD")
    }
}

var clzC: ClassC? = ClassC()
var clzD: ClassD? = ClassD(ins: clzC)

clzC?.insD = clzD

// 此处 clzC 所引用的内存并未释放，对应实例被 clzD 的 insC 引用
clzC = nil
// 依然可以调用 clzD 中的 insC 实例的 foo 方法
clzD?.insC?.foo() // func foo in ClassC
// 此时 clzD 的实例依然被 clzC 的 insD 引用，clzC 和 clzD 实例都未被释放
clzD = nil


// 4. 使用弱引用解决循环引用问题
class ClassE {
    // 弱引用 weak
    weak var insF: ClassF?
    
    deinit {
        print("deinit ClassE")
    }
    
    func foo() {
        print("func foo in ClassE")
    }
}

class ClassF {
    // 此处引用 ClassE 的实例
    var insE: ClassE?
    
    init(ins: ClassE?) {
        self.insE = ins
    }
    
    deinit {
        print("deinit ClassF")
    }
}

var clzE: ClassE? = ClassE()
var clzF: ClassF? = ClassF(ins: clzE)

clzE?.insF = clzF

// 此处 clzE 所引用的内存并未释放，对应实例被 clzF 的 insE 引用
clzE = nil
// 依然可以调用 clzF 中的 insE 实例的 foo 方法
clzF?.insE?.foo() // func foo in ClassE
// 此时 clzF 的实例被 clzE 的 insF 弱引用，会被销毁，clzE 和 clzF 实例都能被释放
clzF = nil // deinit ClassF \n deinit ClassE


// 5. 无主引用，针对类型为非 Optional
class ClassG {
    // 无主引用 unowned 假定属性不为 nil
    unowned var insH: ClassH
    
    init(ins: ClassH) {
        self.insH = ins
    }
    func foo() {
        print("func foo in ClassG")
    }
    deinit {
        print("deinit ClassG")
    }
}

class ClassH {
    // 此处引用 ClassE 的实例
    var insG: ClassG?
    
    deinit {
        print("deinit ClassH")
    }

}
var clzH: ClassH? = ClassH()
var clzG: ClassG? = ClassG(ins: clzH!)


clzH?.insG = clzG

// 此处 clzG 所引用的内存并未释放，对应实例被 clzH 的 insG 引用
clzG = nil
// 依然可以调用 clzH 中的 insG 实例的 foo 方法
clzH?.insG?.foo() // func foo in ClassG
// 此时 clzH 的实例被 clzG 的 insH 无主引用，会被销毁，clzG 和 clzH 实例都能被释放
clzH = nil // deinit ClassH \n deinit ClassG


// 6. 闭包产生的循环引用
class ClassJ {
    var field = "field j"
    
    lazy var closure: () -> Void = {
        print(self.field)
    }
    
    deinit {
        print("deinit ClassJ")
    }
}

var objJ: ClassJ? = ClassJ()
objJ?.closure()
// 因为闭包引用了类的成员属性，导致实例无法释放，进而导致闭包无法释放，产生循环引用
objJ = nil // 此处并没有打印 deinit 中信息

// 解决闭包产生的循环引用
class ClassK {
    var field = "field k"
    
    lazy var closure: () -> Void = {
        // 使用捕获列表对 self 进行无主引用的转换
        [unowned self] () -> Void in
        print(self.field)
    }
    
    deinit {
        print("deinit ClassK")
    }
}

var objK: ClassK? = ClassK()
objK?.closure()
objK = nil // deinit ClassK


// 自定义异常类型
enum CustomError: Error {
    case ErrorOne
    case ErrorTwo
    case ErrorThree
}

print("error")
//throw CustomError.ErrorOne // 抛出的异常未捕获会终止，不会打印 complete
print("complete")

// 通过函数抛出异常
func funcError() throws -> String {
    throw CustomError.ErrorTwo
}

// 使用 do-catch 捕获异常
do {
    // 使用 try 执行可能会抛出异常的函数
    try funcError()
} catch CustomError.ErrorOne {
    print("ErrorOne")
} catch CustomError.ErrorTwo {
    print("ErrorTwo")
} catch CustomError.ErrorThree {
    print("ErrorThree")
}

// 使用 try? 将函数执行的结果映射为 Optional 类型
let result = try? funcError()
if (result == nil) {
    print("exec failed")
}

// try! 强行终止异常的传递，如果发生异常，则程序中断
// try! funcError()


// 函数延时执行：避免在抛异常的时候，保证某些必须的代码块要执行，如释放资源
func lazyFunc() throws -> Void {
    defer {
        // 函数结束时会得到执行
        print("lazy part of func")
    }
    
    print("exec lazyFunc")
    throw CustomError.ErrorThree
}

// exec lazyFunc
// lazy part of func
try? lazyFunc()

