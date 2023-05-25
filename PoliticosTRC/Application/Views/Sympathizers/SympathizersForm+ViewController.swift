//
//  SympathizersForm+ViewController.swift
//  PoliticosTRC
//
//  Created by soliduSystem on 21/04/23.
//

import UIKit

class SympathizersForm_ViewController: UIViewController {
    
    // MARK: - Override Func
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.overrideUserInterfaceStyle = .light
    }
    
    deinit {
        print("De Init")
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.scrollView.contentSize = CGSizeMake(0, self.btnSendForm.frame.origin.y + self.btnSendForm.frame.size.height + 80)
        self.imgPerfil.setCircle()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    @IBAction func btnTakePhoto(_ sender: UIButton) {
        self.showAlerActionSheet()
    }
    // MARK: - IBOutlet
    
    @IBOutlet weak var txfName: UITextField!
    @IBOutlet weak var txvAddress: UITextView!
    @IBOutlet weak var txfPhoneNumber: UITextField!
    @IBOutlet weak var txfINENumber: UITextField!
    @IBOutlet weak var txfLastNameMaterno: UITextField!
    @IBOutlet weak var txtLastNamePaterno: UITextField!
    @IBOutlet weak var btnPhoto: UIButton!
    @IBOutlet weak var btnSendForm: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgPerfil: UIImageView!
    
    // MARK: - Public let / var
    @IBOutlet weak var viewCorrect: UIView!
    public var miembrosList : MiembrosViewModel!
    
    // MARK: - Private let / var
    private var textFieldActive: UITextField?
    
    private func verifyData(){
        
        var faltan = 0
        
        if let text = self.txfName.text, text.isEmpty {
            //Mostrar mensaje de que faltan datos
            faltan += 1
            mal(self.txfName)
        }
        
        if let text = self.txtLastNamePaterno.text, text.isEmpty {
            //Mostrar mensaje de que faltan datos
            faltan += 1
            mal(self.txtLastNamePaterno)
        }
        
        if let text = self.txfLastNameMaterno.text, text.isEmpty {
            faltan += 1
            mal(self.txfLastNameMaterno)
        }
        
        if let text = self.txvAddress.text, text == "Dirección" {
            faltan += 1
            mal(self.txvAddress)
        }
        
        if let text = self.txfPhoneNumber.text, text.isEmpty {
            faltan += 1
            mal(self.txfPhoneNumber)
        }
        
        if let text = self.txfINENumber.text, text.isEmpty {
            faltan += 1
            mal(self.txfINENumber)
        }
        
        if faltan != 0 {
            return
        }
        
        self.showViewControllerLoader()
        
        Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false) { Timer in
            self.dismissViewControllerLoader()
            self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            
            self.viewCorrect.isHidden = false
            self.viewCorrect.alpha = 0
            
            UIView.animate(withDuration: 1.5) {
                self.viewCorrect.alpha = 1
                
            } completion: { Bool in
                
                UIView.animate(withDuration: 1.5) {
                    self.viewCorrect.alpha = 0
                    
                } completion: { Bool in
                    self.viewCorrect.isHidden = true
                    
                }
                
            }
            
            self.miembrosList.dataSoureMiembros.insert(
                MiembroModel(
                    name: "\(self.txfName.text!) \(self.txtLastNamePaterno.text!) \(self.txfLastNameMaterno.text!)",
                    numbresOfSimpatizantes: "0",
                    months: 0,
                    address: "0",
                    photo: "user_male1",
                    telefono: "8712655150",
                    INENumber: "",
                    supportGranted: []), at: 0)
            
            self.txfName.superview!.layer.borderColor = UIColor.black.cgColor
            self.txtLastNamePaterno.superview!.layer.borderColor = UIColor.black.cgColor
            self.txfLastNameMaterno.superview!.layer.borderColor = UIColor.black.cgColor
            self.txvAddress.superview!.layer.borderColor = UIColor.black.cgColor
            self.txfPhoneNumber.superview!.layer.borderColor = UIColor.black.cgColor
            self.txfINENumber.superview!.layer.borderColor = UIColor.black.cgColor
            
            self.txfName.text = ""
            self.txtLastNamePaterno.text = ""
            self.txfLastNameMaterno.text = ""
            self.txvAddress.text = "Dirección"
            self.txfPhoneNumber.text = ""
            self.txfINENumber.text = ""
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
    }
    
    
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
            
            self.verifyData()
            
            
            
        }
    }
}



// MARK: - Public Func
extension SympathizersForm_ViewController: UITextFieldDelegate{
    
    @objc func keyboardWillShow(notification: NSNotification) {
        print("keyboardWillShow 2")
        
        if self.textFieldActive == nil {
            return
        }
        
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
        if textField == self.txfName {
            self.txtLastNamePaterno.becomeFirstResponder()
        } else if textField == self.txtLastNamePaterno {
            self.txfLastNameMaterno.becomeFirstResponder()
        } else if textField == self.txfLastNameMaterno {
            self.txvAddress.becomeFirstResponder()
        }
        
        return true
    }
}

// MARK: - Private Func
extension SympathizersForm_ViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == self.txvAddress {
            if let text = self.txvAddress.text, text.isEmpty {
                self.txvAddress.text = "Dirección"
                self.txvAddress.textColor = UIColor.systemGray3
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == self.txvAddress {
            if let text = self.txvAddress.text, !text.isEmpty && text == "Dirección" {
                print("Etnron en el if")
                self.txvAddress.text = ""
                self.txvAddress.textColor = UIColor.black
            }
        }
    }
    
}

// MARK: - Services
extension SympathizersForm_ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func showAlerActionSheet(){
        let ac = UIAlertController(title: "Toma O Elige Una Foto", message: "Agrega una foto para tu reporte", preferredStyle: .actionSheet)
        
        ac.addAction(UIAlertAction(title: "Toma Foto", style: .default, handler: { _ in self.showCamera() }))
        
        ac.addAction(UIAlertAction(title: "Abrir Galeria", style: .default, handler: { _ in self.showGaleria() }))
        
        ac.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        
        self.present(ac, animated: true)
    }
    
    
    private func showCamera() -> Void {
        self.selectSourceTypeiImagePicker(.camera)
    }
    
    private func showGaleria() -> Void {
        self.selectSourceTypeiImagePicker(.photoLibrary)
    }
    
    private func selectSourceTypeiImagePicker(_ st : UIImagePickerController.SourceType ){
        if UIImagePickerController.isSourceTypeAvailable(st) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = st;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        
        self.imgPerfil.image = image
    }
    
}
// MARK: - Other
extension SympathizersForm_ViewController {
    
}


