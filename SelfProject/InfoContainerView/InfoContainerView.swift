//
//  InfoContainerView.swift
//  SelfProject
//
//  Created by Track Ensure on 2021-09-23.
//

import UIKit

class InfoContainerView: UIView {
  var viewColor: UIColor
  var colorName: String {
    switch self.viewColor {
    case UIColor.red: return "red"
    case UIColor.green: return "green"
    case UIColor.orange: return "orange"
    default: return "another"
    }
  }
  
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
      let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
      roundedRect.addClip()
      viewColor.setFill()
      layer.cornerRadius = cornerRadius
      layer.masksToBounds = true
      roundedRect.fill()
      
//      let imageView = UIImageView()
//      let image = UIImage(systemName: "heart.fill")
//      imageView.image = image
//      imageView.contentMode = .center
//      addSubview(imageView)
//
//      imageView.translatesAutoresizingMaskIntoConstraints = false
//      imageView.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
//      imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 25).isActive = true
//      imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -25).isActive = true
//      imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25).isActive = true
      
      
      
      let viewWidth = self.frame.width
      let viewHeight: CGFloat = self.frame.height
      
      
      
      // scroll
      addSubview(scrollView)
      // constrain the scroll view to 8-pts on each side
      scrollView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8.0).isActive = true
      scrollView.topAnchor.constraint(equalTo: topAnchor, constant: 8.0).isActive = true
      scrollView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8.0).isActive = true
      scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.0).isActive = true
      
      //add imageView to the scroll view
      scrollView.addSubview(imageView)
      
      // constrain the imageView to 80%
      imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
      imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0).isActive = true
      imageView.widthAnchor.constraint(equalToConstant: viewWidth * 0.8).isActive = true
      imageView.heightAnchor.constraint(equalToConstant: viewHeight * 0.8).isActive = true
      
      
      
      
      // add labelOne to the scroll view
      scrollView.addSubview(labelOne)
      
      // constrain labelOne to left & top with 16-pts padding
      // this also defines the left & top of the scroll content
      labelOne.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16.0).isActive = true
      labelOne.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16.0).isActive = true
      
      // add labelTwo to the scroll view
      scrollView.addSubview(labelTwo)
      
      
      // constrain labelTwo at 400-pts from the left
      labelTwo.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
      
      // constrain labelTwo at 1000-pts from the top
      labelTwo.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 1000).isActive = true
      
      // constrain labelTwo to right & bottom with 16-pts padding
      labelTwo.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -16.0).isActive = true
      labelTwo.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16.0).isActive = true
      
//      let viewWidth = self.frame.width
//      let viewHeight: CGFloat = 1000
      
      scrollView.contentSize = CGSize(width: viewWidth, height: 1000)
      
      
      
      //add topInfoView
      addSubview(topInfoView)
      
      topInfoView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
      topInfoView.heightAnchor.constraint(equalToConstant: 40).isActive = true
      topInfoView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
      topInfoView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
  
  init(viewColor: UIColor) {
    self.viewColor = viewColor
    super.init(frame: .zero)
    
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
  
  //TEST
  let labelOne: UILabel = {
    let label = UILabel()
    label.text = "Scroll Top"
    label.backgroundColor = .red
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let labelTwo: UILabel = {
    let label = UILabel()
    label.text = "Scroll Bottom"
    label.backgroundColor = .green
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let imageView: UIImageView = {
    let imageView = UIImageView()
    let image = UIImage(systemName: "heart.fill")
    imageView.image = image
    imageView.contentMode = .center
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  let topInfoView: UIView = {
    let topInfoView = UIView()
    let label = UILabel()
    topInfoView.addSubview(label)
    label.text = "User Name"
    label.backgroundColor = .green
    label.translatesAutoresizingMaskIntoConstraints = false
    label.centerXAnchor.constraint(equalTo: topInfoView.centerXAnchor).isActive = true
    label.centerYAnchor.constraint(equalTo: topInfoView.centerYAnchor).isActive = true
    
    topInfoView.translatesAutoresizingMaskIntoConstraints = false
    return topInfoView
  }()
  
  let scrollView: UIScrollView = {
    let v = UIScrollView()
    v.translatesAutoresizingMaskIntoConstraints = false
    v.backgroundColor = .cyan
    return v
  }()
}

//MARK: - extensions
extension InfoContainerView {
  private struct SizeRatio {
    static let cornerFontSizeToBoundsHeight: CGFloat = 0.085
    static let cornerRadiusToBoundsHeight: CGFloat = 0.06
    static let cornerOffsetToCornerRadius: CGFloat = 0.33
    static let faceCardImageSizeToBoundsSize: CGFloat = 0.75
  }
  
  private var cornerRadius: CGFloat {
    return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
  }
  private var cornerOffset: CGFloat {
    return cornerRadius * SizeRatio.cornerOffsetToCornerRadius
  }
  private var cornerFontSize: CGFloat {
    return bounds.size.height * SizeRatio.cornerFontSizeToBoundsHeight
  }
  //  private var rankString: String {
  //    switch rank {
  //    case 1: return "A"
  //    case 2...10: return String(rank)
  //    case 11: return "J"
  //    case 12: return "Q"
  //    case 13: return "K"
  //    default: return "?"
  //    }
  //  }
}
