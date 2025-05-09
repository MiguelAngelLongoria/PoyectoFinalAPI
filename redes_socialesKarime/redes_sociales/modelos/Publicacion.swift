//
//  Publicacion.swift
//  redes_sociales
//
//  Created by alumno on 3/24/25.
//

import SwiftUI

struct Publicacion: Identifiable, Codable{
    let userId: Int
    let id: Int
    
    let title: String
    let body: String
}
