//
//  FlappyBird.swift
//  BONDTouch
//
//  Created by kwamecorp on 03/07/2019.
//  Copyright © 2019 Impossible. All rights reserved.
//

import UIKit
import AudioToolbox

class FlappyBird: UIViewController {
  
  var displayLink: CADisplayLink!
  var scoreSound: SystemSoundID = 0
  var wingFlapSound: SystemSoundID = 1
  var hitObstacleSound: SystemSoundID = 2
  
  var lastVelocity: CGFloat = 0
  
  let minBirdAngle = -CGFloat.pi / 4
  let maxBirdAngle = CGFloat.pi / 3
  var highScore: Int {
    get {
      return UserDefaults.standard.integer(forKey: "highScore")
    }
    set {
      UserDefaults.standard.set(newValue, forKey: "highScore")
    }
  }
  
  let bird: UIView = {
    let view = UIView()
    view.accessibilityLabel = "BIRD"
    view.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    return view
  }()
  
  let birdBorder: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    view.layer.borderWidth = 2
    return view
  }()

  let birdEye: UIView = {
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    view.layer.borderWidth = 2
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let birdSmallerEye: UIView = {
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let birdWing: UIView = {
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    view.layer.borderWidth = 2
    view.translatesAutoresizingMaskIntoConstraints = false
    view.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 10)
    return view
  }()
  
  let birdMouth: UIView = {
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3681130481, blue: 0, alpha: 1)
    view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    view.layer.borderWidth = 2
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let handIconImage: UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFit
    view.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    view.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
    view.image = #imageLiteral(resourceName: "hand").withRenderingMode(.alwaysTemplate)
//    let homeSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 55, weight: .heavy)
//    view.image = UIImage(systemName: "hand.point.right.fill", withConfiguration: homeSymbolConfiguration)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let arrowBottom: UIView = {
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
  }()
  
  let arrowUp: UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFit
    view.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    view.image = #imageLiteral(resourceName: "Triangle").withRenderingMode(.alwaysTemplate)
//    let homeSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 30, weight: .heavy)
//    view.image = UIImage(systemName: "arrowtriangle.up.fill", withConfiguration: homeSymbolConfiguration)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  
  let grayedStartBird: UIView = {
    let view = UIView()
    view.accessibilityLabel = "grayedStartBird"
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    view.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 6)

    return view
  }()
  
  let grayedBirdBorder: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    view.layer.borderWidth = 2
    return view
  }()
  
  let grayedBirdEye: UIView = {
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    view.layer.borderWidth = 2
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let grayedBirdSmallerEye: UIView = {
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let grayedBirdWing: UIView = {
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    view.layer.borderWidth = 2
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let grayedBirdMouth: UIView = {
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 0.3279068845, green: 0.2628149137, blue: 0.2719131131, alpha: 1)
    view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    view.layer.borderWidth = 2
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let obstacleTop: [UIView] = {
    let views = [UIView(), UIView()]
    for view in views {
      view.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
      view.layer.masksToBounds = true
    }
    return views
  }()

  let obstacleBottom: [UIView] = {
    let views = [UIView(), UIView()]
    for view in views {
      view.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
      view.layer.masksToBounds = true
    }
    return views
  }()

  let obstacleTipTop: [UIView] = {
    let views = [UIView(), UIView()]
    for view in views {
      view.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
      view.layer.masksToBounds = true
    }
    return views
  }()

  let obstacleTipBottom: [UIView] = {
    let views = [UIView(), UIView()]
    for view in views {
      view.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
      view.layer.masksToBounds = true
    }
    return views
  }()

  let scoreBox: [UIView] = {
    let views = [UIView(), UIView()]
    for view in views {
      view.layer.masksToBounds = true
    }
    return views
  }()

  let colliders: [UIView] = {
    let views = [UIView(), UIView(), UIView(), UIView(), UIView(), UIView(), UIView(), UIView()]
    for view in views {
      view.accessibilityLabel = "Debug collider"
      //view.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
      view.frame.size = CGSize(width: 3, height: 3)
    }
    return views
  }()

  var initialGround: StripedView!
  var groundTop: [StripedView]!

  let groundBottom: UIView = {
    let view = UIView()
    view.accessibilityLabel = "groundBottom"
    view.backgroundColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
    return view
  }()

  let topCollider: UIView = {
    let view = UIView()
    view.accessibilityLabel = "TopBlackCollider"
    view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    return view
  }()

  let bottomCollider: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    return view
  }()

  var obstacleResetNumber = 0
  var groundResetNumber = 0
  var scoreIncrementOnCooldown = false
  var animatedInitialGround = false
  
  var startPos: CGPoint!
  var endPos: CGPoint!

  var scoreCount = 0
  var distanceBetwenPipes: CGFloat!

  let tappableArea: UIView = {
    let view = UIView()
    view.accessibilityLabel = "Tappable Area"
    return view
  }()

  var gravityBehavior: UIGravityBehavior!
  var animator: UIDynamicAnimator!
  var collisionBehavior: UICollisionBehavior!
  var pushBeavior: UIPushBehavior!
  var birdBehavior: UIDynamicItemBehavior!

  var pipesTimer: Timer!
  var groundTimer: Timer!
  var timeBetweenTubes: TimeInterval = 1.5

  var groundHeight: CGFloat!

  let score: UILabel = {
    let label = UILabel()
    label.accessibilityLabel = "Score"
    label.layer.shadowRadius = 3.0
    label.layer.shadowOpacity = 1
    label.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    label.layer.shadowOffset = CGSize(width: 5, height: 5)
    label.sizeToFit()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .flappyJune100
    label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    label.textAlignment = .center
    return label
  }()

  var colliderPoints: [CGPoint]!

  var isAnimatingHit = false
  
  let startView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let getReadyLabel: UILabel = {
    let label = UILabel()
    label.text = "Get Ready!"
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .flappyJune60
    label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    label.textAlignment = .center
    return label
  }()
  let tapLeft: PaddingLabel = {
    let label = PaddingLabel(topInset: 0, bottomInset: 0, leftInset: 0, rightInset: 0)
    label.text = "TAP"
    label.numberOfLines = 0
    label.sizeToFit()
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .flappyOpi40
    label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    label.layer.borderWidth = 3
    label.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    label.layer.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
    label.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    return label
  }()
  
  let tapRight: PaddingLabel = {
    let label = PaddingLabel(topInset: 0, bottomInset: 0, leftInset: 0, rightInset: 0)
    label.text = "TAP"
    label.numberOfLines = 0
    label.sizeToFit()
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .flappyOpi40
    label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    label.layer.borderWidth = 3
    label.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    label.layer.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
    label.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    return label
  }()
  
  let gameOverLabel: UILabel = {
    let label = UILabel()
    label.text = "Game Over"
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .flappyJune60
    label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    label.textAlignment = .center
    label.sizeToFit()
    label.alpha = 0
    return label
  }()
  
  let gameoverView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.alpha = 0
    view.layer.masksToBounds = true
    return view
  }()
  
  let playAgainButton: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.isUserInteractionEnabled = true
    view.layer.masksToBounds = true
    view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    view.alpha = 0
    return view
  }()
  
  let medalLabel: UILabel = {
    let label = UILabel()
    label.text = "MEDAL"
    label.sizeToFit()
    label.numberOfLines = 0
    label.textAlignment = .left
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .flappyOpi20
    label.textColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
    return label
  }()
  
  let scoreLabel: UILabel = {
    let label = UILabel()
    label.text = "SCORE"
    label.sizeToFit()
    label.numberOfLines = 0
    label.textAlignment = .right
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .flappyOpi20
    label.textColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
    return label
  }()
  
  let scoreCountLabel: UILabel = {
    let label = UILabel()
    label.text = "888"
    label.sizeToFit()
    label.numberOfLines = 0
    label.textAlignment = .right
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .flappyJune40
    label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    return label
  }()
  
  let bestLabel: UILabel = {
    let label = UILabel()
    label.text = "BEST"
    label.sizeToFit()
    label.numberOfLines = 0
    label.textAlignment = .right
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .flappyOpi20
    label.textColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
    return label
  }()
  
  let bestCountLabel: UILabel = {
    let label = UILabel()
    label.text = "999"
    label.sizeToFit()
    label.numberOfLines = 0
    label.textAlignment = .right
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .flappyJune40
    label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    return label
  }()
  
  let playButtonImage: UIImageView = {
    let view = UIImageView()
    view.isUserInteractionEnabled = true
    view.contentMode = .scaleAspectFit
    view.tintColor = #colorLiteral(red: 0.2688185086, green: 0.7338396256, blue: 0.2862071538, alpha: 1)
    view.image = #imageLiteral(resourceName: "Triangle").withRenderingMode(.alwaysTemplate)
//    let homeSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 60, weight: .heavy)
//    view.image = UIImage(systemName: "arrowtriangle.up.fill", withConfiguration: homeSymbolConfiguration)
    view.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let trippleDash: TrippleDashView = {
    let dash = TrippleDashView()
    return dash
  }()
  
  var gameState: GameState = .start
  
  enum GameState: Int {
    case start, playing, fallingBird, lost
  }
  
  var gameOverConstraint: NSLayoutConstraint!
  var gameoverViewConstraint: NSLayoutConstraint!
  var playAgainButtonConstraint: NSLayoutConstraint!
  
  var medal = Medal()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    displayLink = CADisplayLink(
      target: self,
      selector: #selector(updateBirdRotation)
    )
    displayLink.add(to: .main, forMode: .default)

    let coinSoundURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: "sfx_point", ofType: "wav")!)
    AudioServicesCreateSystemSoundID(coinSoundURL, &self.scoreSound)
    
    let wingFlapSoundURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: "sfx_wing", ofType: "wav")!)
    AudioServicesCreateSystemSoundID(wingFlapSoundURL, &self.wingFlapSound)
    
    let hitObstacleSoundURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: "sfx_hit", ofType: "wav")!)
    AudioServicesCreateSystemSoundID(hitObstacleSoundURL, &self.hitObstacleSound)
    
//    for family: String in UIFont.familyNames
//    {
//      print(family)
//      for names: String in UIFont.fontNames(forFamilyName: family)
//      {
//        print("== \(names)")
//      }
//    }
    
    addBirdAnimation()
    
    tapLeft.layer.cornerRadius = relativeHeight(25)
    tapLeft.topInset = relativeHeight(9)
    tapLeft.leftInset = -relativeHeight(15)
    tapRight.layer.cornerRadius = relativeHeight(25)
    tapRight.topInset = relativeHeight(9)
    tapRight.rightInset = -relativeHeight(15)
    
    view.setVerticalGradient(startColor: .darkBlue, endColor: .lightDarkBlue)
    groundHeight = relativeHeight(120)

    view.addSubview(topCollider)
    topCollider.frame = CGRect(x: 0, y: 0, width: currentWindowSize.width, height: self.navigationController?.navigationBar.frame.size.height ?? relativeHeight(10))

    distanceBetwenPipes = relativeHeight(250)
    startPos = CGPoint(x: currentWindowSize.width + 50, y: currentWindowSize.height / 2)

    setupPipes()

    view.addSubview(bird)
    bird.addSubview(birdBorder)
    birdBorder.accessibilityLabel = "birdBorder"
    bird.addSubview(birdMouth)
    birdMouth.accessibilityLabel = "birdMouth"
    bird.addSubview(birdEye)
    birdEye.accessibilityLabel = "birdEye"
    bird.addSubview(birdSmallerEye)
    birdSmallerEye.accessibilityLabel = "birdEye"
    bird.addSubview(birdWing)
    birdWing.accessibilityLabel = "birdWing"
    UIView.animate(withDuration: 0.2, delay: 0, options: [.repeat, .autoreverse], animations: {
      self.birdWing.center = CGPoint(x: self.birdWing.center.x, y: self.birdWing.center.y + self.relativeHeight(6))
      self.birdWing.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 10)
    })
    
    bird.layer.cornerRadius = relativeWidth(18)
    birdEye.layer.cornerRadius = relativeWidth(7)
    birdSmallerEye.layer.cornerRadius = relativeWidth(2)
    birdBorder.layer.cornerRadius = relativeWidth(18)
    birdWing.layer.cornerRadius = relativeWidth(10)
    birdMouth.layer.cornerRadius = relativeWidth(7)
    
    resetBird()
    
    grayedStartBird.layer.cornerRadius = relativeWidth(18)

    view.addSubview(groundBottom)
    

    groundTop = [StripedView(lineGap: currentWindowSize.width / 17, lineWidth: currentWindowSize.width / 17, lineColor: #colorLiteral(red: 0.1537564443, green: 0.2859660553, blue: 0.005481044434, alpha: 1)),
                 StripedView(lineGap: currentWindowSize.width / 17, lineWidth: currentWindowSize.width / 17, lineColor: #colorLiteral(red: 0.1537564443, green: 0.2859660553, blue: 0.005481044434, alpha: 1))]
    initialGround = StripedView(lineGap: currentWindowSize.width / 17, lineWidth: currentWindowSize.width / 17, lineColor: #colorLiteral(red: 0.1537564443, green: 0.2859660553, blue: 0.005481044434, alpha: 1))
    
    groundTop[0].backgroundColor = #colorLiteral(red: 0.2688368801, green: 0.5, blue: 0.009583382943, alpha: 1)
    groundTop[1].backgroundColor = #colorLiteral(red: 0.2688368801, green: 0.5, blue: 0.009583382943, alpha: 1)
    initialGround.backgroundColor = #colorLiteral(red: 0.2688368801, green: 0.5, blue: 0.009583382943, alpha: 1)
    
    view.addSubview(groundTop[0])
    view.addSubview(groundTop[1])
    view.addSubview(initialGround)
    
    groundTop[0].addTopBorder(with: .black, andWidth: 4)
    groundTop[0].addBottomBorder(with: .black, andWidth: 4)
    groundTop[1].addTopBorder(with: .black, andWidth: 4)
    groundTop[1].addBottomBorder(with: .black, andWidth: 4)
    initialGround.addTopBorder(with: .black, andWidth: 4)
    initialGround.addBottomBorder(with: .black, andWidth: 4)
    
    groundTop[0].frame = CGRect(origin: CGPoint(x: currentWindowSize.width + relativeWidth(2), y: currentWindowSize.height - groundHeight - relativeHeight(25) / 2), size: CGSize(width: currentWindowSize.width, height: relativeHeight(25)))
    groundTop[1].frame = CGRect(origin: CGPoint(x: currentWindowSize.width + relativeWidth(2), y: currentWindowSize.height - groundHeight - relativeHeight(25) / 2), size: CGSize(width: currentWindowSize.width, height: relativeHeight(25)))
    
    initialGround.frame = CGRect(origin: CGPoint(x: 0, y: currentWindowSize.height - groundHeight - relativeHeight(25) / 2), size: CGSize(width: currentWindowSize.width, height: relativeHeight(25)))
    
    groundBottom.frame = CGRect(origin: CGPoint(x: -5, y: currentWindowSize.height - groundHeight), size: CGSize(width: currentWindowSize.width + 10, height: groundHeight))
    
    animator = UIDynamicAnimator(referenceView: self.view)

    gravityBehavior = UIGravityBehavior(items: [])
    gravityBehavior.magnitude = 2.9

    animator.addBehavior(gravityBehavior)

    collisionBehavior = UICollisionBehavior(items: [bird, topCollider])
    //collisionBehavior.translatesReferenceBoundsIntoBoundary = true

    let mapColliderBehavior = UIDynamicItemBehavior(items: [topCollider])
    mapColliderBehavior.isAnchored = true
    animator.addBehavior(mapColliderBehavior)

    birdBehavior = UIDynamicItemBehavior(items: [bird])
    birdBehavior.allowsRotation = false
    animator.addBehavior(birdBehavior)
    
    collisionBehavior.collisionDelegate = self

    colliderPoints = [CGPoint](repeating: .zero, count: 8)

    for col in colliders {
      view.addSubview(col)
    }

    collisionBehavior.action = {
      self.refreshColliderPoints()

      for i in (0..<self.colliders.count) {
        self.colliders[i].center = self.colliderPoints[i]
      }

      if let frame = self.initialGround.layer.presentation()?.frame {
        for point in self.colliderPoints {
          if frame.contains(point) {
            self.stopEverythingExceptBird()
            self.removeBirdGravity()
            self.loseGame()
          }
        }
      }
      
      for i in (0..<self.obstacleTop.count) {
        if let frame = self.obstacleTop[i].layer.presentation()?.frame {
          for point in self.colliderPoints {
            if frame.contains(point) {
              self.stopEverythingExceptBird()
            }
          }
        }
        if let frame = self.obstacleBottom[i].layer.presentation()?.frame {
          for point in self.colliderPoints {
            if frame.contains(point) {
              self.stopEverythingExceptBird()
            }
          }
        }
        if let frame = self.obstacleTipTop[i].layer.presentation()?.frame {
          for point in self.colliderPoints {
            if frame.contains(point) {
              self.stopEverythingExceptBird()
            }
          }
        }
        if let frame = self.obstacleTipBottom[i].layer.presentation()?.frame {
          for point in self.colliderPoints {
            if frame.contains(point) {
              self.stopEverythingExceptBird()
            }
          }
        }
        if let frame = self.groundTop[i].layer.presentation()?.frame {
          for point in self.colliderPoints {
            if frame.contains(point) {
              self.stopEverythingExceptBird()
              self.removeBirdGravity()
              self.loseGame()
            }
          }
        }
        if let frame = self.scoreBox[i].layer.presentation()?.frame {
          for point in self.colliderPoints {
            if frame.contains(point) && !self.scoreIncrementOnCooldown {
              self.scoreIncrementOnCooldown = true
              self.scoreCount += 1
              
              self.scoreBox[i].setTripleHorizontalGradient(startColor: #colorLiteral(red: 0.01148293132, green: 1, blue: 0.07333269911, alpha: 1).withAlphaComponent(0), middleColor: #colorLiteral(red: 0.01148293132, green: 1, blue: 0.07333269911, alpha: 1).withAlphaComponent(0.15), endColor: #colorLiteral(red: 0.01148293132, green: 1, blue: 0.07333269911, alpha: 1).withAlphaComponent(0))
              
              self.score.text = "\(self.scoreCount)"
              AudioServicesPlaySystemSound(self.scoreSound)
              DispatchQueue.main.asyncAfter(deadline: .now() + 1) { self.scoreIncrementOnCooldown = false
              }
            }
          }
        }
      }

      //Limit maximum and minimum velocity of bird
      let velocity = self.birdBehavior.linearVelocity(for: self.bird)
      if abs(velocity.y) > 1 {
        if velocity.y > 1000 {
          self.birdBehavior.addLinearVelocity(CGPoint(x: 0, y: -(velocity.y - 1000)), for: self.bird)
        } else if velocity.y < -750 {
          self.birdBehavior.addLinearVelocity(CGPoint(x: 0, y: -(velocity.y + 750)), for: self.bird)
        }
      }
    }

    view.addSubview(score)
    score.text = "\(scoreCount)"
    
    view.addSubview(startView)
    startView.addSubview(getReadyLabel)
    startView.addSubview(tapLeft)
    startView.addSubview(tapRight)
    startView.addSubview(handIconImage)
    startView.addSubview(trippleDash)
    startView.addSubview(arrowBottom)
    arrowBottom.layer.cornerRadius = relativeWidth(5)
    startView.addSubview(arrowUp)
    startView.addSubview(grayedStartBird)
    grayedStartBird.addSubview(grayedBirdBorder)
    grayedBirdBorder.accessibilityLabel = "grayedBirdBorder"
    grayedStartBird.addSubview(grayedBirdMouth)
    grayedBirdMouth.accessibilityLabel = "grayedBirdMouth"
    grayedStartBird.addSubview(grayedBirdEye)
    grayedBirdEye.accessibilityLabel = "grayedBirdEye"
    grayedStartBird.addSubview(grayedBirdSmallerEye)
    grayedBirdSmallerEye.accessibilityLabel = "grayedBirdSmallerEye"
    grayedStartBird.addSubview(grayedBirdWing)
    grayedBirdWing.accessibilityLabel = "grayedBirdWing"
    
    grayedBirdEye.layer.cornerRadius = relativeWidth(7)
    grayedBirdSmallerEye.layer.cornerRadius = relativeWidth(2)
    grayedBirdBorder.layer.cornerRadius = relativeWidth(18)
    grayedBirdWing.layer.cornerRadius = relativeWidth(10)
    grayedBirdMouth.layer.cornerRadius = relativeWidth(7)
    
    view.addSubview(gameoverView)
    gameoverView.addSubview(scoreLabel)
    gameoverView.addSubview(scoreCountLabel)
    gameoverView.addSubview(bestLabel)
    gameoverView.addSubview(bestCountLabel)
    gameoverView.addSubview(medalLabel)
    gameoverView.addSubview(medal)
    
    view.addSubview(playAgainButton)
    view.addSubview(gameOverLabel)
    gameoverView.layer.cornerRadius = relativeHeight(40)
    gameoverView.layer.borderWidth = relativeHeight(5)
    gameoverView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [#colorLiteral(red: 0.8730967641, green: 0.8490568399, blue: 0.58326298, alpha: 1).cgColor, #colorLiteral(red: 0.6423900699, green: 0.6245977393, blue: 0.434462587, alpha: 1).cgColor]
    gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
    gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
    gradientLayer.locations = [NSNumber(floatLiteral: 0.0), NSNumber(floatLiteral: 1.0)]
    gradientLayer.frame = CGRect(origin: .zero, size: CGSize(width: relativeHeight(350), height: relativeHeight(250)))
    gameoverView.layer.insertSublayer(gradientLayer, at: 0)
    
    playAgainButton.layer.cornerRadius = relativeHeight(50)
    playAgainButton.layer.borderWidth = relativeHeight(5)
    playAgainButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    let playAgainButtonGadientLayer = CAGradientLayer()
    playAgainButtonGadientLayer.colors = [#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor, #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1).cgColor]
    playAgainButtonGadientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
    playAgainButtonGadientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
    playAgainButtonGadientLayer.locations = [NSNumber(floatLiteral: 0.0), NSNumber(floatLiteral: 1.0)]
    playAgainButtonGadientLayer.frame = CGRect(origin: .zero, size: CGSize(width: relativeWidth(200), height: relativeHeight(100)))
    playAgainButton.layer.insertSublayer(playAgainButtonGadientLayer, at: 0)
    
    playAgainButton.addSubview(playButtonImage)
    
    playAgainButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(resetGame)))
    playButtonImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(resetGame)))

    animator.addBehavior(collisionBehavior)

    tappableArea.pin(into: view, safeMargin: false)
    tappableArea.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goUp)))
    
    groundTimer = Timer.scheduledTimer(withTimeInterval: 0.8 * timeBetweenTubes * 2, repeats: true, block: {_ in
      self.resetGround()
    })
    
    setupLayouts()
  }
  
  @objc func updateBirdRotation(displaylink: CADisplayLink) {
    let velocityY = self.birdBehavior.linearVelocity(for: self.bird).y
    let angularVelocity = self.birdBehavior.angularVelocity(for: bird)
    let currentRotation = atan2f(Float(bird.transform.b), Float(bird.transform.a))
    
    if velocityY > 0 && CGFloat(currentRotation) < maxBirdAngle {
      self.birdBehavior.addAngularVelocity(-angularVelocity + 4, for: bird)
    } else if velocityY < 0  && CGFloat(currentRotation) > minBirdAngle{
      self.birdBehavior.addAngularVelocity(-angularVelocity - 5, for: bird)
    } else {
      self.birdBehavior.addAngularVelocity(-angularVelocity, for: bird)
    }
  }
  
  func stopEverythingExceptBird() {
    if gameState == .playing {
      AudioServicesPlaySystemSound(self.hitObstacleSound)
      gameState = .fallingBird
      pipesTimer.invalidate()
      groundTimer.invalidate()
      stopPipesAnimation()
      stopGroundAnimation()
      tappableArea.isUserInteractionEnabled = false
      
      self.scoreCountLabel.text = "\(scoreCount)"
      let oldHighScore = highScore
      
      if highScore < scoreCount {
        highScore = scoreCount
      }
      bestCountLabel.text = "\(highScore)"
      
      medal.calculateMedalColor(highscore: CGFloat(oldHighScore), currentScore: CGFloat(scoreCount))
      
      UserDefaults.standard.integer(forKey: "highScore")
      gameOverConstraint.constant = -self.relativeHeight(200)
      UIView.animate(withDuration: 0.6, animations: {
        self.view.layoutIfNeeded()
      })
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
        self.gameoverViewConstraint.constant = -self.relativeHeight(130)
        UIView.animate(withDuration: 0.6, animations: {
          self.view.layoutIfNeeded()
        })
      }
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
        self.playAgainButtonConstraint.constant = self.relativeHeight(80)
        UIView.animate(withDuration: 0.6, animations: {
          self.view.layoutIfNeeded()
        })
      }
    }
  }
  
  func loseGame() {
    if gameState == .fallingBird {
      gameState = .lost
      //showScoreScreen()
      tappableArea.removeFromSuperview()
      score.removeFromSuperview()
      
    }
  }
  
  @objc
  func resetGame() {
    UIView.animate(withDuration: 0.5, animations: {
      self.view.alpha = 0
    })
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      UIApplication.shared.keyWindow?.rootViewController = FlappyBird()
      UIApplication.shared.keyWindow?.makeKeyAndVisible()
    }
  }

  func getDegreeCirclePoint(center: CGPoint, radius: CGFloat, angle: CGFloat) -> CGPoint {
    let x = center.x + radius * cos(angle)
    let y = center.y + radius * sin(angle)
    return CGPoint(x: x, y: y)
  }

  func refreshColliderPoints() {
    self.colliderPoints[0] = CGPoint(x: self.bird.center.x - self.relativeWidth(20), y: self.bird.center.y)
    self.colliderPoints[1] = CGPoint(x: self.bird.center.x + self.relativeWidth(20), y: self.bird.center.y)
    self.colliderPoints[2] = CGPoint(x: self.bird.center.x, y: self.bird.center.y - self.relativeWidth(18))
    self.colliderPoints[3] = CGPoint(x: self.bird.center.x, y: self.bird.center.y + self.relativeWidth(18))
    self.colliderPoints[4] = getDegreeCirclePoint(center: self.bird.center, radius: self.relativeWidth(18), angle: CGFloat.pi / 4)
    self.colliderPoints[5] = getDegreeCirclePoint(center: self.bird.center, radius: self.relativeWidth(18), angle: 3 * CGFloat.pi / 4)
    self.colliderPoints[6] = getDegreeCirclePoint(center: self.bird.center, radius: self.relativeWidth(18), angle: 5 * CGFloat.pi / 4)
    self.colliderPoints[7] = getDegreeCirclePoint(center: self.bird.center, radius: self.relativeWidth(18), angle: 7 * CGFloat.pi / 4)
  }

  func setupLayouts() {
    
    gameOverConstraint = NSLayoutConstraint(item: gameOverLabel, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: -currentWindowSize.height / 2)
    gameoverViewConstraint = NSLayoutConstraint(item: gameoverView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: currentWindowSize.height / 2)
    playAgainButtonConstraint = NSLayoutConstraint(item: playAgainButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: currentWindowSize.height / 2)
    
    gameOverLabel.alpha = 1
    gameoverView.alpha = 1
    playAgainButton.alpha = 1
    
    NSLayoutConstraint.activate([
      score.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: relativeHeight(40)),
      score.widthAnchor.constraint(equalTo: view.widthAnchor),
      score.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      startView.widthAnchor.constraint(equalToConstant: relativeWidth(350)),
      startView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      startView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      startView.heightAnchor.constraint(equalToConstant: relativeHeight(500)),
      
      gameoverViewConstraint,
      gameoverView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      gameoverView.widthAnchor.constraint(equalToConstant: relativeWidth(350)),
      gameoverView.heightAnchor.constraint(equalToConstant: relativeHeight(250)),
      
      scoreLabel.trailingAnchor.constraint(equalTo: gameoverView.trailingAnchor, constant: -relativeWidth(30)),
      scoreLabel.topAnchor.constraint(equalTo: gameoverView.topAnchor, constant: relativeHeight(200) / 10),
      scoreLabel.heightAnchor.constraint(equalToConstant: relativeHeight(200) / 10),
      
      scoreCountLabel.trailingAnchor.constraint(equalTo: gameoverView.trailingAnchor, constant: -relativeWidth(30)),
      scoreCountLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: relativeHeight(200) / 20),
      scoreCountLabel.heightAnchor.constraint(equalToConstant: relativeHeight(200) / 5),
      
      bestLabel.trailingAnchor.constraint(equalTo: gameoverView.trailingAnchor, constant: -relativeWidth(30)),
      bestLabel.topAnchor.constraint(equalTo: scoreCountLabel.bottomAnchor, constant: relativeHeight(200) / 10),
      bestLabel.heightAnchor.constraint(equalToConstant: relativeHeight(200) / 10),
      
      bestCountLabel.trailingAnchor.constraint(equalTo: gameoverView.trailingAnchor, constant: -relativeWidth(30)),
      bestCountLabel.topAnchor.constraint(equalTo: bestLabel.bottomAnchor, constant: relativeHeight(200) / 20),
      bestCountLabel.heightAnchor.constraint(equalToConstant: relativeHeight(200) / 5),

      medalLabel.leadingAnchor.constraint(equalTo: gameoverView.leadingAnchor, constant: relativeWidth(25)),
      medalLabel.topAnchor.constraint(equalTo: gameoverView.topAnchor, constant: relativeHeight(200) / 10),
      medalLabel.heightAnchor.constraint(equalToConstant: relativeHeight(200) / 10),
      
      medal.leadingAnchor.constraint(equalTo: gameoverView.leadingAnchor, constant: relativeWidth(45)),
      medal.topAnchor.constraint(equalTo: medalLabel.topAnchor, constant: relativeHeight(45)),
      medal.widthAnchor.constraint(equalToConstant: relativeWidth(120)),
      medal.heightAnchor.constraint(equalToConstant: relativeWidth(120)),
      
      gameOverLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      gameOverConstraint,
      gameOverLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
      
      playAgainButton.widthAnchor.constraint(equalToConstant: relativeWidth(200)),
      playAgainButton.heightAnchor.constraint(equalToConstant: relativeHeight(100)),
      playAgainButtonConstraint,
      playAgainButton.centerXAnchor.constraint(equalTo: gameoverView.centerXAnchor),
      
      playButtonImage.centerYAnchor.constraint(equalTo: playAgainButton.centerYAnchor),
      playButtonImage.centerXAnchor.constraint(equalTo: playAgainButton.centerXAnchor),
      playButtonImage.widthAnchor.constraint(equalToConstant: relativeWidth(60)),
      playButtonImage.heightAnchor.constraint(equalToConstant: relativeWidth(60)),
      
      getReadyLabel.centerXAnchor.constraint(equalTo: startView.centerXAnchor),
      getReadyLabel.topAnchor.constraint(equalTo: startView.topAnchor, constant: relativeHeight(50)),
      getReadyLabel.heightAnchor.constraint(equalToConstant: relativeHeight(80)),
      
      tapLeft.trailingAnchor.constraint(equalTo: startView.centerXAnchor, constant: relativeWidth(-relativeWidth(30))),
      tapLeft.topAnchor.constraint(equalTo: getReadyLabel.bottomAnchor, constant: relativeHeight(200)),
      tapLeft.widthAnchor.constraint(equalToConstant: relativeWidth(100)),
      tapLeft.heightAnchor.constraint(equalToConstant: relativeWidth(40)),
      
      tapRight.leadingAnchor.constraint(equalTo: startView.centerXAnchor, constant: relativeWidth(relativeWidth(30))),
      tapRight.topAnchor.constraint(equalTo: getReadyLabel.bottomAnchor, constant: relativeHeight(200)),
      tapRight.widthAnchor.constraint(equalToConstant: relativeWidth(100)),
      tapRight.heightAnchor.constraint(equalToConstant: relativeWidth(40)),
      
      handIconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: relativeWidth(4)),
      handIconImage.centerYAnchor.constraint(equalTo: getReadyLabel.bottomAnchor, constant: relativeHeight(250)),
      handIconImage.widthAnchor.constraint(equalToConstant: relativeWidth(50)),
      handIconImage.heightAnchor.constraint(equalToConstant: relativeWidth(50)),
      
      trippleDash.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      trippleDash.centerYAnchor.constraint(equalTo: getReadyLabel.bottomAnchor, constant: relativeHeight(205)),
      trippleDash.widthAnchor.constraint(equalToConstant: relativeWidth(50)),
      trippleDash.heightAnchor.constraint(equalToConstant: relativeWidth(30)),
      
      arrowBottom.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      arrowBottom.topAnchor.constraint(equalTo: arrowUp.bottomAnchor, constant: relativeWidth(-10)),
      arrowBottom.widthAnchor.constraint(equalToConstant: relativeWidth(10)),
      arrowBottom.heightAnchor.constraint(equalToConstant: relativeHeight(20)),
      
      arrowUp.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      arrowUp.centerYAnchor.constraint(equalTo: getReadyLabel.bottomAnchor, constant: relativeHeight(140)),
      arrowUp.widthAnchor.constraint(equalToConstant: relativeWidth(30)),
      arrowUp.heightAnchor.constraint(equalToConstant: relativeWidth(30)),

      grayedStartBird.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      grayedStartBird.centerYAnchor.constraint(equalTo: getReadyLabel.bottomAnchor, constant: relativeHeight(70)),
      grayedStartBird.widthAnchor.constraint(equalToConstant: relativeWidth(40)),
      grayedStartBird.heightAnchor.constraint(equalToConstant: relativeWidth(36)),
      
      birdBorder.centerXAnchor.constraint(equalTo: bird.centerXAnchor),
      birdBorder.centerYAnchor.constraint(equalTo: bird.centerYAnchor),
      birdBorder.widthAnchor.constraint(equalToConstant: relativeWidth(40)),
      birdBorder.heightAnchor.constraint(equalToConstant: relativeWidth(36)),
      
      birdEye.centerYAnchor.constraint(equalTo: bird.centerYAnchor, constant: -relativeWidth(5)),
      birdEye.trailingAnchor.constraint(equalTo: bird.trailingAnchor, constant: relativeWidth(2)),
      birdEye.widthAnchor.constraint(equalToConstant: relativeWidth(14)),
      birdEye.heightAnchor.constraint(equalToConstant: relativeWidth(14)),
      
      birdSmallerEye.centerXAnchor.constraint(equalTo: birdEye.centerXAnchor, constant: relativeWidth(2)),
      birdSmallerEye.centerYAnchor.constraint(equalTo: birdEye.centerYAnchor, constant: relativeWidth(1)),
      birdSmallerEye.widthAnchor.constraint(equalToConstant: relativeWidth(4)),
      birdSmallerEye.heightAnchor.constraint(equalToConstant: relativeWidth(4)),
      
      birdWing.centerYAnchor.constraint(equalTo: bird.centerYAnchor, constant: relativeWidth(5)),
      birdWing.trailingAnchor.constraint(equalTo: bird.leadingAnchor, constant: relativeWidth(20)),
      birdWing.widthAnchor.constraint(equalToConstant: relativeWidth(25)),
      birdWing.heightAnchor.constraint(equalToConstant: relativeWidth(15)),
      
      birdMouth.centerYAnchor.constraint(equalTo: bird.centerYAnchor, constant: relativeWidth(5)),
      birdMouth.trailingAnchor.constraint(equalTo: bird.trailingAnchor, constant: relativeWidth(6)),
      birdMouth.widthAnchor.constraint(equalToConstant: relativeWidth(18)),
      birdMouth.heightAnchor.constraint(equalToConstant: relativeWidth(10)),
      
      grayedBirdBorder.centerXAnchor.constraint(equalTo: grayedStartBird.centerXAnchor),
      grayedBirdBorder.centerYAnchor.constraint(equalTo: grayedStartBird.centerYAnchor),
      grayedBirdBorder.widthAnchor.constraint(equalToConstant: relativeWidth(40)),
      grayedBirdBorder.heightAnchor.constraint(equalToConstant: relativeWidth(36)),
      
      grayedBirdEye.centerYAnchor.constraint(equalTo: grayedStartBird.centerYAnchor, constant: -relativeWidth(5)),
      grayedBirdEye.trailingAnchor.constraint(equalTo: grayedStartBird.trailingAnchor, constant: relativeWidth(2)),
      grayedBirdEye.widthAnchor.constraint(equalToConstant: relativeWidth(14)),
      grayedBirdEye.heightAnchor.constraint(equalToConstant: relativeWidth(14)),
      
      grayedBirdSmallerEye.centerXAnchor.constraint(equalTo: grayedBirdEye.centerXAnchor, constant: relativeWidth(2)),
      grayedBirdSmallerEye.centerYAnchor.constraint(equalTo: grayedBirdEye.centerYAnchor, constant: relativeWidth(1)),
      grayedBirdSmallerEye.widthAnchor.constraint(equalToConstant: relativeWidth(4)),
      grayedBirdSmallerEye.heightAnchor.constraint(equalToConstant: relativeWidth(4)),
      
      grayedBirdWing.centerYAnchor.constraint(equalTo: grayedStartBird.centerYAnchor, constant: relativeWidth(5)),
      grayedBirdWing.trailingAnchor.constraint(equalTo: grayedStartBird.leadingAnchor, constant: relativeWidth(20)),
      grayedBirdWing.widthAnchor.constraint(equalToConstant: relativeWidth(25)),
      grayedBirdWing.heightAnchor.constraint(equalToConstant: relativeWidth(15)),
      
      grayedBirdMouth.centerYAnchor.constraint(equalTo: grayedStartBird.centerYAnchor, constant: relativeWidth(5)),
      grayedBirdMouth.trailingAnchor.constraint(equalTo: grayedStartBird.trailingAnchor, constant: relativeWidth(6)),
      grayedBirdMouth.widthAnchor.constraint(equalToConstant: relativeWidth(18)),
      grayedBirdMouth.heightAnchor.constraint(equalToConstant: relativeWidth(10))
      ])
  }

  func animateInitialGround() {
    if view.subviews.contains(initialGround) {
      UIView.animate(withDuration: 0.8 * timeBetweenTubes * TimeInterval(groundTop.count) * 2, delay: 0, options: [.curveLinear], animations: {
        self.view.layoutIfNeeded()
        
        self.initialGround.center = CGPoint(x: -self.currentWindowSize.width * 0.5 - self.currentWindowSize.width, y: self.initialGround.center.y)
      }, completion: { _ in
      })
    }
  }
  
  func resetGround() {
    if !animatedInitialGround {
      animatedInitialGround = true
      animateInitialGround()
    }
    self.groundTop[groundResetNumber].center = CGPoint(x: currentWindowSize.width * 1.5, y: self.groundTop[groundResetNumber].center.y)
    
    UIView.animate(withDuration: 0.8 * timeBetweenTubes * TimeInterval(groundTop.count) * 2, delay: 0, options: [.curveLinear], animations: {
      self.view.layoutIfNeeded()
      
      self.groundTop[self.groundResetNumber].center = CGPoint(x: -self.currentWindowSize.width * 0.5, y: self.groundTop[self.groundResetNumber].center.y)
    })
    groundResetNumber += 1
    if groundResetNumber >= groundTop.count {
      groundResetNumber = 0
    }
  }
  
  func resetObstacle() {

    //print("resetting position!!! and animating again")
    let positionY = CGFloat.random(in: (relativeHeight(150)...currentWindowSize.height - relativeHeight(150) - groundHeight))

    startPos = CGPoint(x: startPos.x, y: positionY)
    endPos = CGPoint(x: -50, y: positionY)
    setPos(from: startPos, index: obstacleResetNumber)

    UIView.animate(withDuration: timeBetweenTubes * TimeInterval(obstacleTop.count), delay: 0, options: [.curveLinear], animations: {
      self.view.layoutIfNeeded()
      self.setPos(from: self.endPos, index: self.obstacleResetNumber)
    })

    obstacleResetNumber += 1
    if obstacleResetNumber >= obstacleTop.count {
      obstacleResetNumber = 0
    }
  }

  func setupPipes() {
    for i in (0..<obstacleTop.count) {
      view.addSubview(obstacleTop[i])
      obstacleTop[i].accessibilityLabel = "obstacleTop\(i)"
      view.addSubview(obstacleBottom[i])
      obstacleBottom[i].accessibilityLabel = "obstacleBottom\(i)"
      view.addSubview(obstacleTipTop[i])
      obstacleTipTop[i].accessibilityLabel = "obstacleTipTop\(i)"
      view.addSubview(obstacleTipBottom[i])
      obstacleTipBottom[i].accessibilityLabel = "obstacleTipBottom\(i)"
      view.addSubview(scoreBox[i])
      scoreBox[i].accessibilityLabel = "scoreBox\(i)"
      
      obstacleTipTop[i].layer.cornerRadius = relativeWidth(10)
      obstacleTipBottom[i].layer.cornerRadius = relativeWidth(10)

      obstacleTop[i].layer.borderWidth = relativeWidth(3)
      obstacleBottom[i].layer.borderWidth = relativeWidth(3)
      obstacleTop[i].layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
      obstacleBottom[i].layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

      obstacleTipTop[i].layer.borderWidth = relativeWidth(3)
      obstacleTipBottom[i].layer.borderWidth = relativeWidth(3)
      obstacleTipTop[i].layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
      obstacleTipBottom[i].layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

      setPos(from: startPos, index: i)

      
      scoreBox[i].setTripleHorizontalGradient(startColor: #colorLiteral(red: 0.999493897, green: 0.9873333573, blue: 0.3798474073, alpha: 1).withAlphaComponent(0), middleColor: #colorLiteral(red: 0.999493897, green: 0.9873333573, blue: 0.3798474073, alpha: 1).withAlphaComponent(0.05), endColor: #colorLiteral(red: 0.999493897, green: 0.9873333573, blue: 0.3798474073, alpha: 1).withAlphaComponent(0))
      
      obstacleTop[i].setTripleHorizontalGradient(startColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), middleColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), endColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
      obstacleBottom[i].setTripleHorizontalGradient(startColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), middleColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), endColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
      obstacleTipTop[i].setTripleHorizontalGradient(startColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), middleColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), endColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
      obstacleTipBottom[i].setTripleHorizontalGradient(startColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), middleColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), endColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))

    }
  }

  func setPos(from pos: CGPoint, index: Int) {
    
    scoreBox[index].setTripleHorizontalGradient(startColor: #colorLiteral(red: 0.999493897, green: 0.9873333573, blue: 0.3798474073, alpha: 1).withAlphaComponent(0), middleColor: #colorLiteral(red: 0.999493897, green: 0.9873333573, blue: 0.3798474073, alpha: 1).withAlphaComponent(0.05), endColor: #colorLiteral(red: 0.999493897, green: 0.9873333573, blue: 0.3798474073, alpha: 1).withAlphaComponent(0))
    
    obstacleTop[index].frame = CGRect(x: pos.x - relativeWidth(40), y: pos.y - relativeHeight(1500 + distanceBetwenPipes / 2), width: relativeWidth(80), height: relativeHeight(1500))
    obstacleBottom[index].frame = CGRect(x: pos.x - relativeWidth(40), y: pos.y + relativeHeight(distanceBetwenPipes / 2), width: relativeWidth(80), height: relativeHeight(1500))
    obstacleTipTop[index].frame = CGRect(x: pos.x - relativeWidth(45), y: pos.y - relativeHeight(20 + distanceBetwenPipes / 2), width: relativeWidth(90), height: relativeHeight(40))
    obstacleTipBottom[index].frame = CGRect(x: pos.x - relativeWidth(45), y: pos.y + relativeHeight(-20 + distanceBetwenPipes / 2), width: relativeWidth(90), height: relativeHeight(40))
    scoreBox[index].frame = CGRect(x: pos.x - relativeWidth(40), y: pos.y - distanceBetwenPipes / 2 + relativeHeight(20), width: relativeWidth(80), height: distanceBetwenPipes - relativeHeight(40))
  }

  func addBirdAnimation () {
    UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat, .autoreverse], animations: {
      self.bird.center = CGPoint(x: self.bird.center.x, y: self.bird.center.y + self.relativeHeight(8))
    })
  }
  
  func stopBirdAnimation () {
    bird.layer.removeAllAnimations()
  }
  
  func resetPipes() {
    startPos = CGPoint(x: currentWindowSize.width + 50, y: currentWindowSize.height / 2)
    for i in (0..<obstacleTop.count) {
      setPos(from: startPos, index: i)
    }
  }
  
  func resetBird() {
    bird.frame = CGRect(x: currentWindowSize.width / 4 - relativeWidth(20), y: currentWindowSize.height / 2 , width: relativeWidth(40), height: relativeWidth(36))
  }
  
  func activatePipeAnimation() {
    pipesTimer = Timer.scheduledTimer(withTimeInterval: timeBetweenTubes, repeats: true, block: {_ in
      self.resetObstacle()
    })
  }
  
  func stopPipesAnimation() {
    for i in (0..<obstacleTop.count) {
      if let lastTopFrame = obstacleTop[i].layer.presentation()?.frame {
        obstacleTop[i].layer.removeAllAnimations()
        obstacleTop[i].frame = lastTopFrame
      }
      
      if let lastBottomFrame = obstacleBottom[i].layer.presentation()?.frame {
        obstacleBottom[i].layer.removeAllAnimations()
        obstacleBottom[i].frame = lastBottomFrame
      }
      
      
      if let lastTipTopFrame = obstacleTipTop[i].layer.presentation()?.frame {
        obstacleTipTop[i].layer.removeAllAnimations()
        obstacleTipTop[i].frame = lastTipTopFrame
      }
      
      
      if let lastTipBottomFrame = obstacleTipBottom[i].layer.presentation()?.frame {
        obstacleTipBottom[i].layer.removeAllAnimations()
        obstacleTipBottom[i].frame = lastTipBottomFrame
      }
      
      scoreBox[i].layer.removeAllAnimations()
    }
  }
  
  func stopGroundAnimation() {
    if let initialGroundFrame = initialGround.layer.presentation()?.frame {
      initialGround.layer.removeAllAnimations()
      initialGround.frame = initialGroundFrame
    }
    
    for i in (0..<groundTop.count) {
      if let groundTopFrame = groundTop[i].layer.presentation()?.frame {
        groundTop[i].layer.removeAllAnimations()
        groundTop[i].frame = groundTopFrame
      }
    }
  }
  
  func removeStartScreen() {
    //Toggles start screen state
    UIView.animate(withDuration: 0.5, animations: {
      self.startView.alpha =  0
    }, completion: { _ in
      self.startView.removeFromSuperview()
    })
  }
  
  func addBirdGravity() {
    gravityBehavior.addItem(bird)
  }
  func removeBirdGravity() {
    let birdVelocity = birdBehavior.linearVelocity(for: bird)
    birdBehavior.addLinearVelocity(CGPoint(x: -birdVelocity.x, y: -birdVelocity.y), for: bird)
    gravityBehavior.removeItem(bird)
  }
  
  @objc
  func goUp() {
    let birdVelocity = birdBehavior.linearVelocity(for: bird)
    let upVelocity: CGFloat = -700
    birdBehavior.addLinearVelocity(CGPoint(x: 0, y: -birdVelocity.y + upVelocity), for: bird)
    AudioServicesPlaySystemSound(self.wingFlapSound)
    //This is the start of the game!!!
    if gravityBehavior.items.isEmpty {
      gameState = .playing
      stopBirdAnimation()
      removeStartScreen()
      addBirdGravity()
      activatePipeAnimation()
    }
  }
}

extension FlappyBird: UICollisionBehaviorDelegate {
  func collisionBehavior(_ behavior: UICollisionBehavior, endedContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?) {
     resetGame()
  }
}
