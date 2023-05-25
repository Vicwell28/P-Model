//
//  Home+ViewController.swift
//  PoliticosTRC
//
//  Created by soliduSystem on 19/04/23.
//

import UIKit

class Home_ViewController: UIViewController {
    
    // MARK: - Override Func
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.scrollView.contentSize = CGSize(width: 0, height: self.lastlbl.frame.origin.y + self.lastlbl.frame.size.height + 80)
        self.overrideUserInterfaceStyle = .light
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    @IBOutlet weak var lastlbl: UILabel!
    
    
    // MARK: - IBOutlet
    
    
    // MARK: - Public let / var
    
    
    // MARK: - Private let / var
    
    
    // MARK: - IBAction
    
    @IBOutlet weak var scrollView: UIScrollView!
    
}



// MARK: - Public Func
extension Home_ViewController {
    
}

// MARK: - Private Func
extension Home_ViewController {
    
}

// MARK: - Services
extension Home_ViewController {
    
}

// MARK: - Other
extension Home_ViewController {
    
}
