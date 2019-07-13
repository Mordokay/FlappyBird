//
//  TrippleDashView.swift
//  FlappyBird
//
//  Created by Pedro Saldanha on 12/07/2019.
//  Copyright © 2019 GreenSphereStudios. All rights reserved.
//

import UIKit

class TrippleDashView: UIView {
  
  let line1: UIView = {
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 7)
    return view
  }()
  
  let line2: UIView = {
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let line3: UIView = {
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 7)
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(line1)
    self.addSubview(line2)
    self.addSubview(line3)
    
    line1.layer.cornerRadius = relativeWidth(1)
    line2.layer.cornerRadius = relativeWidth(1)
    line3.layer.cornerRadius = relativeWidth(1)
    
    NSLayoutConstraint.activate([
      line1.widthAnchor.constraint(equalToConstant: relativeHeight(3)),
      line1.heightAnchor.constraint(equalToConstant: relativeHeight(15)),
      line1.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: relativeWidth(-10)),
      line1.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      
      line2.widthAnchor.constraint(equalToConstant: relativeHeight(3)),
      line2.heightAnchor.constraint(equalToConstant: relativeHeight(15)),
      line2.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      line2.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: relativeHeight(-5)),
      
      line3.widthAnchor.constraint(equalToConstant: relativeHeight(3)),
      line3.heightAnchor.constraint(equalToConstant: relativeHeight(15)),
      line3.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: relativeWidth(10)),
      line3.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
