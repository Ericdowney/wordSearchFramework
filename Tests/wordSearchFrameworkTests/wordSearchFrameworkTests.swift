import XCTest
@testable import wordSearchFramework

final class wordSearchFrameworkTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(wordSearchFramework().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
