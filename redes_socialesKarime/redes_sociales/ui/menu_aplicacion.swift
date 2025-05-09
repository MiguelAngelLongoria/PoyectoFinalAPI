//
//  File.swift
//  redes_sociales
//
//  Created by alumno on 3/31/25.
//

import SwiftUI

struct MenuNavegacion: View {
    @Environment(ControladorAplicacion.self) var controlador
    
    var body: some View {
        TabView{
            GeneralPublicaciones()
                .tabItem { Label("Publicaciones", systemImage: "message") }
                .badge(controlador.publicaciones.count)
            
            PantallaPersonajes()
                .tabItem { Label("Dragon ball", systemImage: "cloud")}
            
            Text("Hola desde pantalla 3")
                .tabItem { Label("Etiqueta de esta label", systemImage: "phone") }
            
//            Text("Etiqueta", systemImage: "phone") {
//                Text("A")
//            }
        }
    }
}

#Preview {
    MenuNavegacion()
        .environment(ControladorAplicacion())
}
