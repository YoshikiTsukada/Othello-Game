//
//  OthelloModel.swift
//  othello
//
//  Created by 塚田良輝 on 2019/01/17.
//  Copyright © 2019年 塚田良輝. All rights reserved.
//

import UIKit

protocol OthelloModelDelegate : class {
  func dataHasUpdated()
}

// NSObjectを継承させるべきか？
class OthelloModel {
  
  let dimension: Int
  var myColor: UIColor
  var board: SquareMatrix<UIColor>
  
  var delegate: OthelloModelDelegate?
  
  var score: Int {
    didSet {
      self.delegate?.dataHasUpdated()
    }
  }
  
  init(dimension d: Int) {
    dimension = d
    myColor = .black
    score = 0
    board = SquareMatrix(dimention: d, initialValue: .green)
    boardInit(dimension: d)
  }
  
  // ボードを初期化し、最初の石を置く
  func boardInit(dimension d: Int) {
    let centerPosition: Int = d / 2
    let c = centerPosition
    let blackPositon: [(Int, Int)] = [(c - 1, c - 1), (c, c)]
    let whitePosition: [(Int, Int)] = [(c - 1, c), (c, c - 1)]
    
    var (row, col): (Int, Int)
    for i in 0...1 {
      (row, col) = blackPositon[i]
      self.board[row, col] = .black
    }
    for i in 0...1 {
      (row, col) = whitePosition[i]
      self.board[row, col] = .white
    }
  }
  
  // 石が置ける場所かを返す
  func canPutStone(board b: SquareMatrix<UIColor>, position p: (Int, Int), myColor c: UIColor) -> Bool {
    let (col, row) = p
    
    guard b[col, row] == .green && isExistStoneAround(board: b, position: p, myColor: c) else {
      return false
    }
    
    for i in -1...1 {
      for j in -1...1 {
        let t = (i, j)
        if !(i == 0 && j == 0) && isChangeAbleDirection(board: b, position: p, to: t, myColor: c) {
          return true
        }
      }
    }
    
    return false
  }
  
  // 石を裏返せる向きかを返す
  func isChangeAbleDirection(board b: SquareMatrix<UIColor>, position p: (Int, Int), to t: (Int, Int), myColor c: UIColor) -> Bool {
    let opponentColor: UIColor = c == .black ? .white : .black
    var aheadColor: UIColor
    var newPosition = p
    var i = 0
    
    repeat {
      aheadColor = lookAhead(board: b, position: newPosition, to: t)
      let (p1, p2) = newPosition
      let (t1, t2) = t
      newPosition = (p1 + t1, p2 + t2)
      i += 1
    } while aheadColor == opponentColor
    
    if (i == 1 || aheadColor == .green) {
      return false
    }
    
    return true
  }
  
  // 1つ先の石の色を返す
  func lookAhead(board b: SquareMatrix<UIColor>, position p: (Int, Int), to t: (Int, Int)) -> UIColor {
    let (p1, p2) = p
    let (t1, t2) = t
    let (col, row) = (p1 + t1, p2 + t2)
    
    guard 0..<self.dimension ~= col && 0..<self.dimension ~= row else {
      return .green
    }
    
    return b[col, row]
  }
  
  // 周囲8近傍に相手の石があるかを返す
  func isExistStoneAround(board b: SquareMatrix<UIColor>, position p: (Int, Int), myColor c: UIColor) -> Bool {
    let opponentColor: UIColor = c == .black ? .white : .black
    
    let (col, row) = p
    for i in -1...1 {
      for j in -1...1 {
        if !(0..<self.dimension ~= col + i && 0..<self.dimension ~= row + j) {
          continue
        }
        if b[col + i, row + j] == opponentColor {
          return true
        }
      }
    }
    
    return false
  }
  
  // 石が置ける場所の数を返す
  func numberOfPutAblePlace(board b: SquareMatrix<UIColor>, myColor c: UIColor) -> Int {
    var count = 0
    
    for i in 0..<self.dimension {
      for j in 0..<self.dimension {
        let p = (i, j)
        if canPutStone(board: b, position: p, myColor: c) {
          count += 1
        }
      }
    }
    
    return count
  }
  
  func changeStoneColor(board b: SquareMatrix<UIColor>, position p: (Int, Int), myColor c: UIColor) {
    assert(canPutStone(board: b, position: p, myColor: c))
    let opponentColor: UIColor = c == .black ? .white : .black
    let (col, row) = p
    
    for i in -1...1 {
      for j in -1...1 {
        let t = (i, j)
        if !isChangeAbleDirection(board: b, position: p, to: t, myColor: c) {
          continue
        }
        
        var n = 1
        repeat {
          self.board[col + n * i, row + n * j] = c
          n += 1
        } while lookAhead(board: b, position: p, to: (n * i, n * j)) == opponentColor
      }
    }
  }
  
  func putStone(board b: SquareMatrix<UIColor>, position p: (Int, Int), myColor c: UIColor) {
    let (col, row) = p
    self.board[col, row] = c
    changeStoneColor(board: b, position: p, myColor: c)
  }
  
  func isEnd(board b: SquareMatrix<UIColor>) -> Bool {
    guard numberOfPutAblePlace(board: b, myColor: .black) == 0 && numberOfPutAblePlace(board: b, myColor: .white) == 0 else {
      return false
    }
    
    return true
  }
  
  func changeTurn() {
    self.myColor = self.myColor == .black ? .white : .black
  }
}

extension OthelloModel : ViewDataSource {
  var scoreData: Int {
    return self.score
  }
}
