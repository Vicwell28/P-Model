//
//  IBInspectable+Extensions.swift
//  PoliticosTRC
//
//  Created by soliduSystem on 19/04/23.
//

import UIKit

@IBDesignable
extension UIView {
    @IBInspectable var shadowColorAlpha: CGFloat {
        get {
            return layer.shadowColor?.alpha ?? 0.0
        }
        set {
            if let color = layer.shadowColor {
                layer.shadowColor = UIColor(cgColor: color).withAlphaComponent(newValue).cgColor
            } else {
                layer.shadowColor = UIColor.black.withAlphaComponent(newValue).cgColor
            }
            setNeedsLayout()
        }
    }
    @IBInspectable var shadowColor : UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            layer.shadowColor = newValue?.cgColor
            setNeedsLayout()
        }
    }
    @IBInspectable var shadowOpacity : Float{
        get {
            return layer.shadowOpacity
        }
        set{
            layer.shadowOpacity = newValue
            setNeedsLayout()
        }
    }
    @IBInspectable var shadowOffset : CGSize{
        get {
            return layer.shadowOffset
        }
        set{
            layer.shadowOffset = newValue
            setNeedsLayout()
        }
    }
    @IBInspectable var maskToBounds : Bool{
        get {
            return layer.masksToBounds
        }
        set{
            layer.masksToBounds = newValue
            setNeedsLayout()
        }
    }
    @IBInspectable var cornerRadius : CGFloat{
        get {
            return layer.cornerRadius
        }
        set{
            layer.cornerRadius = newValue
            setNeedsLayout()
        }
    }
    @IBInspectable var borderWidth : CGFloat{
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth =  newValue
            setNeedsLayout()
        }
    }
    @IBInspectable var borderColor : UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            layer.borderColor = newValue?.cgColor
            setNeedsLayout()
        }
    }
    @IBInspectable var shadowRadius : CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
            setNeedsLayout()
        }
    }
}

