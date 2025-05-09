//
//  File.swift
//  redes_sociales
//
//  Created by alumno on 3/26/25.
//

import SwiftUI

let publicacion_falsa = Publicacion(userId: 1, id: 1, title: "Lorem Ipsum", body: "Et dolor si asem")

struct PublicacionVista: View {
    @Environment(ControladorAplicacion.self) var controlador
    
    var body: some View {
        Text("\(controlador.publicacion_seleccionada?.title ?? "Valor por defecto")")
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .padding()
        Divider()
        Text("\(controlador.publicacion_seleccionada?.body ?? "Valor por defecto")")
            .padding()
        
        NavigationLink{
            PerfilBasicoVista()
        } label: {
            Text("Ver perfil")
        }
        .simultaneousGesture(TapGesture().onEnded({
            controlador.ver_perfil(id: controlador.publicacion_seleccionada!.userId)
        }))
        .foregroundColor(Color.teal)
        
        
        Divider()
        
        ScrollView{
            VStack{
                ForEach(controlador.comentarios){ comentario in
                    VStack(alignment: .leading){
                        Text("Usuario: \(controlador.perfil_a_mostrar?.username)")
                            .font(.title3)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Text("\(comentario.name)")
                        Text("\(comentario.body)")
                            .padding()
                    }
                    Divider()
                }
            }
        }
    }
}

#Preview {
    NavigationStack{
        PublicacionVista()
            .environment(ControladorAplicacion())
    }
}
