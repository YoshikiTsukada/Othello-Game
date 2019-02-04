//
//  OnePlayerController.swift
//  othello
//
//  Created by 塚田良輝 on 2018/12/29.
//  Copyright © 2018年 塚田良輝. All rights reserved.
//

import UIKit

class OnePlayerController : UIViewController {
  
  let dimension: Int
//  let screenWidth: CGFloat
//  let screenHeight: CGFloat
  
//  var scoreView: [ScoreView]
//
//  let cellPadding: CGFloat = 1.0
//  let edgePadding: CGFloat = 2.0
//  let viewPadding: CGFloat = 10.0
  
  var othelloModel: OthelloModel
  var onePlayerView: OnePlayerView
  
  init(dimension d: Int) {
    dimension = d
    othelloModel = OthelloModel(dimension: d)
    onePlayerView = OnePlayerView(dimension: d, sWidth: UIScreen.main.bounds.size.width, sHeight: UIScreen.main.bounds.size.height)
    //super.init(nibName: nil, bundle: nil)
    //screenWidth = self.view.frame.width
    //screenHeight = self.view.frame.height
    //scoreView = Array()
    super.init(nibName: nil, bundle: nil)
    othelloGame()
  }
  
  // 何やってるか分からん(後で調べる)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //self.onePlayerView = OnePlayerView(dimension: self.dimension, sWidth: self.view.frame.width, sHeight: self.view.frame.height)
    self.view = self.onePlayerView
    self.view.backgroundColor = .white
    
    // 黒のスコアだけカウントする
    self.onePlayerView.dataSource = self.othelloModel
    self.othelloModel.delegate = self
    
    //setupGame()
    
    // 先手か後手かを選択するアラートの表示(未完成)
//    let chooseOrderAlert: UIAlertController = UIAlertController(title: "先手か後手", message: "選択して下さい", preferredStyle: UIAlertController.Style.alert)
  }
  
  func othelloGame() {
    for i in 0..<self.dimension {
      for j in 0..<self.dimension {
        let button = self.onePlayerView.boardView.stones[i, j]
        button.addTarget(self, action: #selector(self.processing(_:)), for: .touchUpInside)
      }
    }
//    self.onePlayerView.boardView.stones[3, 3].addTarget(self, action: #selector(self.processing(_:)), for: .touchUpInside)
//    for i in 0..<self.dimension {
//      for j in 0..<self.dimension {
//        self.onePlayerView.boardView.stones[i, j].backgroundColor = .blue
//      }
//    }
  }
  
  @objc func processing(_ sender: UIButton) {
    print("processing() is worked.")
    switch sender.backgroundColor {
    case UIColor.black:
      sender.backgroundColor = .white
    case UIColor.white:
      sender.backgroundColor = .black
    default:
      sender.backgroundColor = .black
    }
  }
  
//  func variableInit() {
//    let screenWidth = self.view.frame.width
//    let screenHeight = self.view.frame.height
//
//    self.onePlayerView = OnePlayerView(dimension: dimension, sWidth: screenWidth, sHeight: screenHeight)
//    self.othelloModel = OthelloModel(dimension: dimension, onePlayerView: self.onePlayerView)
//  }
  
  
  //
  //
  /*  ここから下はviewの仕事  */
  //
  //
  
  
//  func setupGame() {
//    // 画面の幅と高さ
//    let sWidth: CGFloat = self.view.frame.width
//    let sHeight: CGFloat = self.view.frame.height
//
//    let blackScoreView = ScoreView(stoneColor: .black,
//          backgroundColor: .gray,
//          textColor: .black,
//          radius: 6)
//    let whiteScoreView = ScoreView(stoneColor: .white,
//          backgroundColor: .gray,
//          textColor: .white,
//          radius: 6)
//
//    let boardSize = sWidth - 2*edgePadding
//    let cellSize = (boardSize - (cellPadding + CGFloat(dimension)*cellPadding))/CGFloat(dimension)
//    let sRadius = (cellSize - 2*viewPadding)/2
//    let othelloboard = OthelloboardView(dimension: dimension, boardSize: boardSize, cellSize: cellSize, boardColor: .black, cellColor: .green, stoneRadius: sRadius)
//
//    var b = blackScoreView.frame
//    b.origin.x = (sWidth - (2*b.width + viewPadding))/2
//    b.origin.y = (sHeight - (boardSize + viewPadding))/2
//    blackScoreView.frame = b
//
//    var w = whiteScoreView.frame
//    w.origin.x = b.origin.x + b.width + viewPadding
//    w.origin.y = b.origin.y
//    whiteScoreView.frame = w
//
//    var o = othelloboard.frame
//    o.origin.x = (sWidth - boardSize)/2
//    o.origin.y = b.origin.y + b.height + viewPadding
//    othelloboard.frame = o
//
//    view.addSubview(blackScoreView)
//    view.addSubview(whiteScoreView)
//    view.addSubview(othelloboard)
//
//    scoreView = [blackScoreView, whiteScoreView]
//  }
}

extension OnePlayerController : OthelloModelDelegate {
  func dataHasUpdated() {
    self.onePlayerView.updateView()
  }
}
