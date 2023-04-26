//
//  MiembrosViewController.swift
//  PoliticosTRC
//
//  Created by soliduSystem on 21/04/23.
//

import Foundation

class MiembrosViewModel {
    
    var dataSoureMiembros : [MiembroModel] = miembrosGenerator(max: 60).shuffled()
    
    
    var dataSourceMiemborsWithLevel = [
        MiembroModelWithLevel(
            level: MiembroLevelModel(level: "Cordinador Estatal"),
            miembros: miembrosGenerator(max: 10).shuffled()),
        MiembroModelWithLevel(
            level: MiembroLevelModel(level: "Corordinador Regional"),
            miembros: miembrosGenerator(max: 20).shuffled()),
        MiembroModelWithLevel(
            level: MiembroLevelModel(level: "Coordinador Distrital"),
            miembros: miembrosGenerator(max: 30).shuffled()),
        MiembroModelWithLevel(
            level: MiembroLevelModel(level: "Coordinador de Sección"),
            miembros: miembrosGenerator(max: 40).shuffled()),
        MiembroModelWithLevel(
            level: MiembroLevelModel(level: "Lider de Colonia"),
            miembros: miembrosGenerator(max: 50).shuffled()),
    ]
    
    private static let miemborsName : [MiembroNameIs] = [
        MiembroNameIs(name: "Patricia López Rosales", isMan: false),
        MiembroNameIs(name: "Carlos Soler Martinez", isMan: true),
        MiembroNameIs(name: "Diana Suarez Dias", isMan: false),
        MiembroNameIs(name: "Alberto Alvarado Pro", isMan: true),
        MiembroNameIs(name: "Juan Rene Olivares Contreras", isMan: true),
        MiembroNameIs(name: "Victor Miguel Basurto Juarez", isMan: true),
    ].shuffled()
    
    private static var miembrosPhotoMale = (1...20).compactMap { Int in
        return "user_male\(Int)"
    }
    
    private static var miembrosPhotoFemale = (1...20).compactMap { idx in
        print(idx)

        return "user_female\(idx)"
    }
    
    
    private static func miembrosGenerator(max: Int) -> [MiembroModel] {
        
        return (0...max).compactMap { idx in
            
            let miembro = miemborsName.shuffled().first!
            let name = miembro.name
            let photo = miembro.isMan ? miembrosPhotoMale.shuffled().first! : miembrosPhotoFemale.shuffled().first!

            return MiembroModel(
                name: name,
                numbresOfSimpatizantes: "\(Int.random(in: 500...5000))",
                months: Int.random(in: 1...11),
                address: "",
                photo: photo,
                telefono: "8712655150",
                INENumber: "",
                supportGranted: [
                    SupportGranted(
                        dateOfSupportGranted: "04/02/23",
                        supportedGranded: "TINACO"),
                    SupportGranted(
                        dateOfSupportGranted: "28/02/23",
                        supportedGranded: "DESPENSA"),
                    SupportGranted(
                        dateOfSupportGranted: "10/03/25",
                        supportedGranded: "BOTE DE PINTURA"),
                    SupportGranted(
                        dateOfSupportGranted: "04/02/23",
                        supportedGranded: "DESPENSA"),
                ])
        }
    }
           
}


struct MiembroWithLevelPlain {
    var tag: Int = 69
    var tagMiembro = Int.random(in: 0...10101010)
    var level: String?
    var isHeader = true
    var name: String?
    var numbresOfSimpatizantes: String?
    var months: Int?
    var address: String?
    var photo: String?
    var telefono: String?
    var INENumber: String?
    var supportGranted: [SupportGranted]?

}

struct MiembroModelWithLevel {
    let level: MiembroLevelModel
    var miembros: [MiembroModel]
    let isHeader = true
}

struct MiembroModel {
    let name: String
    let numbresOfSimpatizantes: String
    let months: Int
    let address: String
    let photo: String
    let telefono: String
    let INENumber: String
    var supportGranted : [SupportGranted]
    let isHeader = false
}

struct MiembroNameIs{
    let name: String
    let isMan: Bool
}

struct SupportGranted {
    var dateOfSupportGranted: String
    var supportedGranded: String
}

struct MiembroLevelModel {
    let level: String
}
