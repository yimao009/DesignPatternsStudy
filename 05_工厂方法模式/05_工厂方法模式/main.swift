//
//  main.swift
//  05_工厂方法模式
//
//  Created by GRZ on 2024/12/8.
//

import Foundation

print("Hello, World!")

protocol OperationProtocol {
    func getResult(numA: Int, numB: Int) -> Int
}


class OperationAdd: OperationProtocol {
    func getResult(numA: Int, numB: Int) -> Int {
        return numA + numB
    }
}

class OperationSub: OperationProtocol {
    func getResult(numA: Int, numB: Int) -> Int {
        return numA - numB
    }
}

class OperationMul: OperationProtocol {
    func getResult(numA: Int, numB: Int) -> Int {
        return numA * numB
    }
}

class OperationDiv: OperationProtocol {
    func getResult(numA: Int, numB: Int) -> Int {
        guard numB != 0 else {
            fatalError("Division by zero is not allowed.")
        }
        return numA / numB
    }
}

protocol OperationFactory {
    func createOperation() -> OperationProtocol
}

class AddFactory: OperationFactory {
    func createOperation() -> OperationProtocol {
        return OperationAdd()
    }
}

class SubFactory: OperationFactory {
    func createOperation() -> OperationProtocol {
        return OperationSub()
    }
}

class MulFactory: OperationFactory {
    func createOperation() -> OperationProtocol {
        return OperationMul()
    }
}

class DivFactory: OperationFactory {
    func createOperation() -> OperationProtocol {
        return OperationDiv()
    }
}

class OperationContext {
    private var operation: OperationProtocol
    
    init(operationFactory: OperationFactory) {
        self.operation = operationFactory.createOperation()
    }
    
    func getResult(numA: Int, numB: Int) -> Int {
        return operation.getResult(numA: numA, numB: numB)
    }
}

// 客户端代码
//let contextAdd = OperationContext(operationFactory: AddFactory())
//print(contextAdd.getResult(numA: 10, numB: 5))  // 输出：15
//
//let contextSub = OperationContext(operationFactory: SubFactory())
//print(contextSub.getResult(numA: 10, numB: 5))  // 输出：5


protocol LeiFengProtocol {
    init()
    func sweep()
    func wash()
    func buyRice()
}

class LeiFeng: LeiFengProtocol {
    required init() {}
    func sweep() {
        print("扫地🧹")
    }
    
    func wash() {
        print("洗衣")
    }
    
    func buyRice() {
        print("买米")
    }
    
}

class Undergraduate: LeiFeng {
    required init(){}
}

class Volunteer: LeiFeng {
    required init(){}
}


// 简单工厂类
class SimpleFactory {
    static func createOperate<T: LeiFeng>(type: T.Type) -> T  {
        return T()
    }
}

// 工厂模式
protocol LeifengFactory {
    associatedtype LeiFengType: LeiFengProtocol
    func createLeiFeng() -> LeiFengType
}


// 通过使用泛型，工厂类可以更具通用性，不需要为每种 LeiFeng 子类创建不同的工厂类。
class GenericLeiFengFactory<T: LeiFengProtocol>{
    func createLeiFeng() -> T {
        return T()  // 根据泛型 T 创建相应的对象
    }
}

//class UndergraduateFactory: LeifengFactory {
//    func createLeiFeng() -> LeiFeng {
//         Undergraduate()
//    }
//}
//
//class VolunteerFactory: LeifengFactory {
//    func createLeiFeng() -> LeiFeng {
//         Volunteer()
//    }
//}

//let xueleifeng = Undergraduate()
//xueleifeng.buyRice()
//xueleifeng.sweep()
//xueleifeng.wash()

//let s1 = Undergraduate()
//s1.buyRice()
//let s2 = Undergraduate()
//s2.sweep()
//let s3 = Undergraduate()
//s3.wash()

//let student1 = SimpleFactory.createOperate(type: Undergraduate.self)
//student1.buyRice()
//
//
//let student2 = SimpleFactory.createOperate(type: Undergraduate.self)
//student2.wash()

//let factory = UndergraduateFactory()
//let student = factory.createLeiFeng()
//student.buyRice()
let factory = GenericLeiFengFactory<Undergraduate>()
let student = factory.createLeiFeng()
student.buyRice()

/*
 
 工厂方法模式：减少了工厂类的复杂性，通过分离不同工厂类来处理不同的实例化逻辑，客户端需要选择和管理不同的工厂类，
            但客户端代码更易于扩展和维护。开发人员需要更多的设计决策和选择判断，但避免了复杂的工厂类逻辑。
 简单工厂模式：更适合小型项目或操作种类较少的场景，客户端非常简洁，但随着功能扩展，
            工厂类可能变得庞大，导致维护困难。
 */
