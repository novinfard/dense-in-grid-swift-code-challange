//
//  Mars.swift
//  MarsFramework
//
//  Created by Soheil Novinfard on 03/02/2020.
//  Copyright © 2020 Novinfard. All rights reserved.
//

import Foundation

struct Mars {
    var values: [Int]
    let numbersOfResults: Int
    let gridSize: Int
    
    struct MatrixIndex: Equatable {
        let row: Int
        let col: Int

        var wholeBlock: [MatrixIndex] {
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
        
        
        self.values = Array(input.dropFirst(2))
        self.gridSize = gridSize
        self.numbersOfResults = numbersOfResults
    }
    
    func matixIndex(at index: Int) -> MatrixIndex? {
        guard index < self.values.count else {
            return nil
        }
        
        let col = index % self.gridSize
        let row = (index - (index % gridSize)) / gridSize
        return MatrixIndex(row: row, col: col)
    }

    func isValid(matrix: MatrixIndex) -> Bool {
        guard matrix.row >= 0, matrix.row < self.gridSize,
            matrix.col >= 0, matrix.col < self.gridSize else {
                return false
        }
        return true
    }

    func indexFor(matrix: MatrixIndex) -> Int? {
        let index = matrix.col + (matrix.row * self.gridSize)
        guard index >= 0,
            index < (self.gridSize * self.gridSize) else {
                return nil
        }
        return index
    }

    func valueFor(matrix: MatrixIndex) -> Int {
        guard self.isValid(matrix: matrix) else {
            return 0
        }
        if let index = self.indexFor(matrix: matrix) {
            return self.values[index]
        }
        return 0
    }



    func calculateCell(matrixIndex: MatrixIndex?) -> Int {
        return matrixIndex?.wholeBlock.reduce(0, { (partial, matrix) -> Int in
            return partial + self.valueFor(matrix: matrix)
        }) ?? 0
    }
    
    func calculateCell(index: Int) -> Int {
		let mIndex = self.matixIndex(at: index)
		self.calculateCell(matrixIndex: mIndex)
    }
}
