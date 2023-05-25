//
//  Sympathizers+ViewController.swift
//  PoliticosTRC
//
//  Created by soliduSystem on 19/04/23.
//

import UIKit

class Sympathizers_ViewController: UIViewController {
    
    // MARK: - Override Func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 60
        
        self.dataSourceFiltred = self.dataSourceSympathizers.dataSoureMiembros
        
        
        self.tableView.register(UINib(nibName: "Sympathizer+TableViewCell", bundle: nil), forCellReuseIdentifier: "cellSymp")
        self.overrideUserInterfaceStyle = .light
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if self.isPresentForm {
            print("Se va a racarge la talba")
            self.dataSourceFiltred = self.dataSourceSympathizers.dataSoureMiembros
            self.tableView.reloadData()
            self.isPresentForm.toggle()
        }
        
        if self.firstConstraintBtnSeach == nil {
            self.firstConstraintBtnSeach = NSLayoutConstraint(item: self.txtFieldSearch!.superview!.superview!, attribute: .trailing, relatedBy: .equal, toItem: self.txtFieldSearch!.superview!, attribute: .trailing, multiplier: 1.0, constant: 0)
            self.view.addConstraint(self.firstConstraintBtnSeach!)
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.isPresentForm = true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("Segue: \(String(describing: sender))")
        
        if segue.identifier == "segueSympForm" {
            self.isPresentForm = true
            let destination = segue.destination as! SympathizersForm_ViewController
            print(self.dataSourceSympathizers)
            destination.miembrosList = sender as? MiembrosViewModel
            
        } else if segue.identifier == "segueSympDeatil" {
            let destination = segue.destination as! SympathizersDetail_ViewController
            destination.miembroDetail = sender as? MiembroModel
            
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    let dataSourceSympathizers = MiembrosViewModel()
    
    private var dataSourceFiltred: [MiembroModel] = [MiembroModel]()
    
    @IBOutlet weak var txtFieldSearch: UITextField!
    @IBOutlet weak var btnSearchCancel: UIButton!
    private var firstConstraintBtnSeach: NSLayoutConstraint?
    private var secondConstraintBtnSeach: NSLayoutConstraint?
    
    // MARK: - Public let / var
    
    
    // MARK: - Private let / var
    private var isPresentForm: Bool = false
    
    // MARK: - IBAction
    
    @IBAction func seachBarValueChange(_ sender: UITextField) {
        if let txt = sender.text {
            if txt.isEmpty {
                print("Lo dejo vacio")
                self.dataSourceFiltred = self.dataSourceSympathizers.dataSoureMiembros
            } else {
                print("Texto buscado: \(txt)")
                self.dataSourceFiltred = self.dataSourceSympathizers.dataSoureMiembros.filter({ MiembroModel in
                    MiembroModel.name.lowercased().contains(txt.lowercased())
                })
            }
            self.tableView.reloadData()
        }
    }
    
    
    @IBAction func actionUp(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segueSympForm", sender: self.dataSourceSympathizers)
    }
}



// MARK: - Public Func
extension Sympathizers_ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSymp", for: indexPath) as! Sympathizer_TableViewCell
        
        cell.labelName.text = self.dataSourceFiltred[indexPath.row].name
        cell.imgCell.image = UIImage(named: self.dataSourceFiltred[indexPath.row].photo)
        cell.labelMonth.text = "\(self.dataSourceFiltred[indexPath.row].months) meses"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSourceFiltred.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        print("IndexPath: \(indexPath)")
        performSegue(withIdentifier: "segueSympDeatil", sender: self.dataSourceFiltred[indexPath.row])
    }
    
    
}

// MARK: - Private Func
extension Sympathizers_ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.txtFieldSearch {
            self.view.endEditing(true)
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.firstConstraintBtnSeach = NSLayoutConstraint(item: self.txtFieldSearch!.superview!.superview!, attribute: .trailing, relatedBy: .equal, toItem: self.txtFieldSearch!.superview!, attribute: .trailing, multiplier: 1.0, constant: 0)
        
        self.view.removeConstraint(self.secondConstraintBtnSeach!)
        self.view.addConstraint(self.firstConstraintBtnSeach!)
        
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.secondConstraintBtnSeach = NSLayoutConstraint(item: self.txtFieldSearch!.superview!, attribute: .trailing, relatedBy: .equal, toItem: self.btnSearchCancel, attribute: .leading, multiplier: 1.0, constant: -8.0)
        
        self.view.removeConstraint(self.firstConstraintBtnSeach!)
        self.view.addConstraint(self.secondConstraintBtnSeach!)
        
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    
    
}

// MARK: - Services
extension Sympathizers_ViewController {
    
}

// MARK: - Other
extension Sympathizers_ViewController {
    
}
