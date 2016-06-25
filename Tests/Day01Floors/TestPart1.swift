import XCTest

@testable import Day01Floors

class FloorsTests: XCTestCase {
    func testPart1() {
        let testcases = [("(())", 0)]

        for (input, result) in testcases {
            let run = santa(input: input)
            XCTAssertEqual(run, result)
        }
        XCTAssert(true)
    }
}
