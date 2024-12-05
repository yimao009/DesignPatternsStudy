//
//  main.swift
//  03_装饰模式
//
//  Created by GRZ on 2024/12/5.
//

import Foundation

print("Hello, World!")

class Person {
    
    private let name: String
    init(name: String) {
        self.name = name
    }
    
    func wearTShirts() {
        print("大T恤")
    }
    
    
    func wearBigTrouser() {
        print("垮裤")
    }
    
    func wearSneakers() {
        print("破球鞋")
    }
    
    func wearSuit() {
        print("西装")
    }
    
    func wearTie() {
        print("领带")
    }
    
    func wearLeatherShoes() {
        print("皮鞋")
    }
    
    func show() {
        print("装扮的\(name)")
    }
}

let xc = Person(name: "小菜")
//print("第一种装扮：")

//xc.wearTShirts()
//xc.wearBigTrouser()
//xc.wearSneakers()
//xc.show()

//print("\n第二种装扮：")

//xc.wearSuit()
//xc.wearTie()
//xc.wearLeatherShoes()
//xc.show()

//MARK: 第二版
class Person2 {
    
    private let name: String
    init(name: String) {
        self.name = name
    }
}

protocol Finery {
    func show()
}

class TShirts: Finery {
    func show() {
        print("大T恤")
    }
}

class BigTrouser: Finery {
    func show() {
        print("垮裤")
    }
}

class Sneakers: Finery {
    func show() {
        print("破球鞋")
    }
}

class Suit: Finery {
    func show() {
        print("西装")
    }
}

class Tie: Finery {
    func show() {
        print("领带")
    }
}

class LeatherShoes: Finery {
    func show() {
        print("皮鞋")
    }
}

//let p2 = Person2(name: "小菜")
//
//
//let dtx = TShirts()
//let kk = BigTrouser()
//let pqx = Sneakers()
//
//print("第一种装扮：")
//dtx.show()
//kk.show()
//pqx.show()
//xc.show()
//
//print("\n第二种装扮：")
//let xz = Suit()
//let ld = Tie()
//let px = LeatherShoes()
//
//xz.show()
//ld.show()
//px.show()
//xc.show()

//MARK: 装饰模式 Decorator
// 核心组件协议 对象接口
protocol PersonComponent {
    func show()
}

// 具体的组件对象
class Person3: PersonComponent {
    
    private let name: String
    init(name: String) {
        self.name = name
    }
    
    func show() {
        print("装扮的 \(name)")
    }
}

//  装饰器基类
class FineryDecorator: PersonComponent {
    private let component: PersonComponent
    
    init(component: PersonComponent) {
        self.component = component
    }

    func show() {
        component.show()
    }
}

class TShirts1: FineryDecorator {
    
    override func show() {
        print("大T恤")
        super.show()
    }
}

class BigTrouser1: FineryDecorator {
    override func show() {
        print("垮裤")
        super.show()
    }
}


class Sneakers1: FineryDecorator {
    override func show() {
        print("破球鞋")
        super.show()
    }
}

class Suit1: FineryDecorator {
    override func show() {
        print("西装")
        super.show()
    }
}

class Tie1: FineryDecorator {
    override func show() {
        print("领带")
        super.show()
    }
}

class LeatherShoes1: FineryDecorator {
    override func show() {
        print("皮鞋")
        super.show()
    }
}

let person3 = Person3(name: "小明")

let dtx = TShirts1(component: person3)
let kk = BigTrouser1(component: dtx)
let pqx = Sneakers1(component: kk)

print("第一种装扮：")
pqx.show()

print("\n第二种装扮：")
let xz = Suit1(component: person3)
let ld = Tie1(component: xz)
let px = LeatherShoes1(component: ld)
px.show()



//MARK: 属性学习
struct FixedLengthRange {
    var firstValue: Int
    let lenght: Int
}

var fixedInstance = FixedLengthRange(firstValue: 0, lenght: 4)
fixedInstance.firstValue = 2

let fixedInstance1 = FixedLengthRange(firstValue: 0, lenght: 4)
//fixedInstance1.firstValue = 3
// 因为结构体是值类型， 当值类型的变量赋值给常量类型 let， 就算成员变量是var类型如firstValue，也不能更改，其所有属性也都被标记为常量
// 当用class 类就不一样，即使赋值给let常量， 也可以修改，因为其事引用类型

//class FixedLengthRange1 {
//    var firstValue: Int
//    let lenght: Int
//}

// Stored Properties 存储属性
// Lazy Stored  懒存储属性 首次使用前不计算出是值的属性， 可以在声明前写入lazy修饰符来表示懒存储属性
 // 这个属性必须用var声明，因为这个值有可能要等到实例初始化完成后才能取回，常量属性在初始化完成前必须始终有一个值，所以不能声明为懒惰属性
// 1. 依赖外部初始化 2. 复杂计算或者好使操作 3. 注意多线程， 多线程访问lazy的属性，不能保证初始化一次

// swift属性和oc属性 区别， swift中没有成员变量，都统一到一个声明中，没有对应的成员变量，也就是带下划线的变量。

// Computed Properties 计算属性 类 结构体 枚举都提供
// 实际上不存储值，提供getter和setter 用于间接检索和设置其他属性和值

//Read-Only Computed Properties 只读计算属性

