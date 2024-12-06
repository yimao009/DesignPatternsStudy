//
//  main.swift
//  04_代理模式
//
//  Created by GRZ on 2024/12/6.
//

import Foundation

print("Hello, World!")

//MARK: 没有代理的代码
// 追求者
class Pursuit {
    let mm: SchoolGirl
    init(mm: SchoolGirl) {
        self.mm = mm
    }
    
    func giveDolls() {
        print("\(mm.name) 送你洋娃娃")
    }
    
    func giveFlowers() {
        print("\(mm.name) 送你鲜花")
    }
    
    func giveChocolate() {
        print("\(mm.name) 送你巧克力")
    }
}

// 被追求者
class SchoolGirl {
    let name: String
    init(name: String) {
        self.name = name
    }
}

//let jiaojiao = SchoolGirl(name: "李娇娇")
//
//let zhuojiayi = Pursuit(mm: jiaojiao)
//
//zhuojiayi.giveChocolate()
//zhuojiayi.giveFlowers()
//zhuojiayi.giveDolls()

//MARK: 只有代理的代码

class Proxy {
    let mm: SchoolGirl1
    init(mm: SchoolGirl1) {
        self.mm = mm
    }
    
    func giveDolls() {
        print("\(mm.name) 送你洋娃娃")
    }
    
    func giveFlowers() {
        print("\(mm.name) 送你鲜花")
    }
    
    func giveChocolate() {
        print("\(mm.name) 送你巧克力")
    }
}

// 被追求者
class SchoolGirl1 {
    let name: String
    init(name: String) {
        self.name = name
    }
}

//let jiaojiao1 = SchoolGirl1(name: "李娇娇")
//
//let proxy = Proxy(mm: jiaojiao1)
//
//proxy.giveChocolate()
//proxy.giveFlowers()
//proxy.giveDolls()

//MARK: 代理模式

protocol GiveGiftProtocol {
    func giveChocolate()
    func giveFlowers()
    func giveDolls()
}

class Pursuit1: GiveGiftProtocol {
    let mm: SchoolGirl1
    init(mm: SchoolGirl1) {
        self.mm = mm
    }
    
    func giveDolls() {
        print("\(mm.name) 送你洋娃娃")
    }
    
    func giveFlowers() {
        print("\(mm.name) 送你鲜花")
    }
    
    func giveChocolate() {
        print("\(mm.name) 送你巧克力")
    }
}

class Proxy1: GiveGiftProtocol {
    let pursuit: Pursuit1
    init(mm: SchoolGirl1) {
        pursuit = Pursuit1(mm: mm)
    }
    
    func giveDolls() {
        pursuit.giveDolls()
    }
    
    func giveFlowers() {
        pursuit.giveFlowers()
    }
    
    func giveChocolate() {
        pursuit.giveChocolate()
    }
}

// 客户端使用
let jiaojiao1 = SchoolGirl1(name: "李娇娇")
let proxy = Proxy1(mm: jiaojiao1)

proxy.giveChocolate()
proxy.giveFlowers()
proxy.giveDolls()

// 代理模式的作用
// 控制访问 控制对真实对象 的访问，添加额外的逻辑（如安全检查、延迟加载）等
// 简化接口 通过代理类 简化对复杂对象的使用
// 增加功能 调用真实对象前，代理类可以添加额外的功能和逻辑

/**
 优化建议：
 在当前的实现中，Proxy1 类仅仅是简单地转发了所有请求到 Pursuit1 类。这样的话，代理模式的优势并没有完全体现出来。如果想让代理类更有实际意义，可以在 Proxy1 中加入一些额外的逻辑，比如：

 权限检查： 如果 Proxy1 需要进行权限控制，只有在满足某些条件时，才允许代理 Pursuit1 执行操作。
 日志记录： 每次请求的调用可以记录日志，方便调试和跟踪。
 延迟实例化： 在代理类中延迟实例化 Pursuit1，当第一次调用某个方法时才创建 Pursuit1 实例，避免无意义的资源消耗。
 
 
 */
