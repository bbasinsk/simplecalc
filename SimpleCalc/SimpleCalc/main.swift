//
//  main.swift
//  SimpleCalc
//
//  Created by Ted Neward on 10/3/17.
//  Copyright © 2017 Neward & Associates. All rights reserved.
//

import Foundation

public class Calculator {
    
    enum CalculatorError: Error {
        case invalidOperator(String)
        case invalidExpression(String)
    }

    public func calculate(_ args: [String]) -> Int {
        do {
            // Last argument is an operator
            if Int(args[args.count - 1]) == nil {
                let numStrings: [String] = Array(args[...(args.count - 2)])
                let nums = numStrings.map({ x in Int(x)! })
                
                return try evaluateExpression(nums, expression: args[args.count - 1])
            }
                // Simple operations
            else {
                let l = Int(args[0])!
                let r = Int(args[2])!
                let op = args[1]
                return try performSimpleOperation(l, r, op: op)
            }
        } catch {
            return 0
        }
    }
    
    public func calculate(_ arg: String) -> Int {
        return calculate( arg.split(separator: " ").map({ substr in String(substr) }) )
    }
    
    private func evaluateExpression(_ nums: [Int], expression: String) throws -> Int {
        switch expression {
        case "count":
            return self.count(nums)
        case "avg":
            return self.average(nums)
        case "fact":
            if (nums.count == 0) { return 0 }
            return self.factorial(nums[0])
        default:
            throw CalculatorError.invalidExpression(expression)
        }
    }
    
    private func performSimpleOperation(_ left: Int, _ right: Int, op: String) throws -> Int {
        switch op {
        case "+":
            return left + right
        case "-":
            return left - right
        case "*":
            return left * right
        case "/":
            return left / right
        case "%":
            return left % right
        default:
            throw CalculatorError.invalidOperator(op)
        }
    }
    
    private func count(_ nums: [Int]) -> Int {
        return nums.count
    }
    
    private func average(_ nums: [Int]) -> Int {
        if (nums.count < 1) { return 0 }
        
        let sum = nums.reduce(0, {x,y in x + y})
        return sum / nums.count
    }
    
    private func factorial(_ n: Int) -> Int {
        if n == 0 { return 1 }
        return n * factorial(n - 1)
    }
}

print("UW Calculator v1")
print("Enter an expression separated by returns:")
let first = readLine()!
let operation = readLine()!
let second = readLine()!
print(Calculator().calculate([first, operation, second]))

