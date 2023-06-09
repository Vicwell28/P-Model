//
//  AgendaViewModel.swift
//  PoliticosTRC
//
//  Created by soliduSystem on 21/04/23.
//

/*
Clase llamada `AgendaViewModel`.

La clase `AgendaViewModel` tiene una propiedad pública llamada `dataSource`, que se inicializa con el resultado de llamar a la función estática `randomEvents()`. Esta propiedad se utiliza como origen de datos para la agenda.

La clase también tiene varias variables estáticas privadas que contienen datos para la generación aleatoria de eventos de la agenda. Estos datos incluyen lugares (`places`), títulos de eventos (`titleEvent`), títulos de eventos con imágenes (`titleEventWithImg`), fechas (`dates`), horas (`hours`), direcciones (`address`) e imágenes (`img`).

La función estática privada `randomEvents()` se utiliza para generar eventos aleatorios para la agenda. Utiliza los datos de `titleEventWithImg`, `places`, `address`, `dates`, `hours` y genera objetos de tipo `AgendaModel`. Cada objeto `AgendaModel` contiene un título, lugar, dirección, fecha, hora e imagen de forma aleatoria seleccionados de las listas de datos.

En resumen, la clase `AgendaViewModel` se utiliza para proporcionar datos aleatorios para la agenda de políticos en la aplicación "PoliticosTRC". Los datos incluyen información sobre los eventos, como su título, lugar, dirección, fecha, hora e imagen.
*/

import Foundation

class AgendaViewModel {
    
    public var dataSource = randomEvents()
    
    
    
    private static func randomEvents() ->  [AgendaModel] {
        
        let data = self.titleEventWithImg.map { TitleWithImg in
            return AgendaModel(
                title: TitleWithImg.title,
                place: places.shuffled().first!,
                address: address.shuffled().first!,
                date: dates.shuffled().first!,
                hour: hours.shuffled().first!,
                img: TitleWithImg.img)
        }
        
        return data
    }
    
    
    private static var places: [String] = [
        "Torreón, Coahuila",
        "Monclova, Coahuila",
        "Saltillo, Coahuila",
    ].shuffled()
    
    
    private static var titleEvent: [String] = [
        "Reunión con empresarios",
        "Carrera a favor beneficecia",
        "Evento Cultural",
        "Graduación UAdeC"
    ].shuffled()
    
    
    private static var titleEventWithImg: [TitleWithImg] = [
        TitleWithImg(title: "Reunión con empresarios", img: "politicos_28"),
        TitleWithImg(title: "Carrera a favor beneficecia", img: "politicos_29"),
        TitleWithImg(title: "Evento Cultural", img: "politicos_30"),
        TitleWithImg(title: "Graduación UAdeC", img: "politicos_31"),
        TitleWithImg(title: "Reunión con empresarios", img: "politicos_28"),
        TitleWithImg(title: "Carrera a favor beneficecia", img: "politicos_29"),
        TitleWithImg(title: "Evento Cultural", img: "politicos_30"),
        TitleWithImg(title: "Graduación UAdeC", img: "politicos_31"),
    ]
    
    private static var dates: [String] = [
        "27 Abril 2023",
        "28 Abril 2023",
        "29 Abril 2023",
        "30 Abril 2023",
        "05 Mayo 2023",
        "10 Mayo 2023",
    ].shuffled()
    
    private static var hours: [String] = [
        "8:00 hrs",
        "9:00 hrs",
        "10:00 hrs",
        "12:00 hrs",
        "16:00 hrs",
        "17:00 hrs",
        "18:00 hrs",
        "19:00 hrs",
        "20:00 hrs",
    ].shuffled()
    
    private static var address: [String] = [
        "Centro de convenciones",
        "Calle Bravo esquina con Ave. Colón",
        "Teatro Degolado",
        "Facultad de Derecho",
    ].shuffled()
    
    private static var img: [String] = [
        "politicos_28",
        "politicos_29",
        "politicos_30",
        "politicos_31",
    ].shuffled()
    
    
}

