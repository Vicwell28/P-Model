//
//  Loader+Extension.swift
//  PoliticosTRC
//
//  Created by soliduSystem on 26/04/23.
//

import Foundation
import UIKit

fileprivate var firstCircleView : UIView? = UIView()
fileprivate var secondCircleView : UIView? = UIView()
fileprivate var thirdCircleView : UIView? = UIView()
fileprivate var dataSourceView : [UIView?] = [firstCircleView!, secondCircleView!, thirdCircleView!]
fileprivate var blackView : UIView? = UIView()
fileprivate var repeatAnimation : Timer? = Timer()


extension UIViewController {
    
    public func buildLoader() -> Void {
        firstCircleView = UIView()
        secondCircleView = UIView()
        thirdCircleView = UIView()
        
        dataSourceView = [firstCircleView!, secondCircleView!, thirdCircleView!]
        
        blackView = UIView()
        
        blackView!.translatesAutoresizingMaskIntoConstraints = false
        blackView!.backgroundColor = .black.withAlphaComponent(0.25)
        
        self.view.addSubview(blackView!)
        self.view.addConstraints([
            NSLayoutConstraint(item: blackView!, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: blackView!, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: blackView!, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: blackView!, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        ])
        
        
        firstCircleView!.backgroundColor = .ThirdColor
        firstCircleView!.layer.cornerRadius = 10
        firstCircleView!.translatesAutoresizingMaskIntoConstraints = false
        blackView!.addSubview(firstCircleView!)
        blackView!.addConstraints([
            NSLayoutConstraint(item: firstCircleView!, attribute: .centerY, relatedBy: .equal, toItem: blackView!, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: firstCircleView!, attribute: .centerX, relatedBy: .equal, toItem: blackView!, attribute: .centerX, multiplier: 0.8, constant: 0),
            NSLayoutConstraint(item: firstCircleView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: firstCircleView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20),
        ])
        
        secondCircleView!.backgroundColor = .white
        secondCircleView!.layer.cornerRadius = 10
        secondCircleView!.translatesAutoresizingMaskIntoConstraints = false
        blackView!.addSubview(secondCircleView!)
        blackView!.addConstraints([
            NSLayoutConstraint(item: secondCircleView!, attribute: .centerY, relatedBy: .equal, toItem: blackView!, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: secondCircleView!, attribute: .centerX, relatedBy: .equal, toItem: blackView!, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: secondCircleView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: secondCircleView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20),
        ])
        
        thirdCircleView!.backgroundColor = .FirstColor
        thirdCircleView!.layer.cornerRadius = 10
        thirdCircleView!.translatesAutoresizingMaskIntoConstraints = false
        blackView!.addSubview(thirdCircleView!)
        blackView!.addConstraints([
            NSLayoutConstraint(item: thirdCircleView!, attribute: .centerY, relatedBy: .equal, toItem: blackView!, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: thirdCircleView!, attribute: .centerX, relatedBy: .equal, toItem: blackView!, attribute: .centerX, multiplier: 1.2, constant: 0),
            NSLayoutConstraint(item: thirdCircleView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: thirdCircleView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20),
        ])
        
        var idxViews : Int = 0
        
        repeatAnimation = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { Timer in
                        
            UIView.animate(withDuration: 0.15) {
                
                if dataSourceView.isEmpty {
                    repeatAnimation?.invalidate()
                } else {
                    dataSourceView[idxViews]!.transform = CGAffineTransform(translationX: 0, y: -20)
                }
                
            } completion: { Bool in
                UIView.animate(withDuration: 0.15) {
                    if dataSourceView.isEmpty {
                        repeatAnimation?.invalidate()
                    } else {
                        dataSourceView[idxViews]!.transform = CGAffineTransform(translationX: 0, y: 0)
                    }
                    
                    if idxViews >= (dataSourceView.count - 1) {
                        idxViews = 0
                    } else {
                        idxViews += 1
                    }
                }
            }
        }
    }
    
    public func showViewControllerLoader() -> Void {
        self.buildLoader()
        
        blackView!.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            blackView!.alpha = 1
        }
        
    }
    
    public func dismissViewControllerLoader() -> Void {
        
        UIView.animate(withDuration: 0.5) {
            
            if let bv = blackView {
                bv.alpha = 0
            }
            
        } completion: { Bool in
            
            repeatAnimation!.invalidate()
            
            dataSourceView.removeAll()
            
            firstCircleView?.removeFromSuperview()
            secondCircleView?.removeFromSuperview()
            thirdCircleView?.removeFromSuperview()
            
            blackView?.removeFromSuperview()
            
            blackView = nil
            
            
        }
    }
}
