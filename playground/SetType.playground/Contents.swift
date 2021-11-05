import UIKit

var greeting = "Hello, playground"

// 集合类型：集合 Set
// 不关注顺序，但不可以重复

// 创建Set
var set: Set<Int> = [1, 2, 3]
var set2 = Set(arrayLiteral: 1, 2, 3)

// set 获取最大值
set.max()

// set 获取最小值
set.min()

// 获取第一个元素，顺序不定
set[set.startIndex]
set.first

// 通过下标获取元素，只能向后移动，不能向前
// 获取第二个元素
set[set.index(after: set.startIndex)]
// 获取某个下标后几个元素
set[set.index(set.startIndex, offsetBy: 2)]

// 获取元素个数
set.count

// 判断空集合
if set.isEmpty {
   print("set is empty")
}

// 判断集合是否包含某个元素
if (set.contains(3)) {
    print("set contains 3")
}

// 插入
set.insert(0)

// 移除
set.remove(2)
set.removeFirst()
// 移除指定位置的元素，需要用 ! 拆包，拿到的是 Optional 类型，如果移除不存在的元素，EXC_BAD_INSTRUCTION
set.remove(at: set.firstIndex(of: 1)!)

set.removeAll()


var setStr1: Set<String> = ["1", "2", "3", "4"]
var setStr2: Set<String> = ["1", "2", "5", "6"]

// Set 取交集
setStr1.intersection(setStr2) // {"2", "1"}

// Set 取交集的补集
setStr1.symmetricDifference(setStr2) // {"4", "5", "3", "6"}

// Set 取并集
setStr1.union(setStr2) // {"2", "3", "1", "4", "6", "5"}

// Set 取相对补集（差集），A.subtract(B)，即取元素属于 A，但不属于 B 的元素集合
setStr1.subtract(setStr2) // {"3", "4"}

var eqSet1: Set<Int> = [1, 2, 3]
var eqSet2: Set<Int> = [3, 1, 2]
// 判断 Set 集合相等
if eqSet1 == eqSet2 {
    print("集合中所有元素相等时，两个集合才相等，与元素的顺序无关")
}

let set3: Set = [0, 1]
let set4: Set = [0, 1, 2]
// 判断子集
set3.isSubset(of: set4) // set3 是 set4 的子集，true
set3.isStrictSubset(of: set4) // set3 是 set4 的真子集，true
// 判断超集
set4.isSuperset(of: set3) // set4 是 set3 的超集，true
set4.isStrictSuperset(of: set3) // set4 是 set3 的真超集，true

// 遍历元素
for ele in set4 {
    print(ele)
}

// 遍历集合的枚举
for ele in set4.enumerated() {
    print(ele)
}

// 下标遍历
for index in set4.indices {
    print(set4[index])
}

// 从小到大排序后再遍历
for ele in set4.sorted(by: <) {
    print(ele)
}

