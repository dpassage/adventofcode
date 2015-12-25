//: [Previous](@previous)

import Foundation


enum Gate {
    case Value(UInt16)
    case And(String, String)
    case Or(String, String)
    case Not(String)
    case Lshift(String, UInt16)
    case Rshift(String, UInt16)
}
var str = "Hello, playground"

//: [Next](@next)
