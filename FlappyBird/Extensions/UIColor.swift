//
//  UIColor.swift
//  FlappyBird
//
//  Created by Pedro Saldanha on 12/07/2019.
//  Copyright © 2019 GreenSphereStudios. All rights reserved.
//

import UIKit

extension UIColor {
  public class var coolGreen: UIColor { return UIColor (hex: 0x00ffcc) }
  public class var darkBlue: UIColor { return UIColor(hex: 0x000f21) }
  public class var lightDarkBlue: UIColor { return UIColor(hex: 0x00486f) }
  
  convenience public init(hex: Int32) {
    //let alpha = CGFloat((hex & 0x000000) >> 24) / 255.0
    let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
    let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
    let blue = CGFloat((hex & 0xFF)) / 255.0
    self.init(red: red, green: green, blue: blue, alpha: 1)
  }
}
