//
//  UIFont.swift
//  FlappyBird
//
//  Created by Pedro Saldanha on 13/07/2019.
//  Copyright © 2019 GreenSphereStudios. All rights reserved.
//

import UIKit

extension UIFont {
  var currentWindowSize: CGSize {
    return  UIApplication.shared.keyWindow?.bounds.size ?? UIWindow().bounds.size
  }
  func relativeWidth(_ width: CGFloat) -> CGFloat {
    return currentWindowSize.width * (width / 414)
  }
  func relativeHeight(_ height: CGFloat) -> CGFloat {
    return currentWindowSize.height * (height / 896)
  }
  
  private static func flappyJuneFont(ofSize size: CGFloat) -> UIFont {
    return UIFont(name: "Junegull-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
  }
  private static func flappySigmarFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "SigmarOne", size: size) ?? UIFont.systemFont(ofSize: size)
  }
  private static func flappyOpiFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Opificio-BoldRounded", size: size) ?? UIFont.systemFont(ofSize: size)
  }
  
  public static var flappyJune100: UIFont { return flappyJuneFont(ofSize: CGSize.relativeWidth(100)) }
  public static var flappyJune80: UIFont { return flappyJuneFont(ofSize: CGSize.relativeWidth(80)) }
  public static var flappyJune70: UIFont { return flappyJuneFont(ofSize: CGSize.relativeWidth(70)) }
  public static var flappyJune60: UIFont { return flappyJuneFont(ofSize: CGSize.relativeWidth(60)) }
  public static var flappyJune40: UIFont { return flappyJuneFont(ofSize: CGSize.relativeWidth(40)) }
  public static var flappyJune30: UIFont { return flappyJuneFont(ofSize: CGSize.relativeWidth(30)) }
  public static var flappyOpi40: UIFont { return flappyOpiFont(ofSize: CGSize.relativeWidth(40)) }
  public static var flappyOpi30: UIFont { return flappyOpiFont(ofSize: CGSize.relativeWidth(30)) }
  public static var flappyOpi20: UIFont { return flappyOpiFont(ofSize: CGSize.relativeWidth(20)) }
}

