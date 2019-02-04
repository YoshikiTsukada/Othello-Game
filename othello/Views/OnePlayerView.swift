//
//  OnePlayerView.swift
//  othello
//
//  Created by 塚田良輝 on 2019/01/17.
//  Copyright © 2019年 塚田良輝. All rights reserved.
//

import UIKit

protocol ViewDataSource : class {
  var scoreData: Int { get }
}

class OnePlayerView : UIView {

  let dimension: Int
  let sWidth: CGFloat
  let sHeight: CGFloat
  let cellPadding: CGFloat = 1.0
  let edgePadding: CGFloat = 2.0
  let viewPadding: CGFloat = 10.0
  var boardView: OthelloboardView!
  var blackScoreView: ScoreView!
  var whiteScoreView: ScoreView!
  
  var dataSource: ViewDataSource?
  
  init(dimension d: Int, sWidth width: CGFloat, sHeight height: CGFloat) {
    dimension = d
    sWidth = width
    sHeight = height
    super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupView() {
    blackScoreView = ScoreView(
      stoneColor: .black,
      backgroundColor: .gray,
      textColor: .black,
      radius: 6
    )
    whiteScoreView = ScoreView(
      stoneColor: .white,
      backgroundColor: .gray,
      textColor: .white,
      radius: 6
    )
    
    let boardSize = sWidth - 2*edgePadding
    let cellSize = (boardSize - (cellPadding + CGFloat(dimension)*cellPadding))/CGFloat(dimension)
    let stoneRadius = (cellSize - 2*viewPadding)/2
    boardView = OthelloboardView(
      dimension: dimension,
      sWidth: sWidth,
      sHeight: sHeight,
      boardSize: boardSize,
      cellSize: cellSize,
      boardColor: .black,
      cellColor: .green,
      stoneRadius: stoneRadius
    )
    
    assert(blackScoreView != nil)
    var b = blackScoreView.frame
    b.origin.x = (sWidth - (2*b.width + viewPadding))/2
    b.origin.y = (sHeight - (boardSize + viewPadding))/2
    blackScoreView.frame = b
    
    assert(whiteScoreView != nil)
    var w = whiteScoreView.frame
    w.origin.x = b.origin.x + b.width + viewPadding
    w.origin.y = b.origin.y
    whiteScoreView.frame = w
    
    assert(boardView != nil)
    var o = boardView.frame
    o.origin.x = (sWidth - boardSize)/2
    o.origin.y = b.origin.y + b.height + viewPadding
    boardView.frame = o
    
    addSubview(blackScoreView)
    addSubview(whiteScoreView)
    addSubview(boardView)
  }
  
  func updateView() {
    assert(self.dataSource != nil)
    let s = self.dataSource!.scoreData
    self.blackScoreView.scoreChanged(to: s)
  }
}
