//
//  Array+Combos.swift
//  AdventLibTests
//
//  Created by David Paschich on 12/8/18.
//

import Foundation

extension Array {
    public func combinations(n: Int) -> [[Element]] {
        if isEmpty { return [] }
        if n == 0 { return [] }

        if n == 1 {
            return self.map { [$0] }
        }

        var tail = self
        let head = tail.removeFirst()

        let withHead = tail.combinations(n: n - 1).map { [head] + $0 }
        let withoutHead = tail.combinations(n: n)
        return withHead + withoutHead
    }
}
