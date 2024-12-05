//
//  main.swift
//  01_简单工厂模式
//
//  Created by GRZ on 2024/12/3.
//

import Foundation

enum OperationError: Error {
    case ErrorUnknowOper(String)
    case divisionByZero
    case invalidResult
}

print("Hello, World!")

func way01() {
    let a = 10
    let b = "+"
    let c = 20
    var d = 0
    if b == "+" {
        d = a + c
    }
    if b == "-" {
        d = a - c
    }
    if b == "*" {
        d = a * c
    }
    if b == "/" {
        d = a / c
    }
    print("结果是: \(d)")
}

func way02(numA: Int, numB: Int, operate: String) throws {
    var result = 0
    switch operate {
    case "+":
        result = numA + numB
    case "-":
        result = numA - numB
    case "*":
        result = numA * numB
    case "/":
        if numB != 0 {
            result = numA / numB
        } else {
            throw OperationError.ErrorUnknowOper("numB 不能为0")
        }
        
    default:
        throw OperationError.ErrorUnknowOper("未知运算符:\(operate)")
    }
    
    print("结果是: \(result)")
}

class Operation {
    
    static func getResult(numA: Int, numB: Int, operate: String) throws -> Int {
        var result = 0
        switch operate {
        case "+":
            result = numA + numB
        case "-":
            result = numA - numB
        case "*":
            result = numA * numB
        case "/":
            if numB != 0 {
                result = numA / numB
            } else {
                throw OperationError.ErrorUnknowOper("numB 不能为0")
            }
            
        default:
            throw OperationError.ErrorUnknowOper("未知运算符:\(operate)")
        }
        
        return result
    }
    
}

// 第一想到的实现方式，
//way01()

// 第二种 修改一些基础错误
//do {
//    try way02(numA: 10, numB: 0, operate: "&")
//} catch OperationError.ErrorUnknowOper(let error){
//    print("error = \(error)")
//}

// 第三种，通过面向对象 的封装
//do {
//    try print(Operation.getResult(numA: 10, numB: 10, operate: "+"))
//} catch OperationError.ErrorUnknowOper(let error){
//    print("error = \(error)")
//}

// 第四种 增加 继承和多态特性， 使程序可扩展和好维护，单一职责，
protocol OperationProtocol {
    init()
    func getResult(numA: Int, numB: Int) throws -> Int
}

class OperationAdd: OperationProtocol {
    required init() {}
    func getResult(numA: Int, numB: Int) -> Int {
        numA + numB
    }
}

class OperationSub: OperationProtocol {
    required init() {}
    func getResult(numA: Int, numB: Int) -> Int {
        numA - numB
    }
}

class OperationMul: OperationProtocol {
    required init() {}
    func getResult(numA: Int, numB: Int) -> Int {
        numA * numB
    }
}

class OperationDiv: OperationProtocol {
    required init() {}
    func getResult(numA: Int, numB: Int) throws -> Int {
        guard numB != 0 else {
            throw OperationError.divisionByZero
        }
        let result = numA / numB
        guard result != Int.min else {
            throw OperationError.invalidResult
        }
        return result
    }
}

// 工厂类
class OperationFactory {
    static func createOperate<T: OperationProtocol>(type: T.Type) -> T  {
        return T()
    }
}

let addOperation = OperationFactory.createOperate(type: OperationAdd.self)
print(addOperation.getResult(numA: 12, numB: 12))


let divOperation = OperationFactory.createOperate(type: OperationDiv.self)
//
//do {
//    let result = try divOperation.getResult(numA: 12, numB: 0)
//    print("Result: \(result)")
//} catch OperationError.divisionByZero {
//    print("Error: Division by zero is not allowed.")
//} catch OperationError.invalidResult {
//    print("Error: Invalid result (overflow or other issues).")
//} catch {
//    print("Unexpected error: \(error).")
//}

