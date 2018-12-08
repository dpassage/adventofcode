//
//  ArrayComboTests.swift
//  AdventLibTests
//
//  Created by David Paschich on 12/8/18.
//

import XCTest
import AdventLib

class ArrayComboTests: XCTestCase {

    func testOne() {
        let input = [2, 3]
        let combos = input.combinations(n: 1)
        XCTAssertEqual(combos, [[2], [3]])
    }

    func testTwo() {
        let input = [1, 2, 3]
        let combos = input.combinations(n: 2)
        XCTAssertEqual(combos, [[1, 2], [1, 3], [2, 3]])
    }

    func testThree() {
        let input = [1, 2, 3, 4]
        let combos = input.combinations(n: 3)
        XCTAssertEqual(combos, [
                [1, 2, 3],
                [1, 2, 4],
                [1, 3, 4],
                [2, 3, 4]
            ])
    }

    func testTwoOfFour() {
        let input = [1, 2, 3, 4]
        let combos = input.combinations(n: 2)
        XCTAssertEqual(combos, [
            [1, 2],
            [1, 3],
            [1, 4],
            [2, 3],
            [2, 4],
            [3, 4]
            ])
    }
}
