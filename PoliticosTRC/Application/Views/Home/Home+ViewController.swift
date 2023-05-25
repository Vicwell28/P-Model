//
//  Home+ViewController.swift
//  PoliticosTRC
//
//  Created by soliduSystem on 19/04/23.
//

/*
Implementación de la clase `Home_ViewController`, que es una subclase de `UIViewController`. 

- El código comienza importando el módulo necesario: `UIKit`.

- La clase `Home_ViewController` no contiene ninguna propiedad, variable ni método personalizado. Solo hereda los métodos de ciclo de vida de `UIViewController` y tiene una propiedad IBOutlet llamada `lastlbl`, que es una etiqueta de texto.

- Los métodos de ciclo de vida (`viewDidLoad`, `viewWillAppear`, etc.) están presentes, pero no tienen ninguna implementación personalizada. Estos métodos se heredan de `UIViewController` y se utilizan para configurar y administrar el ciclo de vida de la vista.

- El método `viewWillAppear` se implementa para ajustar el tamaño del `scrollView` para que sea lo suficientemente grande como para mostrar el contenido completo. Esto se logra estableciendo el tamaño del contenido en función de la posición y el tamaño de la etiqueta de texto (`lastlbl`).

- El método `preferredStatusBarStyle` se implementa para especificar que se desea utilizar un estilo de barra de estado clara (`lightContent`).

- El código contiene extensiones vacías para `Public Func`, `Private Func`, `Services` y `Other`. Estas extensiones proporcionan un espacio para agregar métodos y funciones adicionales en el futuro.

En resumen, el código define un controlador de vista de inicio (`Home_ViewController`) que no tiene funcionalidad personalizada más allá de ajustar el tamaño del contenido del `scrollView` y establecer el estilo de la barra de estado. Es posible que se haya creado este controlador de vista como un punto de partida para agregar más funcionalidades en el futuro.
*/


import UIKit

class Home_ViewController: UIViewController {
    
    // MARK: - Override Func
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.scrollView.contentSize = CGSize(width: 0, height: self.lastlbl.frame.origin.y + self.lastlbl.frame.size.height + 80)
        self.overrideUserInterfaceStyle = .light
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    @IBOutlet weak var lastlbl: UILabel!
    
    
    // MARK: - IBOutlet
    
    
    // MARK: - Public let / var
    
    
    // MARK: - Private let / var
    
    
    // MARK: - IBAction
    
    @IBOutlet weak var scrollView: UIScrollView!
    
}



// MARK: - Public Func
extension Home_ViewController {
    
}

// MARK: - Private Func
extension Home_ViewController {
    
}

// MARK: - Services
extension Home_ViewController {
    
}

// MARK: - Other
extension Home_ViewController {
    
}
