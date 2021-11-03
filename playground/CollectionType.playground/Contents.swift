import UIKit

var greeting = "Hello, playground"


// 集合类型：数组 Array, 集合 Set, 字典 Dictionary

// 创建整型数组
var array1: [Int] = [] // []
var arrya2: Array<Int> = [1, 2, 3] // [1, 2, 3]
var arryaInt = [1, 2, 3] // [1, 2, 3]
var array3 = Array(arrayLiteral: 1, 2, 3) // [1, 2, 3]

// 快捷创建重复元素的数组
var array4 = Array(repeating: "swift", count: 3) // ["swift", "swift", "swift"]
var array5 = Array(repeating: 1001, count: 3) // [1001, 1001, 1001]

// 2个相同类型的数组相加
var array6 = [1, 2, 3] + [4, 5, 6] // [1, 2, 3, 4, 5, 6]

// 数组的相关操作
// 当数组声明为可变时，才能使用增，删，改等方法，常量数组不能进行修改相关操作
var array = [1, 2, 3, 4, 5, 6, 7, 8]
print(array.count) // 8

if array.isEmpty {
    print("array is empty")
} else {
    print("array is not empty")
}

// 通过下标访问元素
var ele = array[1] // 2

// 截取新数组
var subArray = array[1...2] // [2, 3]

// 获取第一个元素
var firstEle = array.first // 1

// 获取最后一个元素
var lastEle = array.last // 8

// 修改下标对应的元素
array[1] = 22
array // [1, 22, 3, 4, 5, 6, 7, 8]

// 修改指定范围的元素
array[0...2] = [1, 2, 3] // [1, 2, 3]
 
// 追加单个元素
array.append(9) // [1, 2, 3, 4, 5, 6, 7, 8, 9]

// 追加一组元素
array.append(contentsOf: [10, 11, 12]) // [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

// 在指定位置插入单个元素
array.insert(0, at: 0) // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

// 在指定位置插入一组元素
array.insert(contentsOf: [-3, -2, -1], at: 0) // [-3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

// 移除指定元素
array.remove(at: 1) // -2

// 移除一组元素
array.removeSubrange(0...2) // [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

// 移除首个元素
array.removeFirst() // 1

// 移除末尾元素
array.removeLast() // 12

// 移除前几个元素
array.removeFirst(3) // [5, 6, 7, 8, 9, 10, 11]

// 移除后几个元素
array.removeLast(3) // [5, 6, 7, 8]

// 替换指定范围的元素
array.replaceSubrange(0...3, with: [1, 2, 3, 4]) // [1, 2, 3, 4]

// 判断包含指定元素
if array.contains(3) {
    print("array contains 3")
}

// 移除所有元素
array.removeAll() // []


