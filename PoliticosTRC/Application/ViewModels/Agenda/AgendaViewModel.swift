//
//  AgendaViewModel.swift
//  PoliticosTRC
//
//  Created by soliduSystem on 21/04/23.
//

import Foundation

class AgendaViewModel {
    
    public var dataSource = randomEvents()
    
    
    
    private static func randomEvents() ->  [AgendaModel] {
        
        let data = (0...100).map { _ in
            AgendaModel(
                title: titleEvent.shuffled().first!,
                place: places.shuffled().first!,
                address: address.shuffled().first!,
                date: dates.shuffled().first!,
                hour: hours.shuffled().first!,
                img: img.shuffled().first!)
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



struct AgendaModel {
    let title: String
    let place: String
    let address: String
    let date: String
    let hour: String
    let img: String
}
