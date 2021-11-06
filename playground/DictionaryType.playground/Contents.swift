import UIKit

var greeting = "Hello, playground"


// Dictionary 字典集合类型。类似于 Java 的 map
// 键唯一，值可重复

// 创建字典
// 创建空字典
var emptyDict1: [Int : String] = [:]
var emptyDict2: Dictionary<Int, String> = Dictionary()
// 指定键值类型
var dict: [Int : String] = [0: "Zero", 1: "One", 2: "Two"]
var dict2: Dictionary<Int, String> = Dictionary(dictionaryLiteral: (1, "One"), (2, "Two"))
// 自动推断键值类型
var dictAuto = [0: "Zero", 1: "One", 2: "Two"]

// 获取元素个数
dict.count // 3

// 判断字典为空
dict.isEmpty // false

// 获取键对应的值
dict[1] // One

// 修改键对应的值
dict[0] = "000" // 000

// 如果键存在，就更新，否则就新增键值对
dict[-1] = "-1" // -1

// 更新键对应的值，如果键不存在，返回 nil
if let lastValue = dict.updateValue("new one", forKey: 1) {
    print("the last value is \(lastValue)") // the last value is One
}
    
// 移除键值对
dict.removeValue(forKey: -1) // -1

dict // [1: "new one", 2: "Two", 0: "000"]

// 移除所有键值对
//dict.removeAll()

// 对字典进行遍历

// 遍历字典的建
for ele in dict.keys {
    print(ele)
}

// 遍历字典的值
for ele in dict.values {
    print(ele)
}

// 元组遍历，直接获取键值对
for (key, val) in dict {
    print("\(key):\(val)")
}

// 对 key 进行从小到大排序后遍历，并对值进行拆包
for ele in dict.keys.sorted(by: <) {
    print(dict[ele]!)
}
