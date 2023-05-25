//
//  AgendaModel.swift
//  PoliticosTRC
//
//  Created by soliduSystem on 25/05/23.
//

/*
Definición de dos estructuras en Swift: TitleWithImg y AgendaModel. Estas estructuras se utilizan para representar datos relacionados con una agenda de políticos.

La estructura TitleWithImg tiene dos propiedades: title y img, que representan el título y la imagen asociada a algún elemento en la agenda.

La estructura AgendaModel tiene las siguientes propiedades:

title: representa el título o nombre del evento en la agenda.
place: representa el lugar donde se llevará a cabo el evento.
address: representa la dirección del lugar donde se llevará a cabo el evento.
date: representa la fecha del evento.
hour: representa la hora del evento.
img: representa la imagen asociada al evento.
Ambas estructuras están definidas dentro de un archivo llamado "AgendaModel.swift" y están destinadas a ser utilizadas en el contexto de una aplicación llamada "PoliticosTRC".
*/

import Foundation

struct TitleWithImg {
    let title: String
    let img: String
}


struct AgendaModel {
    let title: String
    let place: String
    let address: String
    let date: String
    let hour: String
    let img: String
}
