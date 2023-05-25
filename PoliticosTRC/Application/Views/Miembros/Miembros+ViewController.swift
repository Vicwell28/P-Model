//
//  Miembros+ViewController.swift
//  PoliticosTRC
//
//  Created by soliduSystem on 21/04/23.
//

import UIKit

class Miembros_ViewController: UIViewController {
    
    // MARK: - Override Func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "Miembro+TableViewCell", bundle: nil), forCellReuseIdentifier: "miembroCell")
        self.tableView.register(UINib(nibName: "MiembroSelected+TableViewCell", bundle: nil), forCellReuseIdentifier: "miembroSelectedCell")
        
        self.tableView.rowHeight = 55
        
        print(self.dataSource.dataSourceMiemborsWithLevel.count)
        
        
        print(self.dataSource.dataSourceMiemborsWithLevel.count)
        
        self.dataSource.dataSourceMiemborsWithLevel.forEach { MiembroModelWithLevel in
            print(MiembroModelWithLevel.miembros.count)
            print(MiembroModelWithLevel.isHeader)
            print(MiembroModelWithLevel.level)
        }
        self.maxLevelHeader = self.dataSource.dataSourceMiemborsWithLevel.count - 1
        self.overrideUserInterfaceStyle = .light
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.prepareMiembroWithLevelPlain()
        
        
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
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("Segue: \(String(describing: sender))")
        
        if segue.identifier == "segueMiembroDetail" {
            let destination = segue.destination as! MiembrosDetail_ViewController
            destination.miembroWithLevelPlain = sender as? MiembroWithLevelPlain
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Public let / var
    
    // MARK: - Private let / var
    private let dataSource = MiembrosViewModel()
    private var levelHeader = 0
    private var maxLevelHeader = 0
    private var tagLevel = 0
    
    
    @IBOutlet weak var txtFieldSearch: UITextField!
    @IBOutlet weak var btnSearchCancel: UIButton!
    private var firstConstraintBtnSeach: NSLayoutConstraint?
    private var secondConstraintBtnSeach: NSLayoutConstraint?
    
    
    private var dataSourceMiemborsWithLevel:  [MiembroWithLevelPlain] = [MiembroWithLevelPlain]()
    
    
    private func prepareMiembroWithLevelPlain() {
        
        self.dataSourceMiemborsWithLevel.removeAll()
        
        if self.levelHeader == 0 {
            
            let header = self.dataSource.dataSourceMiemborsWithLevel[self.levelHeader]
            
            self.dataSourceMiemborsWithLevel.append(MiembroWithLevelPlain(tag: 0,level: header.level.level, isHeader: header.isHeader))
            
            let mbrs = self.dataSource.dataSourceMiemborsWithLevel[self.levelHeader].miembros.map { MiembroModel in
                MiembroWithLevelPlain(isHeader: false, name: MiembroModel.name, numbresOfSimpatizantes: MiembroModel.numbresOfSimpatizantes, months: MiembroModel.months, address: MiembroModel.address, photo: MiembroModel.photo, telefono: MiembroModel.telefono, INENumber: MiembroModel.INENumber, supportGranted: MiembroModel.supportGranted)
            }
            
            self.dataSourceMiemborsWithLevel.append(contentsOf: mbrs)
            self.tagLevel = 0
            self.tableView.reloadData()
            
            return
            
        }
        
        
        (0...self.levelHeader).forEach { Int in
            let header = self.dataSource.dataSourceMiemborsWithLevel[Int]
            
            self.dataSourceMiemborsWithLevel.append(MiembroWithLevelPlain(tag: Int, level: header.level.level, isHeader: header.isHeader))
        }
        
        let mbrs = self.dataSource.dataSourceMiemborsWithLevel[self.levelHeader].miembros.map { MiembroModel in
            MiembroWithLevelPlain(isHeader: false, name: MiembroModel.name, numbresOfSimpatizantes: MiembroModel.numbresOfSimpatizantes, months: MiembroModel.months, address: MiembroModel.address, photo: MiembroModel.photo, telefono: MiembroModel.telefono, INENumber: MiembroModel.INENumber, supportGranted: MiembroModel.supportGranted)
        }
        
        self.dataSourceMiemborsWithLevel.append(contentsOf: mbrs)
        self.tagLevel = 0
        
        self.tableView.reloadData()
        
    }
    
    // MARK: - IBAction
    
}

// MARK: - Public Func
extension Miembros_ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //AGREGAR UNO DE TAG AL STRUCT
        
        
        if self.dataSourceMiemborsWithLevel[indexPath.row].isHeader {
            let cell = tableView.dequeueReusableCell(withIdentifier: "miembroSelectedCell", for: indexPath) as! MiembroSelected_TableViewCell
            
            cell.tag = self.dataSourceMiemborsWithLevel[indexPath.row].tag
            
            cell.lblName.text = self.dataSourceMiemborsWithLevel[indexPath.row].level!
            
            return cell
        }
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "miembroCell", for: indexPath) as! Miembro_TableViewCell
        
        cell.lblName.text = self.dataSourceMiemborsWithLevel[indexPath.row].name!
        cell.btnCell.tag = self.dataSourceMiemborsWithLevel[indexPath.row].tagMiembro
        cell.lblSymp.text = "\(self.dataSourceMiemborsWithLevel[indexPath.row].numbresOfSimpatizantes!) simpatizantes"
        cell.imgCell.image = UIImage(named: self.dataSourceMiemborsWithLevel[indexPath.row].photo!)
        
        cell.btnCell.addTarget(self, action: #selector(selectUser), for: .touchUpInside)
        
        cell.tag = 69
        return cell
        
        
        
    }
    
    @objc func selectUser(_ sender: UIButton) {
        
        print(sender)
        
        
        
        let miembros = self.dataSourceMiemborsWithLevel.filter { MiembroWithLevelPlain in
            MiembroWithLevelPlain.tagMiembro == sender.tag
        }
        
        if !miembros.isEmpty {
            let miembro = miembros.first!
            performSegue(withIdentifier: "segueMiembroDetail", sender: miembro)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceMiemborsWithLevel.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        guard let cellTag  = tableView.cellForRow(at: indexPath)?.tag else {
            return
        }
        
        print(cellTag)
        
        print("self.levelHeader: \(self.levelHeader)")
        print("self.maxLevelHeader: \(self.maxLevelHeader)")
        
        if cellTag == 69 {
            //SE VA A AUMETNAR EL LEAVEL
            if self.levelHeader >= self.maxLevelHeader {
                //YA ESTA EN LIDER DE COONIA MANDAR A LA OTRA PANTALLA
                print("1")
            } else {
                print("2")
                self.levelHeader += 1
                self.prepareMiembroWithLevelPlain()
                let indexPath = IndexPath(row: 0, section: 0)
                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
            
        } else {
            print("3")
            //SE VA A DECREMENTAR EL LEVEL
            //SABER QUE CELDA ESTA TOCANDO
            if self.levelHeader != 0 {
                print("4")
                self.levelHeader = cellTag
                self.prepareMiembroWithLevelPlain()
            }
        }
        
    }
    
    
    
    
    
}

// MARK: - Private Func
extension Miembros_ViewController: UITextFieldDelegate{
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
extension Miembros_ViewController {
    
}

// MARK: - Other
extension Miembros_ViewController {
    
}
