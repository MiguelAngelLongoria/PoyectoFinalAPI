//
//  perfil_lista_basica.swift
//  redes_sociales
//
//  Created by alumno on 3/28/25.
//

import SwiftUI

struct PerfilBasicoVista: View {
    @Environment(ControladorAplicacion.self) var controlador
    
    
    var body: some View {
        Text("Nombre: \(controlador.perfil_a_mostrar?.name ?? "Valor por defecto")")
        Text("Nombre de usuario: \(controlador.perfil_a_mostrar?.username ?? "Valor por defecto")")
        Text("Correo: \(controlador.perfil_a_mostrar?.email ?? "Valor por defecto")")
        Text("Teléfono: \(controlador.perfil_a_mostrar?.phone ?? "Valor por defecto")")
    }
}

#Preview {
    PerfilBasicoVista()
        .environment(ControladorAplicacion())
}
