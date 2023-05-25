//
//  MiembroModel.swift
//  PoliticosTRC
//
//  Created by soliduSystem on 25/05/23.
//

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
