//
//  KeyboardManager.swift
//  PoliticosTRC
//
//  Created by soliduSystem on 19/04/23.
//

import Foundation
import UIKit

class KeyboardManager {
    static func registerForKeyboardNotifications(textField: UITextField?, scrollView: UIScrollView) {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { (notification) in
            if let userInfo = notification.userInfo {
                if let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                    let keyboardSize = keyboardFrame.cgRectValue.size
                    let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
                    scrollView.contentInset = contentInsets
                    scrollView.scrollIndicatorInsets = contentInsets
                    
                    if let activeTextField = textField {
                        let textFieldRect = activeTextField.convert(activeTextField.bounds, to: scrollView)
                        scrollView.scrollRectToVisible(textFieldRect, animated: true)
                    }
                }
            }
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { (notification) in
            let contentInsets = UIEdgeInsets.zero
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
        }
    }
    
    static func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
