//
//  ScoreViews.swift
//  othello
//
//  Created by 塚田良輝 on 2019/01/01.
//  Copyright © 2019年 塚田良輝. All rights reserved.
//

import UIKit

//protocol ScoreDataSource : class {
//  //func scoreChanged(to s: Int)
//  var score: Int { get }
//}

class ScoreView : UIView {
  
//  var dataSource: ScoreDataSource?
  
  var stoneColor: UIColor
  
//  var score: Int = 2 {
//    didSet {
//      scoreLabel.text = "\(stoneColor): \(score)"
//    }
//  }
  
  let defaultFrame = CGRect(x: 0, y: 0, width: 140, height: 40)
  var scoreLabel: UILabel
  
  // スコアを表示するラベルの初期化
  init(stoneColor sColor: UIColor, backgroundColor bgcolor: UIColor, textColor tcolor: UIColor, radius r: CGFloat) {
    stoneColor = sColor
    scoreLabel = UILabel(frame: defaultFrame)
    scoreLabel.font = .boldSystemFont(ofSize: 16)
    scoreLabel.textAlignment = .right
    scoreLabel.backgroundColor = bgcolor
    scoreLabel.textColor = tcolor
    scoreLabel.layer.cornerRadius = r
    scoreLabel.clipsToBounds = true
    super.init(frame: defaultFrame)
    addSubview(scoreLabel)
  }
  
  // 何やってるのか分からない(後で調べる)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // 通知が来たらこの関数を呼び出したい
  func scoreChanged(to score: Int) {
    // オプショナル型の使い方
    self.scoreLabel.text = String(score)
  }
}
