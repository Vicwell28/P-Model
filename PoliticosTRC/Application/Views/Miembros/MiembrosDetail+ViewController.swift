//
//  MiembrosDetail+ViewController.swift
//  PoliticosTRC
//
//  Created by soliduSystem on 21/04/23.
//

import UIKit

class MiembrosDetail_ViewController: UIViewController {
    
    // MARK: - Override Func
    override func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .light
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.imgPerfil.setCircle()
        self.scrollView.contentSize = CGSize(width: 0, height: self.lastlbl.frame.origin.y + self.lastlbl.frame.self.height + 70)
        
        self.imgPerfil.image = UIImage(named: self.miembroWithLevelPlain.photo!)
        self.lblName.text = self.miembroWithLevelPlain.name!
        
    }
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(self.miembroWithLevelPlain)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    @IBOutlet weak var lastlbl: UILabel!
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    // MARK: - IBOutlet
    @IBOutlet weak var imgPerfil: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPuesto: UILabel!
    
    // MARK: - Public let / var
    public var miembroWithLevelPlain: MiembroWithLevelPlain!
    
    // MARK: - Private let / var
    
    
    // MARK: - IBAction
    
    @IBAction func actionDown(_ sender: UIButton) {
        sender.transform = CGAffineTransform(translationX: 0, y: 10)
        sender.layer.shadowOpacity = 0
        
    }
    
    @IBAction func actionUp(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2) {
            sender.transform = CGAffineTransform(translationX: 1, y: 1)
            sender.layer.shadowOpacity = 0.75
        } completion: { Bool in
            self.callNumber(phoneNumber: "8712655150")
        }
    }
    
    private func callNumber(phoneNumber: String) {
        guard let url = URL(string: "telprompt://\(phoneNumber)"),
              UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
}



// MARK: - Public Func
extension MiembrosDetail_ViewController {
    
}

// MARK: - Private Func
extension MiembrosDetail_ViewController {
    
}

// MARK: - Services
extension MiembrosDetail_ViewController {
    
}

// MARK: - Other
extension MiembrosDetail_ViewController {
    
}


