//
//  MiembroModel.swift
//  PoliticosTRC
//
//  Created by soliduSystem on 25/05/23.
//

/*
Define varias estructuras en Swift relacionadas con un modelo de miembro. 

La estructura MiembroWithLevelPlain representa un miembro con su nivel de membresía. Tiene varias propiedades, como tag, tagMiembro, level, isHeader, name, numbresOfSimpatizantes, months, address, photo, telefono, INENumber y supportGranted. Estas propiedades representan diferentes atributos del miembro, como su identificador, nivel, nombre, número de simpatizantes, meses de membresía, dirección, foto, teléfono, número de INE y una lista de apoyos otorgados.

La estructura MiembroModelWithLevel representa un modelo de miembro con su nivel. Tiene propiedades como level, que es un objeto de tipo MiembroLevelModel que contiene el nivel del miembro, miembros que es una matriz de objetos MiembroModel que representan los miembros en sí, y isHeader que es un indicador booleano para identificar si el modelo de miembro es una cabecera.

La estructura MiembroModel representa un modelo de miembro con propiedades como name, numbresOfSimpatizantes, months, address, photo, telefono, INENumber, supportGranted y isHeader. Estas propiedades representan diferentes atributos del miembro, como su nombre, número de simpatizantes, meses de membresía, dirección, foto, teléfono, número de INE y una lista de apoyos otorgados. El indicador isHeader se utiliza para indicar si el modelo de miembro es una cabecera.

La estructura MiembroNameIs representa un nombre de miembro y si es un hombre o no. Tiene propiedades name que representa el nombre del miembro y isMan que es un indicador booleano para identificar si el miembro es un hombre.

La estructura SupportGranted representa un apoyo otorgado con propiedades como dateOfSupportGranted que representa la fecha del apoyo otorgado y supportedGranded que representa el tipo de apoyo otorgado.

La estructura MiembroLevelModel representa un modelo de nivel de miembro con una propiedad level que representa el nivel del miembro.
*/

import Foundation

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
