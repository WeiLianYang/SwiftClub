import UIKit

var greeting = "Hello, playground"

// 元组比较大小。需要元素个数一致，对应的位置的元素类型相同，每一个元素都必须支持比较运算操作。
// 从第一个元素开始比较，如果没有比较出结果，那么继续依次比较，直到比出结果为止。
var a = (1, 2, "3")
var b = (1, 2, "4")

var c = a < b // true

// 条件判断
if a > b {
    print("a > b")
} else {
    print("a < b")
}

// 三目运算，同 java
print(a > b ? "a > b" : "a < b") // a < b

var str: String? = "text"
var result: String = str != nil ? str! : ""

// 空合并运算符，如果 str 为 nil，则赋值空串，同 kotlin 的 Elvis 运算符 ?:
result = str ?? ""

// 区间运算符，[1, 5]，范围是 >=1, <=5，类似于 Kotlin 的区间 1..5
var rang1 = 1...5

// 区间运算符，[1, 5)，范围是 >=1, <5
var rang2 = 1..<5

// 判断是否在某个区间范围内
print(rang1 ~= 2) // true

// if-else
let number = 18
if number < 15 {
    print("number < 15")
} else if number >= 16 && number <= 20 {
    print("number >= 16 && number <= 20")
} else {
    print("number > 20")
}

// 区间运算符用于循环
for index in rang1 {
    print(index)
}

// 中断循环 break
for index in 0...2 {
    if index == 1 {
        break
    }
    print(index) // 0
}

// 跳过循环 continue
for index in 0...2 {
    if index == 1 {
        continue
    }
    print(index) // 0 2
}

// 中断外层循环 break，类似于 Kotlin 的限定符
OutterLabel:for outterIndex in 0...2 {
    for index in 0...1 {
        if outterIndex == 1 {
            break OutterLabel
        }
        print(index) // 0 1
    }
}

// while 循环
var i = 0
while i < 3 {
    print(i) // 0, 1, 2
    i += 1
}

// 即 do-while，先执行一次循环，再判断条件
var k = 0
repeat {
    print(k) // 0, 1, 2
    k += 1
} while k < 3


// 流程控制 switch-case
var caseStr = "a"
switch caseStr {
case "a":
    print("value is a")
case "b":
    print("value is b")
default:
    print("default value")
}

// switch 子句多条件匹配
switch caseStr {
case "a","b","c":
    print("match success")
default:
    print("default value")
}

// switch 子句区间范围匹配
let age = 18
switch age {
case 16..<18:
    print("match age 16...18")
case 18...20:
    print("match age 18..<20")
default:
    print("default value")
}

// switch 元组匹配
let intTuple = (1, 2)
switch intTuple {
case (1, 2):
    print("match success 1, 2")
    fallthrough // 继续执行后续 case 匹配，不跳出 switch
case (2, 2):
    print("match success 2, 2")
    fallthrough
case (_, 2):
    // 选择性匹配，第一个匿名不关注，只有第二个能匹配，就算匹配成功
    print("match success _,2")
    fallthrough
case (0...2, 0...2):
    // 匹配元组元素的范围
    print("match range success")
case (let a, 1):
    print("捕获元素: \(a)")
case let(a, b) where a < b:
    // 同 (let a, let b)，增加 where 字句判断
    print("捕获元组: \(a),\(b)")
    fallthrough
default:
    print("default")
}

method()

func method() {
    // 守护语句，当 guard 后面的条件成立时，才继续执行，替换之前if-return
    guard number > 20 else {
        return
    }
    print("continue execute")
}
