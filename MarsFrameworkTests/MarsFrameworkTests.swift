//
//  MarsFrameworkTests.swift
//  MarsFrameworkTests
//
//  Created by Soheil Novinfard on 03/02/2020.
//  Copyright © 2020 Novinfard. All rights reserved.
//

import XCTest
import MarsFramework

class MarsFrameworkTests: XCTestCase {

    func testNumberOfResults() {
		let numbersOfResults = makeSUT()?.numbersOfResults
        XCTAssertEqual(numbersOfResults, 1)

        XCTAssertNil(makeSUT([])?.numbersOfResults)
    }
    
    func testGridSize() {
        let numbersOfResults = makeSUT()?.gridSize
        XCTAssertEqual(numbersOfResults, 3)
        XCTAssertNil(makeSUT([]))
        XCTAssertNil(makeSUT([1,3,4,2,3,2,2,1,3,2]))
    }
    
    func testValues() {
        XCTAssertEqual(makeSUT()?.values, [4,2,3,2,2,1,3,2,1])
    }
    
    func testValidValues() {
        XCTAssertNotNil(makeSUT())
        XCTAssertNil(makeSUT([1,3,4,2,3,2,2,1,3,2,20]))
        XCTAssertNil(makeSUT([1,3,-2,2,3,2,2,1,3,2,20]))
    }
    
    func testRowCollValues() {
        // [(0,0): (0,1); (1,2)]
        XCTAssertEqual(makeSUT()?.matixIndex(at: 0), Mars.MatrixIndex(row: 0, col: 0))
		XCTAssertEqual(makeSUT()?.matixIndex(at: 2), Mars.MatrixIndex(row: 0, col: 2))
		XCTAssertEqual(makeSUT()?.matixIndex(at: 3), Mars.MatrixIndex(row: 1, col: 0))
        
		XCTAssertEqual(makeSUT()?.matixIndex(at: 5), Mars.MatrixIndex(row: 1, col: 2))
		XCTAssertEqual(makeSUT()?.matixIndex(at: 8), Mars.MatrixIndex(row: 2, col: 2))
    }

    func test_calculateCellValueByMatrixIndex() {
        let index = 1
		let matrix = makeSUT()?.matixIndex(at: index)

        let value = makeSUT()?.calculateCell(matrixIndex: matrix)
        XCTAssertEqual(value, 14)
    }

    func test_calculateCellValueByIndex() {
		XCTAssertEqual(makeSUT()?.calculateCell(index: 0), 10)
		XCTAssertEqual(makeSUT()?.calculateCell(index: 2), 8)
		XCTAssertEqual(makeSUT()?.calculateCell(index: 8), 6)
	}

	func test_calculateAllCellResults() {
		// Given
		let sut = makeSUT()

		// When
		let allResults = sut?.allCellResults()

		// Then
		XCTAssertEqual(allResults?.count, 9)
		XCTAssertEqual(allResults?[0], 10)
		XCTAssertEqual(allResults?[8], 6)
	}

	func test_finalOutput() {
		// Given
		let sut = makeSUT()

		// When
		let report = sut?.finalReport()

		// Then
		XCTAssertEqual(report, ["(1, 1 score: 20)"])
	}

	func test_finalOutput_secondTest() {
		// Given
		let sut = makeSUT([3, 4, 2, 3, 2, 1, 4, 4, 2, 0, 3, 4, 1, 1, 2, 3, 4, 4])

		// When
		let report = sut?.finalReport()

		// Then
		XCTAssertEqual(report, [
			"(1, 2 score: 27)",
			"(1, 1 score: 25)",
			"(2, 2 score: 23)"
		])
	}

}

// MARK: - Helpers
extension MarsFrameworkTests {
	private func makeSUT(_ input: [Int] = [1,3,4,2,3,2,2,1,3,2,1]) -> Mars? {
		return Mars(input: input)
	}
}
