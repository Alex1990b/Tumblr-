//
//  UIViewExtension.swift
//  TumblrApp
//
//  Created by Alex on 21.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import UIKit

@IBDesignable extension UIView {
    
    @IBInspectable var shadowColor: UIColor? {
        
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            else {
                return nil
            }
        }
        
        set {
            layer.shadowColor = newValue!.cgColor
        }
     
    }
    
    @IBInspectable var shadowOpacity: Float {
        
        get {
            return layer.shadowOpacity
        }
        
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGPoint {
        
        get {
            return CGPoint(x: layer.shadowOffset.width, y: layer.shadowOffset.height)
        }
        
        set {
            layer.shadowOffset = CGSize(width: newValue.x, height: newValue.y)
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        
        get {
            return layer.shadowRadius
        }
        
        set {
            layer.shadowRadius = newValue
        }
    }
}

