//
//  Agenda+ViewController.swift
//  PoliticosTRC
//
//  Created by soliduSystem on 19/04/23.
//

/*
Clase llamada `Agenda_ViewController`, que es una subclase de `UIViewController`. La clase se utiliza para mostrar una lista de eventos en una agenda.

El código incluye varios métodos de ciclo de vida (`viewDidLoad()`, `viewWillAppear()`, `viewDidAppear()`, `viewWillDisappear()`, `viewDidDisappear()`) que se ejecutan en diferentes momentos del ciclo de vida de la vista.

El método `viewDidLoad()` realiza varias configuraciones iniciales, como establecer el origen de datos y el delegado de la tabla (`tableView`), registrar una celda personalizada para la tabla, configurar la altura de las filas, establecer el estilo de interfaz de usuario, y asignar los datos de la agenda al origen de datos filtrado.

El método `viewWillAppear()` se ejecuta antes de que la vista aparezca en pantalla. En este caso, establece una restricción para el botón de búsqueda (`btnSearchCancel`) si aún no se ha establecido.

El método `viewDidAppear()` se ejecuta después de que la vista aparece en pantalla.

El método `viewWillDisappear()` se ejecuta antes de que la vista desaparezca de la pantalla.

El método `viewDidDisappear()` se ejecuta después de que la vista ha desaparecido de la pantalla.

El método `seachBarValueChange(_:)` es un IBAction que se activa cuando se cambia el valor del campo de búsqueda (`txtFieldSearch`). Dependiendo del texto ingresado, filtra los datos de la agenda y actualiza la tabla con los resultados filtrados.

La propiedad `preferredStatusBarStyle` devuelve el estilo de la barra de estado de la vista, en este caso, `.lightContent`.

La clase también tiene varias propiedades IBOutlet que representan elementos de la interfaz de usuario, como el campo de búsqueda (`txtFieldSearch`), el botón de cancelar búsqueda (`btnSearchCancel`) y la tabla (`tableView`). Además, hay propiedades para el modelo de vista de la agenda (`agendaViewModel`) y los datos filtrados (`dataSourceFiltred`).

La clase implementa las funciones requeridas del protocolo `UITableViewDelegate` y `UITableViewDataSource` para configurar y mostrar los datos en la tabla. La función `cellForRowAt` configura las celdas de la tabla con los datos de los eventos, mientras que las funciones `numberOfRowsInSection` y `didSelectRowAt` especifican el número de filas y el comportamiento al seleccionar una fila, respectivamente.

Además, hay extensiones para implementar el protocolo `UITextFieldDelegate` y otros métodos o servicios adicionales, aunque en el código proporcionado no hay implementaciones específicas en estas secciones.

En resumen, la clase `Agenda_ViewController` se utiliza para mostrar una lista de eventos en una agenda en la aplicación "PoliticosTRC". Proporciona funcionalidad para filtrar los eventos mediante un campo de búsqueda y configura la apariencia y el comportamiento de la interfaz de usuario relacionada con la agenda.
*/

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
