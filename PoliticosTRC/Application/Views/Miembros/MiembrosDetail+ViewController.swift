//
//  MiembrosDetail+ViewController.swift
//  PoliticosTRC
//
//  Created by soliduSystem on 21/04/23.
//

/*
Implementación de una vista de detalle de un miembro. 

- La clase `MiembrosDetail_ViewController` hereda de `UIViewController` y contiene varias funciones de ciclo de vida, como `viewDidLoad()`, `viewWillAppear()`, etc.

- En `viewDidLoad()`, se configura el estilo de interfaz de usuario y no se realizan acciones adicionales.

- En `viewWillAppear()`, se configuran diferentes elementos de la vista, como la imagen de perfil, el tamaño de desplazamiento del scrollView, el texto de etiquetas, etc. También se muestra en la consola el valor de `miembroWithLevelPlain`.

- Las funciones `viewDidAppear()`, `viewWillDisappear()` y `viewDidDisappear()` no tienen implementaciones adicionales.

- Los elementos de interfaz de usuario, como `imgPerfil` (imagen de perfil), `lblName` (etiqueta de nombre) y `lblPuesto` (etiqueta de puesto), están conectados como salidas (`@IBOutlet`) para poder acceder y manipularlos en el código.

- La variable `miembroWithLevelPlain` es una propiedad pública de tipo `MiembroWithLevelPlain` que almacena la información del miembro que se muestra en la vista de detalle.

- Hay dos acciones (`@IBAction`) definidas en el código: `actionDown(_:)` y `actionUp(_:)`. Estas acciones están relacionadas con un botón y se ejecutan cuando el botón se presiona hacia abajo y se suelta, respectivamente. En `actionUp(_:)`, se anima el botón y se realiza una llamada telefónica utilizando el número de teléfono "8712655150".

- La función `callNumber(phoneNumber:)` se utiliza para realizar una llamada telefónica utilizando el número de teléfono proporcionado. Se construye una URL con el esquema "telprompt://" y el número de teléfono, y se abre la URL utilizando la aplicación de teléfono del dispositivo.

En resumen, este código implementa la lógica y la interfaz de usuario para la vista de detalle de un miembro en la aplicación "PoliticosTRC". Muestra la información del miembro, incluida su imagen de perfil, nombre y puesto, y permite realizar una llamada telefónica al miembro cuando se presiona un botón específico.
*/

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


