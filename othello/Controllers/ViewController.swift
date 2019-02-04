//
//  ViewController.swift
//  othello
//
//  Created by 塚田良輝 on 2018/12/29.
//  Copyright © 2018年 塚田良輝. All rights reserved.
//

import UIKit

class NumberOfPlayersController : UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    
    let screenWidth: CGFloat = self.view.frame.width
    let screenHeight: CGFloat = self.view.frame.height
    
    let pageTitleLabel = UILabel(frame: CGRect(x: screenWidth/4, y: screenHeight/4, width: screenWidth/2, height: screenHeight/4))
    pageTitleLabel.text = "Select mode"
    pageTitleLabel.font = .boldSystemFont(ofSize: 36)
    view.addSubview(pageTitleLabel)
    
    let onePlayerButton = UIButton(frame: CGRect(x: screenWidth/4, y: screenHeight/2-25, width: screenWidth/2, height: 50))
    onePlayerButton.setTitle("1-Player", for: .normal)
    onePlayerButton.setTitleColor(.blue, for: .normal)
    onePlayerButton.addTarget(self, action: #selector(self.goOnePlayer(_:)), for: .touchUpInside)
    view.addSubview(onePlayerButton)
    
    let twoPlayerButton = UIButton(frame: CGRect(x: screenWidth/4, y: screenHeight/2+25, width: screenWidth/2, height: 50))
    twoPlayerButton.setTitle("2-Player", for: .normal)
    twoPlayerButton.setTitleColor(.blue, for: .normal)
    twoPlayerButton.addTarget(self, action: #selector(self.goTwoPlayer(_:)), for: .touchUpInside)
    view.addSubview(twoPlayerButton)
  }
  
  @objc func goOnePlayer(_ sender: UIButton) {
    self.navigationController?.pushViewController(OnePlayerController(dimension: 8), animated: true)
  }
  
  @objc func goTwoPlayer(_ sender: UIButton) {
    self.navigationController?.pushViewController(TwoPlayerController(), animated: true)
  }
}
// モデルが何かの処理をして、ビューの更新が必要な時、ModelDelegateを通じてControllerに通知する
// この場合だと、ボタンがタップされて、石がひっくり返された時？
// その動きに連動して、スコアも更新？

// Controllerに通知が来たら、ビューに保持させたViewDataSourceのメソッドを通じて取得させる
// ViewDataSourceはModelが対応する
