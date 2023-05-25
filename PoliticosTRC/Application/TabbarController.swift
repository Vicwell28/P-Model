//
//  TabbarController.swift
//  PoliticosTRC
//
//  Created by soliduSystem on 19/04/23.
//

/*
Implementación de un controlador de pestañas (`UITabBarController`) en iOS utilizando Swift y UIKit. El controlador de pestañas se define en la clase `TabbarController`, que hereda de `UITabBarController`.

A continuación se muestra una descripción general del código:

1. Se importa el módulo UIKit para acceder a las clases y funciones necesarias.

2. Se define la clase `TabbarController` que hereda de `UITabBarController`.

3. Se declaran varias propiedades privadas, como `myView`, `myViewBackground`, `myImageLogo` y `myHStack`, que se utilizan para crear la interfaz de usuario de la barra de pestañas.

4. Se inicializa un array llamado `dataSourceTapItems` que contiene objetos de la estructura `TapItems`. Cada objeto `TapItems` representa un elemento de pestaña y contiene un índice, una imagen y un nombre.

5. En el método `viewWillAppear`, se crea la interfaz de usuario de la barra de pestañas si no se ha creado antes. Esto se hace configurando varias vistas (`UIView`), etiquetas (`UILabel`), imágenes (`UIImageView`) y botones (`UIButton`) de acuerdo con los datos proporcionados en `dataSourceTapItems`.

6. Se agregan restricciones de autolayout a las vistas creadas para definir su posición y tamaño en relación con otras vistas.

7. Se implementa la función `selectedIndexTap` como un selector de acción para los botones de las pestañas. Esta función se ejecuta cuando se selecciona una pestaña y realiza algunas operaciones, como cambiar el color de fondo de la vista de la pestaña seleccionada y realizar animaciones en las vistas de etiquetas e imágenes de la pestaña seleccionada.

8. La estructura `TapItems` se define para representar los datos de cada elemento de pestaña. Tiene propiedades como `index` (índice de la pestaña), `image` (nombre de la imagen) y `name` (nombre de la pestaña).

En general, este código crea una barra de pestañas personalizada en la que cada pestaña tiene una imagen y un nombre. Al seleccionar una pestaña, se realizan cambios visuales en la interfaz de usuario para resaltar la pestaña seleccionada.
*/

import UIKit

class TabbarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        if !self.isDraw {
            self.isDraw = true
            
            
            myView.tag = 999
            myViewBackground.tag = 999
            myImageLogo.tag = 999
            myHStack.tag = 999
            
            self.myView.backgroundColor = UIColor.FirstColor
            self.myView.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(self.myView)
            self.myView.maskToBounds = true
            
            let cornerRadius: CGFloat = 30.0
            let maskedCorners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            self.myView.layer.cornerRadius = cornerRadius
            self.myView.layer.maskedCorners = maskedCorners
            
            
            self.view.addConstraints([
                NSLayoutConstraint(item: self.myView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 70),
                NSLayoutConstraint(item: self.myView, attribute: .bottom, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self.myView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self.myView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
            ])
            
            self.myViewBackground.backgroundColor = UIColor.FirstColor
            self.myViewBackground.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(self.myViewBackground)
            
            self.view.addConstraints([
                NSLayoutConstraint(item: self.myViewBackground, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self.myViewBackground, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self.myViewBackground, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self.myViewBackground, attribute: .top, relatedBy: .equal, toItem: self.myView, attribute: .bottom, multiplier: 1, constant: 0),
            ])
            
            self.dataSourceTapItems.forEach { TapItems in
                let containerViews = UIView()
                containerViews.tag = TapItems.index
                
                let lable = UILabel()
                lable.text = TapItems.name
                lable.font = UIFont(name: "Avenir Next Bold", size: 12)
                lable.textColor = UIColor.white
                lable.translatesAutoresizingMaskIntoConstraints = false
                lable.textAlignment = .center
                lable.numberOfLines =  2
                lable.adjustsFontSizeToFitWidth = true
                lable.minimumScaleFactor = 0.2
                lable.tag = 91
                containerViews.addSubview(lable)
                
                containerViews.addConstraints([
                    NSLayoutConstraint(item: lable, attribute: .bottom, relatedBy: .equal, toItem: containerViews, attribute: .bottom, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: lable, attribute: .leading, relatedBy: .equal, toItem: containerViews, attribute: .leading, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: lable, attribute: .trailing, relatedBy: .equal, toItem: containerViews, attribute: .trailing, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: lable, attribute: .height, relatedBy: .equal, toItem: containerViews, attribute: .height, multiplier: 0.4, constant: 0),
                ])
                
                
                let imgView = UIImageView(image: UIImage(named: TapItems.image))
                imgView.sizeToFit()
                imgView.translatesAutoresizingMaskIntoConstraints = false
                imgView.sizeToFit()
                imgView.tag = 92
                
                containerViews.addSubview(imgView)
                
                containerViews.addConstraints([
                    NSLayoutConstraint(item: imgView, attribute: .bottom, relatedBy: .equal, toItem: lable, attribute: .top, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: imgView, attribute: .centerX, relatedBy: .equal, toItem: containerViews, attribute: .centerX, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: imgView, attribute: .height, relatedBy: .equal, toItem: containerViews, attribute: .height, multiplier: 0.5, constant: 0),
                    NSLayoutConstraint(item: imgView, attribute: .width, relatedBy: .equal, toItem: imgView, attribute: .height, multiplier: 1.0, constant: 0),
                ])
                
                
                let btn = UIButton()
                btn.tag = TapItems.index
                btn.addTarget(self, action: #selector(selectedIndexTap), for: .touchUpInside)
                btn.translatesAutoresizingMaskIntoConstraints = false
                containerViews.addSubview(btn)
                
                containerViews.addConstraints([
                    NSLayoutConstraint(item: btn, attribute: .bottom, relatedBy: .equal, toItem: containerViews, attribute: .bottom, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: btn, attribute: .leading, relatedBy: .equal, toItem: containerViews, attribute: .leading, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: btn, attribute: .trailing, relatedBy: .equal, toItem: containerViews, attribute: .trailing, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: btn, attribute: .top, relatedBy: .equal, toItem: containerViews, attribute: .top, multiplier: 1, constant: 0),
                ])
                
                if TapItems.index == 0 {
                    btn.superview!.backgroundColor = UIColor.SecondColor
                    print("ESte es el bton \(btn.superview!)")
                    print("ESte es el bton \(containerViews)")
                }
                
                
                self.myHStack.addArrangedSubview(containerViews)
            }
            
            self.myHStack.translatesAutoresizingMaskIntoConstraints = false
            self.myView.addSubview(self.myHStack)
            self.myHStack.alignment = .center
            self.myHStack.distribution = .fillEqually
            self.myHStack.axis = .horizontal
            
            myView.addConstraints([
                NSLayoutConstraint(item: self.myHStack, attribute: .top, relatedBy: .equal, toItem: self.myView, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self.myHStack, attribute: .bottom, relatedBy: .equal, toItem: self.myView, attribute: .bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self.myHStack, attribute: .trailing, relatedBy: .equal, toItem: self.myView, attribute: .trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: self.myHStack, attribute: .leading, relatedBy: .equal, toItem: self.myView, attribute: .leading, multiplier: 1, constant: 0),
            ])
        }
    }
    
    private let myView = UIView()
    private let myViewBackground = UIView()
    private let myImageLogo = UIImageView(image: UIImage(named: "politicos_4"))
    private let myHStack = UIStackView()
    private var isDraw: Bool = false
    
    private var dataSourceTapItems : [TapItems] = [
        TapItems(index: 0, image: "politicos_5", name: "Inicio"),
        TapItems(index: 1, image: "politicos_6", name: "Miembros"),
        TapItems(index: 2, image: "politicos_7", name: "Simpatizantes"),
        TapItems(index: 3, image: "politicos_8", name: "Reporte Ciudadano"),
        TapItems(index: 4, image: "politicos_9", name: "Agenda"),
    ]
    
    @objc func selectedIndexTap(sender: UIButton) -> Void {
        
        (self.myHStack.viewWithTag(self.dataSourceTapItems[self.selectedIndex].index)!).backgroundColor = UIColor.FirstColor
        self.selectedIndex = sender.tag
        sender.superview!.backgroundColor = UIColor.SecondColor
        
        self.selectedIndex = sender.tag
        
        
        UIView.animate(withDuration: 0.1) {
            self.myHStack.viewWithTag(self.dataSourceTapItems[self.selectedIndex].index)!.viewWithTag(91)!.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.myHStack.viewWithTag(self.dataSourceTapItems[self.selectedIndex].index)!.viewWithTag(92)!.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        } completion: { Bool in
            
            UIView.animate(withDuration: 0.1) {
                self.myHStack.viewWithTag(self.dataSourceTapItems[self.selectedIndex].index)!.viewWithTag(91)!.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.myHStack.viewWithTag(self.dataSourceTapItems[self.selectedIndex].index)!.viewWithTag(92)!.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
        
        
    }
    
    
    
}

struct TapItems {
    let index: Int
    let image: String
    let name: String
}

