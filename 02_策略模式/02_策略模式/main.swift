//
//  main.swift
//  02_策略模式
//
//  Created by GRZ on 2024/12/4.
//

import Foundation

print("Hello, World!")

enum CbxType {
    case NORMAL // 正常收费
    case _8OFF // 8折
    case _7OFF // 7折
    case _5OFF // 5折
}

var total: Double = 0.0


func btnOK_Click(textPrice: Double, textNum: Double) {
    
    let totalPrices = textPrice * textNum;
    total += totalPrices
    
    print("单价: \(textPrice) 数量: \(textNum) 合计: \(totalPrices)")
    print("总计: \(total)")
}

//btnOK_Click(textPrice: 10, textNum: 5)
//btnOK_Click(textPrice: 1, textNum: 3)


// 增加打折

func btnOK_Click_discount(textPrice: Double, textNum: Double, cbxIndex: CbxType = .NORMAL) {
    
    var totalPrices: Double;
    
    switch cbxIndex {
    case .NORMAL:
        totalPrices = textPrice * textNum;
    case ._8OFF:
        totalPrices = textPrice * textNum * 0.8;
    case ._7OFF:
        totalPrices = textPrice * textNum * 0.7;
    case ._5OFF:
        totalPrices = textPrice * textNum * 0.5;
    }
    total += totalPrices
    print("单价: \(textPrice) 数量: \(textNum) 合计: \(totalPrices)")
    print("总计: \(total)")
}

//btnOK_Click_discount(textPrice: 10, textNum: 5, cbxIndex: ._8OFF)
//btnOK_Click_discount(textPrice: 1, textNum: 3)

// 简单工厂实现 利用多态

protocol CashSuper {
    func acceptCash(money: Double) -> Double
}

// 正常收费子类
class CashNormal: CashSuper {
    
    func acceptCash(money: Double) -> Double {
        return money
    }
}

// 打折收费子类
class CashRebate: CashSuper {
    var moneyRebate: Double;
   
    init(moneyRebate: Double) {
        self.moneyRebate = moneyRebate
    }
    func acceptCash(money: Double) -> Double {
        return money * moneyRebate
    }
}

class CashReturn: CashSuper {

    
    let moneyCondition: Double
    let moneyReturn: Double
    
    init(moneyCondition: Double, moneyReturn: Double) {
        self.moneyCondition = moneyCondition
        self.moneyReturn = moneyReturn
    }
    
    func acceptCash(money: Double) -> Double {
        
        if money > moneyCondition {
            return money - floor(money/moneyCondition) * moneyReturn
        }
        return money
    }
}

enum CashType {
    case normal
    case rebase(Double)
    case `return`(Double,Double)
}

class CashFactory {
    static func createCashAccept(type: CashType) -> CashSuper {
        switch type {
        case .normal:
            return CashNormal()
        case .rebase(let rebate):
            return CashRebate(moneyRebate: rebate)
        case .return(let money, let returnMoney):
            return CashReturn(moneyCondition: money, moneyReturn: returnMoney)
        }
    }
}

let cashNormal = CashFactory.createCashAccept(type: .normal)

let cashRebate = CashFactory.createCashAccept(type: .rebase(0.8))

let cashReturn = CashFactory.createCashAccept(type: .return(300, 100))


print(cashReturn.acceptCash(money: 2000))

// 策略模式和简单工厂模式结合
// 分离工厂模式，保持context的间接性
class CashContext {
    
    private let cs: CashSuper
    
    init(type: CashType) {
        switch type {
        case .normal:
            cs = CashNormal()
        case .rebase(let rebate):
            cs = CashRebate(moneyRebate: rebate)
        case .return(let money, let returnMoney):
            cs = CashReturn(moneyCondition: money, moneyReturn: returnMoney)
        }
    }
    
    
    func getResult(money: Double) -> Double{
        cs.acceptCash(money: money)
    }
}

// 传统策略模式，客户端直接注入一个策略，而不是通过type简洁间接指定
class CashContext2 {
    private let cs: CashSuper
    
    init(cs: CashSuper) {
        self.cs = cs
    }
    
    func getResult(money: Double) -> Double {
        cs.acceptCash(money: money)
    }
}

let strategy = CashRebate(moneyRebate: 0.8)
let context = CashContext2(cs: strategy)
print(context.getResult(money: 100))

// 如果策略类型较少且较稳定，现有实现已经足够优雅且易于使用。
//如果策略类型较多或变化频繁，可以采用 优化方向 2（分离工厂），保持代码扩展性和清晰度。
//如果需要更高的灵活性和动态注册策略的能力，推荐 优化方向 3（动态注册）。

//TODO:  增加实现反射 实现
