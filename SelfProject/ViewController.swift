//
//  ViewController.swift
//  SelfProject
//
//  Created by Track Ensure on 2021-09-23.
//

import UIKit

class ViewController: UIViewController {
  
  var infoContainerView: InfoContainerView!
  
  var infoContainerViews: [InfoContainerView]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    
    //    let path = UIBezierPath() // This would be your custom path
    //
    //    let animation = CAKeyframeAnimation(keyPath: "position")
    //    animation.path = path.cgPath
    //    animation.fillMode = CAMediaTimingFillMode.forwards
    //    animation.isRemovedOnCompletion = false
    //    animation.repeatCount = 0
    //    animation.duration = 5.0 // However long you want
    //    animation.speed = 2  // However fast you want
    //    animation.calculationMode = CAAnimationCalculationMode.paced
    //    animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
    
    //    animatingView.layer.add(animation, forKey: "moveAlongPath")
    
    
    
    
    //    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(moveView(_:)))
    //
    //    let temp = InfoContainerView()
    //    temp.addGestureRecognizer(panGesture)
    //    self.view.addSubview(temp)
    //
    //    temp.translatesAutoresizingMaskIntoConstraints = false
    //    temp.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
    //    temp.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 25).isActive = true
    //    temp.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25).isActive = true
    //    temp.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50).isActive = true
    //
    //    self.infoContainerView = temp
    let colorArray: [UIColor] = [.orange, .red, .green]
    
    for index in 0..<3 {
      let temp = InfoContainerView(viewColor: colorArray[index])
      let panGesture = UIPanGestureRecognizer(target: self, action: #selector(moveView(_:)))
      temp.addGestureRecognizer(panGesture)
      self.view.addSubview(temp)
      
      temp.translatesAutoresizingMaskIntoConstraints = false
      temp.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
      temp.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 25).isActive = true
      temp.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25).isActive = true
      temp.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50).isActive = true
      
      if index == 0 {
        temp.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        self.infoContainerViews = [temp]
      } else if index == 1 {
        temp.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        self.infoContainerViews.append(temp)
      } else {
        self.infoContainerViews.append(temp)
      }
    }
    
  }
  
  @objc func moveView(_ gestureRecognizer: UIPanGestureRecognizer) {
    guard let frontView = gestureRecognizer.view as? InfoContainerView else { return }
    let detectSwipeSide: SwipeSide = (self.view.center.x - frontView.center.x) > 0 ? .left : .right
    let translation = gestureRecognizer.translation(in: self.view)
    tildTheView(with: translation, at: frontView, translationX: translation.x, detectSwipeSide: detectSwipeSide, gestureState: gestureRecognizer.state)
    if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
      
      
      
      // note: 'view' is optional and need to be unwrapped
      gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x + translation.x, y: gestureRecognizer.view!.center.y)
      gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
    } else if gestureRecognizer.state == .ended {
      
      let module = abs(self.view.center.x - frontView.center.x)
      
      if (module / self.view.center.x) < 0.6 {
        print("small angle")
        UIView.animate(withDuration: 0.5, delay: 0, options: []) {
          self.removedViewCancel()
          frontView.transform = .identity
          frontView.center = self.view.center
        }
        
        
      } else {
        print("Need to remove View")
        UIView.animate(withDuration: 0.5) { [unowned self] in
          frontView.center.x = detectSwipeSide == .left ? -frontView.frame.size.width : self.view.frame.size.width + frontView.frame.size.width
          self.scaleToNormal()
        } completion: { isHiden in
          if isHiden {
            print("Could remove from superView")
            let _ = self.infoContainerViews.removeLast()
            frontView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            frontView.transform = .identity
            frontView.center = self.view.center
            self.infoContainerViews.insert(frontView, at: 0)
            
            //            let removedElement = self.infoContainerViews.removeLast()
            //            removedElement.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            //            removedElement.transform = .identity
            //            removedElement.center = self.view.center
            //            self.infoContainerViews.insert(removedElement, at: 0)
            frontView.removeFromSuperview()
            
            self.reloadUI()
          }
        }
      }
    }
  }
  
  func tildTheView(with translationValue: CGPoint, at view: InfoContainerView, translationX: CGFloat, detectSwipeSide: SwipeSide, gestureState: UIGestureRecognizer.State) {
    let translationMoved = self.view.center.x - view.center.x
    let divKoef = (self.view.frame.size.width / 2) / 0.15
    
    view.transform = CGAffineTransform(rotationAngle: -(translationMoved / divKoef))
    
    let nextView = self.infoContainerViews[1]
    var scaling: CGFloat = 0
    if detectSwipeSide == .left {
      if view.center.x < self.view.center.x {
        scaling = translationX < 0 ? abs(-(translationMoved / divKoef)) / 10 : -(translationMoved / divKoef) / 10
      } else {
        
      }
    } else {
      if view.center.x > self.view.center.x {
        scaling = translationX > 0 ? abs(-(translationMoved / divKoef)) / 10 : (translationMoved / divKoef) / 10
        print(scaling)
      } else {
        
      }
    }
    let xScale = nextView.transform.a + scaling
    let yScale = nextView.transform.d + scaling
    
    if xScale <= 1, yScale <= 1 && xScale >= 0.8, yScale >= 0.8 {
      nextView.transform = CGAffineTransform(scaleX: xScale, y: yScale)
    }
  }
  
  private func removedViewCancel() {
    if let currentView = self.infoContainerViews.last {
      currentView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
    }
    
    let previousIndex = self.infoContainerViews.index(before: self.infoContainerViews.endIndex)
    let previousView = self.infoContainerViews[previousIndex-1]
    
    previousView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
  }
  
  private func scaleToNormal() {
    for frontView in self.infoContainerViews {
      UIView.animate(withDuration: 0.5) {
        let xScale = frontView.transform.a
        let yScale = frontView.transform.d
        
        if xScale <= 0.8, yScale <= 0.8 {
          frontView.transform = CGAffineTransform(scaleX: (xScale + 0.2), y: (yScale + 0.2))
        } else {
          frontView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
      }
    }
  }
  
  private func reloadUI() {
    let infoViews = self.view.subviews.filter { $0 is InfoContainerView }
    infoViews.forEach{$0.removeFromSuperview()}
    
    guard let infoViews = self.infoContainerViews else { return }
    
    for infoView in infoViews {
      self.view.addSubview(infoView)
      
      infoView.translatesAutoresizingMaskIntoConstraints = false
      infoView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
      infoView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 25).isActive = true
      infoView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25).isActive = true
      infoView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50).isActive = true
      
      if infoView == infoViews.first {
        infoView.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
      } else if infoView == infoViews.last {
        
      } else {
        infoView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
      }
    }
  }
  
  enum SwipeSide {
    case left
    case right
  }
}


