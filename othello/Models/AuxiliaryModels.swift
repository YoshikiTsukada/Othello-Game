//
//  AuxiliaryModels.swift
//  othello
//
//  Created by 塚田良輝 on 2019/01/09.
//  Copyright © 2019年 塚田良輝. All rights reserved.
//

import Foundation

enum StoneObject {
  case empty
  case black
  case white
}

struct SquareMatrix<T> {
  let dimention: Int
  var boardArray: [T]
  
  init(dimention d: Int, initialValue: T) {
    dimention = d
    boardArray = [T](repeating: initialValue, count: d*d)
  }
  
  subscript(row: Int, col: Int) -> T {
    get {
      assert(row >= 0 && row < dimention)
      assert(col >= 0 && col < dimention)
      return boardArray[row*dimention + col]
    }
    set {
      assert(row >= 0 && row < dimention)
      assert(col >= 0 && col < dimention)
      boardArray[row*dimention + col] = newValue
    }
  }
}
