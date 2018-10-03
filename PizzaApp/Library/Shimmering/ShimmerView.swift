//
//  ShimmerView.swift
//  PizzaApp
//
//  Created by Evandro Harrison Hoffmann on 19/9/18.
//  Copyright © 2018 ItsDayOff. All rights reserved.
//

import UIKit

class ShimmerView: UIView, ShimmerEffect {
    override static var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    
    var animationDuration: TimeInterval = 3
    
    var animationDelay: TimeInterval = 1.5
    
    var gradientHighlightRatio: Double = 0.3
    
    @IBInspectable var shimmerGradientTint: UIColor = .black
    
    @IBInspectable var shimmerGradientHighlight: UIColor = .white
    
}

struct ShimmerConstants {
    static var defaultShimmerDelay: Double = 0.2
    static var defaultShimmerTint: UIColor = UIColor.init(red: 35/255.0, green: 39/255.0, blue: 47/255.0, alpha: 0.2)
    static var defaultShimmerHighlight: UIColor = UIColor.init(red: 40/255.0, green: 45/255.0, blue: 53/255.0, alpha: 0.8)
    static var defaultShimmerHighlightRatio: Double = 0.8
    static var defaultShimmerWidthRatio: CGFloat = 1
    static var defaultShimmerHeightRatio: CGFloat = 1
    static var defaultShimmerAlignment: NSTextAlignment = .center
}

// MARK: - UIView Extension

extension UIView {
    
    func startShimmerAnimation(delay: Double = ShimmerConstants.defaultShimmerDelay,
                                      tint: UIColor = ShimmerConstants.defaultShimmerTint,
                                      highlight: UIColor = ShimmerConstants.defaultShimmerHighlight,
                                      highlightRatio: Double = ShimmerConstants.defaultShimmerHighlightRatio,
                                      widthRatio: CGFloat = ShimmerConstants.defaultShimmerWidthRatio,
                                      heightRatio: CGFloat = ShimmerConstants.defaultShimmerHeightRatio,
                                      alignment: NSTextAlignment = ShimmerConstants.defaultShimmerAlignment) {
        stopShimmerAnimation()
        
        let shimmerView = ShimmerView()
        
        //shimmerView.frame = CGRect(x: 0, y: 0, width: self.bounds.width*widthRatio, height: self.bounds.height*heightRatio)
        //shimmerView.center = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
        shimmerView.backgroundColor = .clear
        shimmerView.shimmerGradientTint = tint
        shimmerView.shimmerGradientHighlight = highlight
        shimmerView.animationDelay = delay
        shimmerView.gradientHighlightRatio = highlightRatio
        shimmerView.addShimmerAnimation()
        
        self.addSubview(shimmerView)
        
        shimmerView.translatesAutoresizingMaskIntoConstraints = false
        
        switch alignment {
        case .left:
            self.addConstraint(NSLayoutConstraint(item: shimmerView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0))
            break
        case .right:
            self.addConstraint(NSLayoutConstraint(item: shimmerView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0))
            break
        default:
            self.addConstraint(NSLayoutConstraint(item: shimmerView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        }
        
        self.addConstraint(NSLayoutConstraint(item: shimmerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: shimmerView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: widthRatio, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: shimmerView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: heightRatio, constant: 0))
    }
    
    func stopShimmerAnimation() {
        for subview in subviews {
            if let subview = subview as? ShimmerView {
                subview.removeShimmerAnimation()
                subview.removeFromSuperview()
            }
        }
    }
    
}
