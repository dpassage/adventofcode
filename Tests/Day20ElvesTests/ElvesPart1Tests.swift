import XCTest

@testable import Day20Elves

class ElvesTests: XCTestCase {
    func testPrestnts() {
        let testcases = [
            (1, 10),
            (2, 30),
        ]

        for (input, result) in testcases {
            let run = presents(n: input)
            XCTAssertEqual(run, result)
        }
    }

    func testFirstHouse() {
        let testcases = [
            (10, 1),
            (30, 2),
            (120, 6),
            (80, 6),
        ]

        for (input, result) in testcases {
            let run = firstHouseWithAtLeast(n: input)
            XCTAssertEqual(run, result)
        }
    }
}
