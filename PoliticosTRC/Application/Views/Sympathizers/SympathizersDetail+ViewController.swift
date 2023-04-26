//
//  SympathizersDetail+ViewController.swift
//  PoliticosTRC
//
//  Created by soliduSystem on 21/04/23.
//

import UIKit

class SympathizersDetail_ViewController: UIViewController {
    
    // MARK: - Override Func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "SympathizerDetail+TableViewCell", bundle: nil), forCellReuseIdentifier: "cellSupport")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 40
        
        self.tableViewSupport.register(UINib(nibName: "Simple+TableViewCell", bundle: nil), forCellReuseIdentifier: "simpleCell")
        self.tableViewSupport.dataSource = self
        self.tableViewSupport.delegate = self
        self.tableViewSupport.rowHeight = 40
        
        self.btnCloseAddSupport.layer.cornerRadius = self.btnCloseAddSupport.frame.size.width / 2
        self.overrideUserInterfaceStyle = .light
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.imgPerfil.image = UIImage(named: self.miembroDetail!.photo)
        self.lblName.text = self.miembroDetail!.name
        self.lblDate.text = "Simpatizante desde hace \(self.miembroDetail!.months) meses"
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

    }
    
    @IBOutlet weak var btnCloseAddSupport: UIButton!
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imgPerfil: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var viewVisualEffect: UIVisualEffectView!
    // MARK: - Public let / var
    @IBOutlet weak var tableViewSupport: UITableView!
    
    private let dataSourceSupported: [String] = [
        "Tinaco",
        "Huevo",
        "Despensa",
        "Pintura"
    ].shuffled()
    
    
    // MARK: - Private let / var
    public var miembroDetail : MiembroModel!
    
    @IBAction func dissmisViewVisualEffect(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.25) {
            self.viewVisualEffect.alpha = 0
        } completion: { Bool in
            self.viewVisualEffect.isHidden.toggle()
        }
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
            self.viewVisualEffect.isHidden.toggle()
            self.view.bringSubviewToFront(self.viewVisualEffect)
            self.viewVisualEffect.alpha = 0
            UIView.animate(withDuration: 0.25) {
                self.viewVisualEffect.alpha = 1
            }
        }
    }
}

extension UIImageView {
    func setCircle() -> Void {
        self.layer.cornerRadius = self.frame.size.width / 2
    }
}



// MARK: - Public Func
extension SympathizersDetail_ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.tableView {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellSupport", for: indexPath) as! SympathizerDetail_TableViewCell
            
            cell.lblData.text = self.miembroDetail!.supportGranted[indexPath.row].dateOfSupportGranted
            cell.lblSupport.text = self.miembroDetail!.supportGranted[indexPath.row].supportedGranded.uppercased()

            return cell
            
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "simpleCell", for: indexPath) as! Simple_TableViewCell
        
        cell.lblUnique.text = self.dataSourceSupported[indexPath.row].uppercased()

        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.tableView {
            return self.miembroDetail!.supportGranted.count
        }
        
        return self.dataSourceSupported.count
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
                
        if tableView == self.tableViewSupport {
            
            let support = self.dataSourceSupported[indexPath.row]
            let date = Date()

            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .none
            dateFormatter.dateFormat = "dd/MM/yy"
            let fechaFormateada = dateFormatter.string(from: date)
            
            let sup = SupportGranted(dateOfSupportGranted: fechaFormateada, supportedGranded: support)
            
            self.miembroDetail!.supportGranted.append(sup)
            
            self.tableView.reloadData()
            
            UIView.animate(withDuration: 0.25) {
                self.viewVisualEffect.alpha = 0
            } completion: { Bool in
                self.viewVisualEffect.isHidden.toggle()

            }

        }
    }
    
    
}

// MARK: - Private Func
extension SympathizersDetail_ViewController {
    
}

// MARK: - Services
extension SympathizersDetail_ViewController {
    
}

// MARK: - Other
extension SympathizersDetail_ViewController {
    
}
