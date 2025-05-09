//
//  PantallaDragonBall.swift
//  redes_sociales
//
//  Created by alumno on 5/2/25.
//

import SwiftUI

struct PantallaDragonBall: View {
    @Environment(ControladorAplicacion.self) var controlador
    
    @State var mostrar_personajes: Bool = false
    
    var body: some View {
        VStack{
            Spacer()
            VStack{
                Text("DragonBall API")
                HStack{
                    Button("Personajes"){
                        mostrar_personajes = true
                    }
                    Button("Planetas"){
                        
                    }
                }
            }
            Spacer()
        }.background(Color.orange)
    }
}

#Preview {
    PantallaDragonBall()
        .environment(ControladorAplicacion())
}
