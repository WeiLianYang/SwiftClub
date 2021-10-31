import UIKit
import Foundation

var greeting = "Hello, playground"

var text:String = "Hello, playground"

// 直接赋值为空串
text = ""

// 1. 构造方法
text = String() // ""
// 字符串构造
text = String("William") // "William"
// 整型构造
text = String(888) // "888"
// 浮点型构造
text = String(8.88) // "8.88"
// 字符构造
text = String("a") // "a"
// 布尔型构造
text = String(true) // "true"
// 元组构造
text = String(describing: (5, 5.0, true)) // "(5, 5.0, true)"
// 列表构造
text = String(describing: [1, 2, 3, 4]) // "[1, 2, 3, 4]"
// 格式化字符串
text = String(format: "Hello, %@", "William") // "Hello, William"


// 2. 字符串拼接
var text1 = "hello, "
var text2 = "William"
var result = text1 + text2
print(result) // hello, William

// 3. 在字符串中插入简单值使用 \() ，类似于 Kotlin 中的 ${}
var target = "Hello, \(66)" // Hello, 66

var target2 = "Hello, \(text2)" // Hello, William

var target3 = "Hello, \(1 + 2)" // hellow, 3


// 4. 字符类型
// 字符
var char : Character = "e" // "e"
var char2 = Character("e") // "e"
// 占用16个字节
var size = MemoryLayout<Character>.size // 16
// 字符数组
var array : [Character] = ["W", "i", "l", "l", "i", "a", "m"]
// 构造String
var newStr = String(array) // William
// 遍历字符串
let city = "Shanghai"
for cha in city {
    print(cha)
}

// 5. 转义字符常用于排版
// \0：表示空白符
// \\：表示反斜杠
// \t：表示制表符
// \n：表示换行符
// \r：表示回车符
// \'：表示单引号
// \"：表示双引号
// \u{}：用Unicode码创建字符
var code = "\u{0068}\u{0065}\u{006c}\u{006c}\u{006f}" // hello
var escapeChar = "空白符:\0反斜杠:\\制表符:\t换行符\n回车符:\r单引号:\'双引号:\""
print(escapeChar)


// 6. 字符串判空
var emptyStr = ""
if emptyStr.isEmpty {
    print("string is empty")
}
if emptyStr.count == 0 {
    print("string count is 0")
}

// 字符串判大小，会逐个比较字符大小
let str1 = "100a", str2 = "101a"
if (str1 < str2) {
    print("str1 < str2")
}
// 字符串判相等，会比较所有字符的位置都相等，才为相等的字符串
if (str1 == str2) {
    print("str1 < str2")
}

// 使用下标访问字符
var indexStr = "Hello, William"
// 获取起始下标
var startIndex: String.Index = indexStr.startIndex
var endIndex: String.Index = indexStr.endIndex
// 获取某个下标后一个下标对应的字符
var afterChar = indexStr[indexStr.index(after: startIndex)] // e
// 获取某个下标前一个下标对应的字符
var beforeChar = indexStr[indexStr.index(before: endIndex)] // m

// ... 运算符指定范围，从 startIndex 向后移动4位截取子串
var subStr = indexStr[startIndex...indexStr.index(startIndex, offsetBy: 4)] // hello
// 从endIndex 向前移动7位截取子串
var subStr2 = indexStr[indexStr.index(endIndex, offsetBy: -7)..<endIndex] // William

// 获取范围
var range = indexStr.range(of: "Hello")
// 追加字符串
indexStr.append(Character("."))
indexStr.append(" append string") // Hello, William. append string

// 插入单个字符到指定位置 Hello, William.# append string
indexStr.insert("#", at: indexStr.index(startIndex, offsetBy: 15))

// 插入一组字符 Hello, William.-#-# append string
indexStr.insert(contentsOf: ["-", "#", "-"], at: indexStr.index(startIndex, offsetBy: 15))

// 替换指定范围的字符串 How are you.-#-# append string
indexStr.replaceSubrange(startIndex...indexStr.index(startIndex, offsetBy: 13), with: "How are you")

// 删除指定位置的单个字符 How are you.-#-# append strin
indexStr.remove(at: indexStr.index(before: indexStr.endIndex))

// 删除指定范围 -#-# append strin
indexStr.removeSubrange(indexStr.startIndex...indexStr.index(indexStr.startIndex, offsetBy: 11))

// 删除所有字符 ""
indexStr.removeAll()

// 转换大小写
var uppercase = "hello, swift".uppercased() // HELLO, SWIFT
var lowercase = "HELLO, SWIFT".lowercased() // hello, swift

// 检查前后缀
var hasPrefix = uppercase.hasPrefix("he") // false
var hasSuffix = lowercase.hasSuffix("ft") // true

