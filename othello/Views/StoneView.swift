//
//  CellView.swift
//  othello
//
//  Created by 塚田良輝 on 2019/01/04.
//  Copyright © 2019年 塚田良輝. All rights reserved.
//

import UIKit

class StoneView : UIView {
  
  var color: UIColor
  let radius: CGFloat
  let cellSize: CGFloat
  var stoneButton: UIButton
  
  init(color c: UIColor, radius r: CGFloat, cellSize cSize: CGFloat) {
    color = c
    radius = r
    cellSize = cSize
//    let center = (cSize - 2*r) / 2
    stoneButton = UIButton()
//    stoneButton = UIButton(frame: CGRect(x: center, y: center, width: 2*r, height: 2*r))
//    stoneButton.backgroundColor = c
//    stoneButton.layer.cornerRadius = r
//    stoneButton.clipsToBounds = true
    // スーパークラスの初期化が分からない
    super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    makeStone()
//    addSubview(stoneButton)
//    print("Button made.")
  }
  
  // 何やってるのか分からん(後で調べる)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func makeStone() {
    let r = radius
    let c = color
    let center = (cellSize - 2*r) / 2
    stoneButton.frame = CGRect(x: center, y: center, width: 2*r, height: 2*r)
    stoneButton.backgroundColor = c
    stoneButton.layer.cornerRadius = r
    stoneButton.clipsToBounds = true
    addSubview(stoneButton)
  }
}
