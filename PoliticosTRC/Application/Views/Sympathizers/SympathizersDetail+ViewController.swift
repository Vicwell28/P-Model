//
//  SympathizersDetail+ViewController.swift
//  PoliticosTRC
//
//  Created by soliduSystem on 21/04/23.
//


/*
El código proporcionado es para una vista de detalle de simpatizantes en una aplicación llamada "PoliticosTRC". La clase `SympathizersDetail_ViewController` hereda de `UIViewController` y contiene varias funciones de anulación y propiedades relacionadas con la visualización y la interacción del usuario.

Aquí hay una descripción general de las secciones principales del código:

- En el método `viewDidLoad`, se registran las celdas de la tabla, se establecen los delegados de la tabla y se configuran las alturas de las filas. También se inicializan algunas propiedades y se asignan datos a la fuente de datos filtrada.

- En el método `viewWillAppear`, se configuran varios elementos de la interfaz de usuario, como la imagen de perfil, el nombre y la duración de ser simpatizante. También se configuran las restricciones de diseño para la barra de búsqueda si aún no se han configurado.

- En el método `viewDidAppear`, no hay ninguna lógica específica implementada.

- En el método `viewWillDisappear` y `viewDidDisappear`, tampoco hay ninguna lógica específica implementada.

- Hay varias propiedades `IBOutlet` que están conectadas a elementos de la interfaz de usuario en el Storyboard, como botones, vistas de tabla, imágenes y etiquetas.

- Hay algunas acciones `IBAction` que se activan cuando se realiza una acción en elementos de la interfaz de usuario, como botones. Por ejemplo, los métodos `actionDown` y `actionUp` se utilizan para animar un botón cuando se presiona y se suelta.

- Hay una extensión para `UIImageView` que proporciona un método `setCircle()` para redondear la imagen de perfil.

- Hay extensiones para implementar los protocolos `UITextFieldDelegate`, `UITableViewDelegate` y `UITableViewDataSource`. Estas extensiones contienen la lógica para configurar las celdas y manejar eventos como la selección de filas y la edición de texto en el campo de búsqueda.

- La clase también tiene una propiedad `miembroDetail` de tipo `MiembroModel`, que almacena información sobre el simpatizante actual. La información se utiliza para configurar la vista de detalle.

- La clase también tiene algunas propiedades privadas que almacenan datos relacionados con el apoyo recibido por el simpatizante y los datos filtrados para la búsqueda en la tabla.

- Las extensiones `Private Func` y `Services` están vacías y no contienen ninguna lógica específica.

En general, este código implementa la funcionalidad de visualización y búsqueda de detalles de simpatizantes en una aplicación. Proporciona una interfaz de usuario para mostrar la información del simpatizante, así como el historial de apoyo recibido. También permite al usuario buscar en la lista de apoyos y agregar nuevos apoyos al simpatizante.
*/

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
        
        
        self.dataSourceFiltred = self.dataSourceSupported
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.imgPerfil.image = UIImage(named: self.miembroDetail!.photo)
        self.lblName.text = self.miembroDetail!.name
        self.lblDate.text = "Simpatizante desde hace \(self.miembroDetail!.months) meses"
        self.imgPerfil.setCircle()
        
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
    
    @IBOutlet weak var btnCloseAddSupport: UIButton!
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    // MARK: - IBOutlet
    @IBOutlet weak var viewSearch: UIControl!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imgPerfil: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var txtFieldSearch: UITextField!
    @IBOutlet weak var btnSearchCancel: UIButton!
    // MARK: - Public let / var
    @IBOutlet weak var tableViewSupport: UITableView!
    private var firstConstraintBtnSeach: NSLayoutConstraint?
    private var secondConstraintBtnSeach: NSLayoutConstraint?
    
    private let dataSourceSupported: [String] = [
        "Tinaco",
        "Huevo",
        "Despensa",
        "Pintura"
    ].shuffled()
    
    private var dataSourceFiltred = [String]()
    
    
    
    
    
    @IBAction func seachBarValueChange(_ sender: UITextField) {
        if let txt = sender.text {
            if txt.isEmpty {
                print("Lo dejo vacio")
                self.dataSourceFiltred = self.dataSourceSupported
            } else {
                print("Texto buscado: \(txt)")
                self.dataSourceFiltred = self.dataSourceSupported.filter({ MiembroModel in
                    MiembroModel.lowercased().contains(txt.lowercased())
                })
            }
            self.tableView.reloadData()
        }
    }
    
    
    
    
    
    
    // MARK: - Private let / var
    public var miembroDetail : MiembroModel!
    
    @IBAction func dissmisViewVisualEffect(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.25) {
            self.viewSearch.alpha = 0
        } completion: { Bool in
            self.viewSearch.isHidden.toggle()
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
            self.viewSearch.isHidden.toggle()
            self.view.bringSubviewToFront(self.viewSearch)
            self.viewSearch.alpha = 0
            UIView.animate(withDuration: 0.25) {
                self.viewSearch.alpha = 1
            }
        }
    }
}

extension UIImageView {
    func setCircle() -> Void {
        self.layer.cornerRadius = self.frame.size.width / 2
    }
}

extension SympathizersDetail_ViewController: UITextFieldDelegate{
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
        
        cell.lblUnique.text = self.dataSourceFiltred[indexPath.row].uppercased()
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.tableView {
            return self.miembroDetail!.supportGranted.count
        }
        
        return self.dataSourceFiltred.count
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView == self.tableViewSupport {
            
            let support = self.dataSourceFiltred[indexPath.row]
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
                self.viewSearch.alpha = 0
            } completion: { Bool in
                self.viewSearch.isHidden.toggle()
                
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
