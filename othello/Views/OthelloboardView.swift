//
//  OthelloboardView.swift
//  othello
//
//  Created by 塚田良輝 on 2019/01/01.
//  Copyright © 2019年 塚田良輝. All rights reserved.
//

import UIKit

class OthelloboardView : UIView {
  
  let dimension: Int
  let sWidth: CGFloat
  let sHeight: CGFloat
  let boardSize: CGFloat
  let cellSize: CGFloat
  let cellPadding: CGFloat = 1.0
  let edgePadding: CGFloat = 2.0
  let viewPadding: CGFloat = 10.0
  let stoneRadius: CGFloat
  // ジェネリクス
  //var stones: SquareOthelloboard<StoneView>
  // オプショナル型の使い方が分からない
//  var stones: SquareMatrix<StoneView?>
  var stones: SquareMatrix<UIButton>
  //var stones: Dictionary<IndexPath, StoneView>
  //var scoreView: [ScoreView]
  
  init(dimension d: Int, sWidth width: CGFloat, sHeight height: CGFloat, boardSize bSize: CGFloat, cellSize cSize: CGFloat, boardColor bcolor: UIColor, cellColor cColor: UIColor, stoneRadius sradius: CGFloat) {
    dimension = d
    sWidth = width
    sHeight = height
    boardSize = bSize
    cellSize = cSize
    stoneRadius = sradius
    stones = SquareMatrix(dimention: d, initialValue: UIButton())
    //stones = Dictionary()
    //scoreView = Array()
    // スーパークラスの初期化が分からない
    super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    setupOthelloboard(boardSize: bSize, boardColor: bcolor, cellColor: cColor)
  }
  
  // 何やってるか分からん(後で調べる)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupOthelloboard(boardSize bSize: CGFloat, boardColor bcolor: UIColor, cellColor cColor: UIColor) {
    func setStoneButton() -> UIButton {
      let tentativeStone = UIButton()
      let r = self.stoneRadius
      let center = (self.cellSize - 2*r) / 2
      tentativeStone.frame = CGRect(x: center, y: center, width: 2*r, height: 2*r)
      tentativeStone.backgroundColor = .green
      tentativeStone.layer.cornerRadius = r
      tentativeStone.clipsToBounds = true
      return tentativeStone
    }
    
    func setStartStone(dimension d: Int) {
      let centerPosition: Int = d / 2
      let c = centerPosition
      let blackPositon: [(Int, Int)] = [(c - 1, c - 1), (c, c)]
      let whitePosition: [(Int, Int)] = [(c - 1, c), (c, c - 1)]
      
      var (row, col): (Int, Int)
      // 黒の石を作る
      for i in 0..<2 {
        (row, col) = blackPositon[i]
        // オプショナル型の使い方が分からない
//        if let s = stones[IndexPath(row: row, section: col)] {
//          s.color = .black
//          s.makeStone()
//          //addSubview(s)
//          //bringSubviewToFront(s)
//          stones[IndexPath(row: row, section: col)] = s
//        }
        // 定数にしているのが原因？
//        let s = stones[col, row]!
//        s.backgroundColor = .black
//        stones[col, row] = s
        self.stones[col, row].backgroundColor = .black
      }
      // 白の石を作る
      for i in 0..<2 {
        (row, col) = whitePosition[i]
        // オプショナル型の使い方が分からない
//        if let s = stones[IndexPath(row: row, section: col)] {
//          s.color = .white
//          s.makeStone()
//          //addSubview(s)
//          //bringSubviewToFront(s)
//          stones[IndexPath(row: row, section: col)] = s
//        }
        // 定数にしているのが原因？
//        let s = stones[col, row]!
//        s.backgroundColor = .white
//        stones[col, row] = s
        self.stones[col, row].backgroundColor = .white
      }
    }
    
    let board = UIView(frame: CGRect(x: 0, y: 0, width: bSize, height: bSize))
    board.backgroundColor = bcolor
    addSubview(board)
    
    var xPosition = cellPadding
    var yPosition = cellPadding
    for i in 0..<dimension {
      for j in 0..<dimension {
        let cellBackground = UIView(frame: CGRect(x: xPosition, y: yPosition, width: cellSize, height: cellSize))
        cellBackground.backgroundColor = cColor
        let stone = setStoneButton()
        var f = stone.frame
        f.origin.x += xPosition
        f.origin.y += yPosition
        stone.frame = f
        addSubview(cellBackground)
        addSubview(stone)
        //stones[IndexPath(row: i, section: j)] = stone
        self.stones[i, j] = stone
        xPosition += cellPadding + cellSize
      }
      xPosition = cellPadding
      yPosition += cellPadding + cellSize
    }
    
    setStartStone(dimension: dimension)
  }
  
//  func changeStoneColor(at position: (Int, Int), color c: UIColor) {
//    let (wid, hei) = position
//    let x = cellPadding + CGFloat(wid)*(cellPadding + cellSize)
//    let y = cellPadding + CGFloat(hei)*(cellPadding + cellSize)
//    let r = stoneRadius
//    let stone = StoneView(position: CGPoint(x: x, y: y), color: c, radius: r, cellSize: cellSize)
//    addSubview(stone)
//  }
}
