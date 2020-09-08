import XCTest

import GPIOTests

var tests = [XCTestCaseEntry]()
tests += GPIOTests.allTests()
XCTMain(tests)
