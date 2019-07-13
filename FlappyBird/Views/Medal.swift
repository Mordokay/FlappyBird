//
//  Medal.swift
//  FlappyBird
//
//  Created by Pedro Saldanha on 13/07/2019.
//  Copyright © 2019 GreenSphereStudios. All rights reserved.
//

import UIKit

class Medal: UIView {
  
  let medalOuterLayer: UIView = {
    let view = UIView()
    view.accessibilityLabel = "medalOuterLayer"
    view.backgroundColor = .clear
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let medalInnerLayer: UIView = {
    let view = UIView()
    view.accessibilityLabel = "medalInnerLayer"
    view.backgroundColor = .clear
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let gradeLetter: UILabel = {
    let label = UILabel()
    label.sizeToFit()
    label.accessibilityLabel = "A"
    label.text = "A"
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .flappyJune80
    label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.4)
    label.textAlignment = .center
    return label
  }()
  
  var medalColor: [(normal: UIColor, dark: UIColor, letter: String)] = []
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(medalOuterLayer)
    self.addSubview(medalInnerLayer)
    
    medalOuterLayer.pin(into: self, safeMargin: false)
    medalInnerLayer.addSubview(gradeLetter)
    
    NSLayoutConstraint.activate([
      gradeLetter.centerXAnchor.constraint(equalTo: medalInnerLayer.centerXAnchor),
      gradeLetter.centerYAnchor.constraint(equalTo: medalInnerLayer.centerYAnchor)
    ])
    
    medalColor.append((normal: #colorLiteral(red: 0.5679925444, green: 0.3416195161, blue: 0.3371325001, alpha: 1), dark: #colorLiteral(red: 0.3772406409, green: 0.2268916493, blue: 0.2239115313, alpha: 1), letter: "M"))
    medalColor.append((normal: #colorLiteral(red: 0.5497343195, green: 0.5497343195, blue: 0.5497343195, alpha: 1), dark: #colorLiteral(red: 0.2837491203, green: 0.3072213732, blue: 0.3413207263, alpha: 1), letter: "M"))
    medalColor.append((normal: #colorLiteral(red: 0.9241611362, green: 0.7405134439, blue: 0.2093213797, alpha: 1), dark: #colorLiteral(red: 0.6819229722, green: 0.4469459653, blue: 0.221978426, alpha: 1), letter: "M"))
    medalColor.append((normal: #colorLiteral(red: 0.8796890378, green: 0.8803812861, blue: 0.8725405335, alpha: 1), dark: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), letter: "M"))
    medalColor.append((normal: #colorLiteral(red: 0.3174764514, green: 0.6162749529, blue: 0.8745657802, alpha: 1), dark: #colorLiteral(red: 0.2158772647, green: 0.4045218825, blue: 0.6690152884, alpha: 1), letter: "M"))
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    medalOuterLayer.layer.cornerRadius = self.frame.width / 2
    medalOuterLayer.layer.borderWidth = relativeWidth(3)
    medalOuterLayer.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
    medalOuterLayer.layer.shadowRadius = 10
    medalOuterLayer.layer.shadowOpacity = 0.8
    
    medalInnerLayer.pin(into: self, safeMargin: false, padding: self.frame.width / 10)
    medalInnerLayer.layer.cornerRadius = (self.frame.width - self.frame.width / 5) / 2
    medalInnerLayer.layer.borderWidth = relativeWidth(3)
    medalInnerLayer.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
    medalInnerLayer.layer.shadowRadius = 10
    medalInnerLayer.layer.shadowOpacity = 0.8
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func calculateMedalColor(highscore: CGFloat, currentScore: CGFloat) {
    let ratio = currentScore / highscore
    //Diamond medal
    if ratio >= 1.5 {
      medalOuterLayer.backgroundColor = medalColor[4].dark
      medalInnerLayer.backgroundColor = medalColor[4].normal
      medalOuterLayer.layer.shadowColor = medalColor[4].normal.cgColor
      gradeLetter.text = medalColor[4].letter
      gradeLetter.textColor = medalColor[4].dark.withAlphaComponent(0.4)
    }//Platinum medal
    else if ratio >= 1.25{
      medalOuterLayer.backgroundColor = medalColor[3].dark
      medalInnerLayer.backgroundColor = medalColor[3].normal
      medalOuterLayer.layer.shadowColor = medalColor[3].normal.cgColor
      gradeLetter.text = medalColor[3].letter
      gradeLetter.textColor = medalColor[3].dark.withAlphaComponent(0.4)
    }//Gold medal
    else if ratio >= 1{
      medalOuterLayer.backgroundColor = medalColor[2].dark
      medalInnerLayer.backgroundColor = medalColor[2].normal
      medalOuterLayer.layer.shadowColor = medalColor[2].normal.cgColor
      gradeLetter.text = medalColor[2].letter
      gradeLetter.textColor = medalColor[2].dark.withAlphaComponent(0.4)
    }//Silver medal
    else if ratio >= 0.75{
      medalOuterLayer.backgroundColor = medalColor[1].dark
      medalInnerLayer.backgroundColor = medalColor[1].normal
      medalOuterLayer.layer.shadowColor = medalColor[1].normal.cgColor
      gradeLetter.text = medalColor[1].letter
      gradeLetter.textColor = medalColor[1].dark.withAlphaComponent(0.4)
    }//Bronze medal
    else if ratio >= 0.5{
      medalOuterLayer.backgroundColor = medalColor[0].dark
      medalInnerLayer.backgroundColor = medalColor[0].normal
      medalOuterLayer.layer.shadowColor = medalColor[0].normal.cgColor
      gradeLetter.text = medalColor[0].letter
      gradeLetter.textColor = medalColor[0].dark.withAlphaComponent(0.4)
    } else {
      medalInnerLayer.alpha = 0
      medalOuterLayer.layer.shadowColor = UIColor.black.cgColor
    }
  }
}
