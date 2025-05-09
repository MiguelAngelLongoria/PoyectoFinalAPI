//
//  publicaciones_general.swift
//  redes_sociales
//
//  Created by alumno on 3/24/25.
//

import SwiftUI

struct GeneralPublicaciones: View {
    //    @StateObject var controlador = ControladorPublicaciones()
    @Environment(ControladorAplicacion.self) var controlador
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    ForEach(controlador.publicaciones){ publicacion in
                        NavigationLink {
                            PublicacionVista()
                        } label: {
                            HStack(alignment:.top){
                                ZStack{
                                    Circle()
                                        .stroke(.teal, lineWidth: 2)
                                        .frame(width: 40)
                                        .foregroundColor(.clear)
                                        .padding(5)
                                    Text("\(publicacion.id)")
                                        .tint(Color.teal)
                                }
                                VStack(alignment: .leading){
                                    Text("\(publicacion.title)")
                                        .font(.title2)
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                        .tint(Color.black)
                                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                                    Text("\(publicacion.body)")
                                        .tint(Color.black)
                                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                                    Divider()
                                        .padding()
                                }
                            }
                        }
                        .simultaneousGesture(TapGesture().onEnded({
                            controlador.seleccionar_publicacion(publicacion)
                        }))
                    }
                }.padding()
            }
        }
    }
}

#Preview {
    GeneralPublicaciones()
        .environment(ControladorAplicacion())
}
