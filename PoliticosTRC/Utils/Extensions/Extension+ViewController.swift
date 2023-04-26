//
//  Extension+ViewController.swift
//  PoliticosTRC
//
//  Created by soliduSystem on 25/04/23.
//

import UIKit

extension UIViewController {
    @IBAction func returnView(_ sender: UIButton) -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapGestureEndEditing(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}
