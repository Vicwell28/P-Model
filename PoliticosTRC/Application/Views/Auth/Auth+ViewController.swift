//
//  ViewController.swift
//  PoliticosTRC
//
//  Created by soliduSystem on 19/04/23.
//

import UIKit

class Auth_ViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    // MARK: - Override FuncdidFinishLaunchingWithOptions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.txtName.superview!.alpha = 0
        self.txtPassword.superview!.alpha = 0
        self.btnSend.alpha = 0
        
        // Registra los controladores de notificación para el teclado
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.overrideUserInterfaceStyle = .light
    }
    
    deinit {
        print("De Init")
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { Timer in
            
            self.imageViewNameTop.isActive = false
            self.view.addConstraint(NSLayoutConstraint(item: self.imageViewName!, attribute: .top, relatedBy: .equal, toItem: self.btnSend, attribute: .bottom, multiplier: 1, constant: 40))
            
            UIView.animate(withDuration: 1.5) {
                self.txtNameTop.constant = 60
                self.view.layoutIfNeeded()
            } completion: { Bool in
                
                UIView.animate(withDuration: 0.5) {
                    self.txtName.superview!.alpha = 1
                    self.txtPassword.superview!.alpha = 1
                    self.btnSend.alpha = 1
                }
                
                self.scrollView.contentSize = CGSize(width: 0, height: self.imageViewName.frame.origin.y + self.imageViewName.frame.size.height + 20)
            }
            
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("De viewDidDisappear")
        NotificationCenter.default.removeObserver(self)
        
    }
    
    @IBAction func tapScrollView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    // MARK: - IBOutlet
    
    @IBAction func actionLoginDown(_ sender: UIButton) {
        sender.transform = CGAffineTransform(translationX: 0, y: 10)
        sender.layer.shadowOpacity = 0
        
    }
    
    @IBAction func actionLoginUp(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2) {
            sender.transform = CGAffineTransform(translationX: 1, y: 1)
            sender.layer.shadowOpacity = 0.75
        } completion: { Bool in
            
            self.showViewControllerLoader()
            
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { Timer in
                self.dismissViewControllerLoader()
                
                if self.txtName.text == "admin@gmail.com" && self.txtPassword.text == "123456" {
                    self.performSegue(withIdentifier: "tabBarController", sender: nil)
                } else {
                    self.mal(self.txtName)
                    self.mal(self.txtPassword)
                }
                
            }
            
            
            
        }
    }
    
    private func mal(_ txf: UIView){
        UIView.animate(withDuration: 0.1, animations: {
            txf.superview!.transform = CGAffineTransform(translationX: -10, y: 0)
        }, completion: { (_) in
            UIView.animate(withDuration: 0.1, animations: {
                txf.superview!.transform = CGAffineTransform(translationX: 10, y: 0)
            }, completion: { (_) in
                txf.superview!.transform = CGAffineTransform.identity
            })
        })
        txf.superview!.layer.borderColor = UIColor.red.cgColor
        txf.superview!.layer.borderWidth = 1
    }
    
    
    
    // MARK: - Public let / var
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - Private let / var
    @IBOutlet weak var imageViewName: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var imageViewNameTop: NSLayoutConstraint!
    @IBOutlet weak var txtNameTop: NSLayoutConstraint!
    
    private var textFieldActive: UITextField?
    
    
    // MARK: - IBAction
    
}



// MARK: - Public Func
extension Auth_ViewController {
    
}

// MARK: - Private Func
extension Auth_ViewController {
    
}

// MARK: - Services
extension Auth_ViewController: UITextFieldDelegate{
    
    @objc func keyboardWillShow(notification: NSNotification) {
        print("keyboardWillShow")
        guard let info = notification.userInfo else { return }
        guard let kbSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size else { return }
        guard let kbOrigin = (info[UIResponder.keyboardFrameEndUserInfoKey]as? NSValue)?.cgRectValue else {return }
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        var aRect = self.view.frame
        
        aRect.size.height -= kbSize.height + self.textFieldActive!.superview!.frame.size.height + 40
        
        if !aRect.contains(self.textFieldActive!.superview!.frame.origin) {
            var keyboardHeight = self.view.frame.height - kbOrigin.origin.y
            keyboardHeight = max(0, keyboardHeight)
            let textFieldRect = self.textFieldActive!.superview!.convert(self.textFieldActive!.frame, to: self.scrollView)
            let contentOffsetY = max(textFieldRect.origin.y + textFieldRect.size.height - self.scrollView.bounds.size.height + keyboardHeight, 0)
            let contentOffset = CGPoint(x: 0, y: contentOffsetY + self.textFieldActive!.superview!.frame.size.height)
            self.scrollView.setContentOffset(contentOffset, animated: true)
        }
    }
    
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.textFieldActive = textField
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        
        if textField == self.txtName {
            self.txtPassword.becomeFirstResponder()
        } else if textField == self.txtPassword {
            self.txtPassword.resignFirstResponder()
        }
        
        return true
        
    }
}

// MARK: - Other
extension Auth_ViewController {
    
}
