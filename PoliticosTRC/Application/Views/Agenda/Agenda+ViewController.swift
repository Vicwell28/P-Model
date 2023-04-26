//
//  Agenda+ViewController.swift
//  PoliticosTRC
//
//  Created by soliduSystem on 19/04/23.
//

import UIKit

class Agenda_ViewController: UIViewController {
    
    // MARK: - Override Func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "Agenda+TableViewCell", bundle: nil), forCellReuseIdentifier: "AgendaCell")
        
        tableView.rowHeight = 150
        self.overrideUserInterfaceStyle = .light
        
        self.dataSourceFiltred = self.agendaViewModel.dataSource
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

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
    
    
    @IBAction func seachBarValueChange(_ sender: UITextField) {
        if let txt = sender.text {
            if txt.isEmpty {
                print("Lo dejo vacio")
                self.dataSourceFiltred = self.agendaViewModel.dataSource
            } else {
                print("Texto buscado: \(txt)")
                
                self.dataSourceFiltred = self.agendaViewModel.dataSource.filter({ AgendaModel in
                    AgendaModel.title.lowercased().contains(txt.lowercased())
                })
            }
            self.tableView.reloadData()

        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }

    // MARK: - IBOutlet
    
    @IBOutlet weak var txtFieldSearch: UITextField!
    @IBOutlet weak var btnSearchCancel: UIButton!
    private var firstConstraintBtnSeach: NSLayoutConstraint?
    private var secondConstraintBtnSeach: NSLayoutConstraint?
    private var agendaViewModel: AgendaViewModel = AgendaViewModel()
    private var dataSourceFiltred: [AgendaModel] = [AgendaModel]()
    
    // MARK: - Public let / var
    
    
    // MARK: - Private let / var
    
    
    // MARK: - IBAction
    
    @IBOutlet weak var tableView: UITableView!
}



// MARK: - Public Func
extension Agenda_ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AgendaCell", for: indexPath) as! Agenda_TableViewCell
        
        cell.titleEvent.text = self.dataSourceFiltred[indexPath.row].title
        cell.placeEvent.text = self.dataSourceFiltred[indexPath.row].address
        cell.addressEvent.text = self.dataSourceFiltred[indexPath.row].place
        cell.dateEvent.text = self.dataSourceFiltred[indexPath.row].date
        cell.hourEvent.text = self.dataSourceFiltred[indexPath.row].hour
        cell.imgEvent.image = UIImage(named: self.dataSourceFiltred[indexPath.row].img)


        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSourceFiltred.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - Private Func
extension Agenda_ViewController: UITextFieldDelegate{
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
extension Agenda_ViewController {
    
}

// MARK: - Other
extension Agenda_ViewController {
    
}
