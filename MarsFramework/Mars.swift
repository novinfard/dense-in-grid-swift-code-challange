//
//  Mars.swift
//  MarsFramework
//
//  Created by Soheil Novinfard on 03/02/2020.
//  Copyright © 2020 Novinfard. All rights reserved.
//

import Foundation

public struct Matrix {
    public var values: [Int]
    public let gridSize: Int

    public struct MatrixIndex: Equatable {
        let row: Int
        let col: Int

        public init(row: Int, col: Int) {
            self.row = row
            self.col = col
        }

        public var wholeBlock: [MatrixIndex] {
            var results = [MatrixIndex]()
            for i in -1 ... 1 {
                for j in -1 ... 1 {
                    results.append(MatrixIndex(
                        row: self.row + i,
                        col: self.col + j
                    ))
                }
            }
            return results
        }
    }

    public init(values: [Int], gridSize: Int) {
        self.values = values
        self.gridSize = gridSize
    }

    subscript(matrixIndex: MatrixIndex) -> Int {
        get {
            return values[(matrixIndex.row * matrixIndex.col + matrixIndex.col)]
        }
        set {
            return values[(matrixIndex.row * matrixIndex.col + matrixIndex.col)] = newValue
        }
    }

    public func matixIndex(at index: Int) -> MatrixIndex? {
        guard index < self.values.count else {
            return nil
        }

        let col = index % self.gridSize
        let row = (index - (index % gridSize)) / gridSize
        return MatrixIndex(row: row, col: col)
    }

    public func indexFor(matrix: MatrixIndex) -> Int? {
        let index = matrix.col + (matrix.row * self.gridSize)
        guard index >= 0,
            index < (self.gridSize * self.gridSize) else {
                return nil
        }
        return index
    }

    public func valueFor(matrix: MatrixIndex) -> Int {
        guard self.isValid(matrix: matrix) else {
            return 0
        }
        if let index = self.indexFor(matrix: matrix) {
            return self.values[index]
        }
        return 0
    }

    public func calculateCell(matrixIndex: MatrixIndex?) -> Int {
        return matrixIndex?.wholeBlock.reduce(0, { (partial, matrix) -> Int in
            return partial + self.valueFor(matrix: matrix)
        }) ?? 0
    }

    func isValid(matrix: MatrixIndex) -> Bool {
        guard matrix.row >= 0, matrix.row < self.gridSize,
            matrix.col >= 0, matrix.col < self.gridSize else {
                return false
        }
        return true
    }
}

public struct Mars {
    private(set) public var matrix: Matrix
    public let numbersOfResults: Int

    public struct ResultItem {
        let index: Int
        let score: Int
    }

    public init?(input: [Int]) {
        guard let numbersOfResults = input.first else {
            return nil
        }
        guard let gridSize = input[safe: 1] else {
            return nil
        }
        guard input.count == gridSize * gridSize + 2 else {
            return nil
        }
        guard let min = input.min(), min >= 0,
            let max = input.max(), max <= 9 else {
            return nil
        }


        let values = Array(input.dropFirst(2))

        self.matrix = Matrix(values: values, gridSize: gridSize)
        self.numbersOfResults = numbersOfResults
    }

    public func calculateCell(index: Int) -> Int {
        let mIndex = self.matrix.matixIndex(at: index)
        return self.matrix.calculateCell(matrixIndex: mIndex)
    }

    public func allCellResults() -> [Int] {
        return Array(0 ..< self.matrix.values.count).map {
            return self.calculateCell(index: $0)
        }
    }

    public func sortedResults() -> [ResultItem] {
        var results = [ResultItem]()
        for (index, result) in self.allCellResults().enumerated() {
            results.append(ResultItem(index: index, score: result))
        }
        return results.sorted(by: { $0.score > $1.score })
    }

    public func output() -> [ResultItem] {
        let results = self.sortedResults()
        return Array(results.prefix(self.numbersOfResults))
    }

    public func finalReport() -> [String] {
        return self.output().compactMap {
            guard let matrix = self.matrix.matixIndex(at: $0.index) else { return nil }
            return "(\(matrix.col), \(matrix.row) score: \($0.score))"
        }
    }
}

fileprivate extension Collection {
    subscript (safe index: Index) -> Iterator.Element? {
        return index >= startIndex && index < endIndex ? self[index] : nil
    }
}
