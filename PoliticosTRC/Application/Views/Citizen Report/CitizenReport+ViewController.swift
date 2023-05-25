//
//  CitizenReport+ViewController.swift
//  PoliticosTRC
//
//  Created by soliduSystem on 19/04/23.
//

/*
Implementación de la clase `CitizenReport_ViewController`, que es una subclase de `UIViewController`. 

- El código comienza importando los módulos necesarios: `UIKit`, `MapKit` y `CoreLocation`.

- La clase `CitizenReport_ViewController` declara propiedades y variables, incluyendo elementos de IU (`IBOutlet`) como botones, vistas de imagen y vistas de mapa (`mapKit`). También hay propiedades relacionadas con la ubicación y la gestión de ubicaciones, como `locationManager` y `currentLocation`.

- Hay varios métodos de ciclo de vida (`viewDidLoad`, `viewWillAppear`, etc.) que se utilizan para configurar y administrar el ciclo de vida de la vista.

- Dentro de `viewWillAppear`, se configuran algunas propiedades de las vistas de imagen, como esquinas redondeadas, sombras y máscaras de capa.

- Los métodos `actionDown` y `actionUp` son controladores de eventos para los botones. En `actionUp`, se realiza una animación y luego se restablecen algunos elementos de la interfaz de usuario a su estado inicial.
- Los métodos `actionSelectImageReprot` y `tapBtnReport` son controladores de eventos para los botones relacionados con la selección de imágenes y el informe de ciudadano. Estos métodos actualizan la interfaz de usuario en respuesta a las interacciones del usuario.

- Hay dos enumeraciones definidas, `UnselectedImageCitizenReport` y `SelectedImageCitizenReport`, que contienen nombres de imágenes utilizadas en el informe de ciudadano.

- La extensión `CitizenReport_ViewController` contiene métodos y funciones adicionales, como `showAlerActionSheet`, que muestra un menú de acción para tomar una foto o abrir la galería, y métodos relacionados con la selección de imágenes y la administración del texto del informe (`UITextViewDelegate`).

- También hay extensiones para servicios específicos, como la administración de ubicaciones (`CLLocationManagerDelegate`) y la administración del mapa (`MKMapViewDelegate`).

En resumen, el código define una vista de controlador de informe de ciudadano que permite al usuario seleccionar una categoría de informe, agregar una descripción y adjuntar imágenes. También se utiliza Core Location y MapKit para mostrar la ubicación del usuario en un mapa.
*/

import UIKit
import MapKit
import CoreLocation

class CitizenReport_ViewController: UIViewController {
    
    // MARK: - Override Func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager?.distanceFilter = 1000
        self.locationManager?.requestAlwaysAuthorization()
        self.locationManager?.requestWhenInUseAuthorization()
        
        self.mapKit.showsUserLocation = true
        self.mapKit.userTrackingMode = .follow
        self.mapKit.delegate = self
        self.overrideUserInterfaceStyle = .light
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.scrollView.contentSize = CGSizeMake(0, self.btnSendReport.frame.origin.y + self.btnSendReport.frame.height + 80)
        
        self.ImageViewsReportCollection.forEach { UIImageView in
            UIImageView.layer.cornerRadius = UIImageView.frame.size.width / 1.8
            UIImageView.layer.shadowColor = UIColor.gray.cgColor
            UIImageView.layer.shadowOffset = CGSize(width: 0, height: 5)
            UIImageView.layer.shadowOpacity = 0.5
            UIImageView.layer.masksToBounds = false
            UIImageView.layer.shadowRadius = 1
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var txvDescReport: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btnSendReport: UIButton!
    //    private var indexImageReport: Int = 0
    private var buttonSenderImageReprot: UIButton!
    // MARK: - Public let / var
    
    @IBOutlet weak var viewCorrect: UIView!
    
    @IBOutlet var btnCollectionImageReport: [UIButton]!
    
    
    @IBOutlet var imgCollectionReport: [UIImageView]!
    // MARK: - Private let / var
    private var indexReport : Int?
    @IBOutlet var btnsReportCollection: [UIButton]!
    @IBOutlet var ImageViewsReportCollection: [UIImageView]!
    
    public var locationManager : CLLocationManager?
    var currentLocation: CLLocation?
    @IBOutlet weak var mapKit: MKMapView!
    
    
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
            self.showViewControllerLoader()
            
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { Timer in
                self.dismissViewControllerLoader()
                
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
                
                
                
                self.btnCollectionImageReport.forEach { UIButton in
                    UIButton.isHidden = false
                }
                
                self.imgCollectionReport.forEach { UIImageView in
                    UIImageView.image = UIImage()
                }
                
                self.txvDescReport.text = "Descripción..."
                self.txvDescReport.textColor = UIColor.systemGray3
                
                self.ImageViewsReportCollection.forEach { UIImageView in
                    UIImageView.superview!.transform = .identity
                }
                
                self.ImageViewsReportCollection.enumerated().forEach { idx, ele in
                    ele.image = UIImage(named: self.UnSelectedReport[idx]!)
                }
                
                self.indexReport = nil
                self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            }
        }
    }
    
    @IBAction func actionSelectImageReprot(_ sender: UIButton) {
        self.buttonSenderImageReprot = sender
        self.showAlerActionSheet()
    }
    
    @IBAction func tapBtnReport(_ sender: UIButton) {
        
        
        if self.indexReport == nil {
            //VA A SELECCIONAR POR PRIMER VEZ
            self.indexReport = sender.tag
            
            print(SelectedReport[self.indexReport!]!)
            
            self.ImageViewsReportCollection[self.indexReport!].image = UIImage(named: SelectedReport[self.indexReport!]!)
            UIView.animate(withDuration: 0.25) {
                self.ImageViewsReportCollection[self.indexReport!].superview!.transform = CGAffineTransform(translationX: 0, y: -5)
            }
            
            return
        }
        
        UIView.animate(withDuration: 0.25) {
            self.ImageViewsReportCollection[self.indexReport!].superview!.transform = CGAffineTransform(translationX: 0, y: 0)
        }
        self.ImageViewsReportCollection[self.indexReport!].image = UIImage(named: UnSelectedReport[self.indexReport!]!)
        self.indexReport = sender.tag
        self.ImageViewsReportCollection[self.indexReport!].image = UIImage(named: SelectedReport[self.indexReport!]!)
        UIView.animate(withDuration: 0.25) {
            self.ImageViewsReportCollection[self.indexReport!].superview!.transform = CGAffineTransform(translationX: 0, y: -5)
        }
    }
    
    
    let UnSelectedReport: [Int: String] = [
        0: UnselectedImageCitizenReport.seguridad.rawValue,
        1: UnselectedImageCitizenReport.bomberos.rawValue,
        2: UnselectedImageCitizenReport.vialidad.rawValue,
        3: UnselectedImageCitizenReport.salud.rawValue
    ]
    
    let SelectedReport: [Int: String] = [
        0: SelectedImageCitizenReport.seguridad.rawValue,
        1: SelectedImageCitizenReport.bomberos.rawValue,
        2: SelectedImageCitizenReport.vialidad.rawValue,
        3: SelectedImageCitizenReport.salud.rawValue
    ]
    
    
    
    
}


enum UnselectedImageCitizenReport: String {
    case seguridad = "politicos_12"
    case bomberos = "politicos_14"
    case vialidad = "politicos_16"
    case salud = "politicos_18"
}

enum SelectedImageCitizenReport: String {
    case seguridad = "politicos_13"
    case bomberos = "politicos_15"
    case vialidad = "politicos_17"
    case salud = "politicos_19"
}


// MARK: - Public Func
extension CitizenReport_ViewController {
    
    
    
}

// MARK: - Private Func
extension CitizenReport_ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
        
        self.btnCollectionImageReport[self.buttonSenderImageReprot.tag].isHidden = true
        self.imgCollectionReport[self.buttonSenderImageReprot.tag].image = image
    }
    
}

// MARK: - Services
extension CitizenReport_ViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == self.txvDescReport {
            if let text = self.txvDescReport.text, text.isEmpty {
                self.txvDescReport.text = "Descripción..."
                self.txvDescReport.textColor = UIColor.systemGray3
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == self.txvDescReport {
            if let text = self.txvDescReport.text, !text.isEmpty && text == "Descripción..." {
                print("Etnron en el if")
                self.txvDescReport.text = ""
                self.txvDescReport.textColor = UIColor.black
            }
        }
    }
    
}
// MARK: - Other
extension CitizenReport_ViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {")
        
        guard let currentLocation = locations.last else { return }
        self.currentLocation = currentLocation
        
        let center = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        self.mapKit.setRegion(region, animated: true)
    }
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(manager.authorizationStatus)
        
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways :
            manager.startUpdatingLocation()
            break
        case .denied:
            print("Denied")
            break
        case .restricted:
            print("restricted")
            break
        case .notDetermined:
            print("notDetermined")
            break
        @unknown default:
            print(manager.authorizationStatus)
        }
    }
}


// MARK: - Other
extension CitizenReport_ViewController: MKMapViewDelegate {
    
}
