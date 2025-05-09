//
//  comentario.swift
//  redes_sociales
//
//  Created by alumno on 3/26/25.
//
import SwiftUI

struct Comentario: Identifiable, Codable{
        let postId: Int
        let id: Int
        let name: String
        let email: String
        let body: String
}
