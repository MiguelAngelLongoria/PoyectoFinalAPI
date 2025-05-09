//
//  PantallaPersonajes.swift
//  redes_sociales
//
//  Created by alumno on 4/4/25.
//

import SwiftUI

struct PantallaPersonajes: View {
    @Environment(ControladorAplicacion.self) var controlador
    
    var body: some View {
        if(controlador.pagina_resultados != nil){
            NavigationStack{
                ScrollView{
                    LazyVStack{
                        ForEach(controlador.pagina_resultados!.items){ personaje in
                            NavigationLink{
                                PersonajeVista()
                            } label: {
                                HStack{
                                    AsyncImage(url: URL(string: "\(personaje.image)")) { image in
                                        image
                                            .image?.resizable()
                                            .scaledToFit()
                                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 250)
                                    } .shadow(color: Color.yellow, radius: 0, x: 5, y:5)
                                        .padding()
                                    VStack{
                                        Text("\(personaje.name)")
                                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                            .padding()
                                        
                                        Divider()
                                        
                                        Text("\(personaje.race)")
                                        
                                        Text("\(personaje.affiliation)")
                                        
                                    }
                                    .padding()
                                    .background(Color.white .cornerRadius(30) .shadow(color: Color.yellow, radius: 0, x: 5, y:5) )
                                    .tint(Color.black)
                                    
                                    Divider()
                                }
                                .padding()
                                
                            }.simultaneousGesture(TapGesture().onEnded({
                                controlador.descargar_informacion_personaje(id: personaje.id)
                            }))
                            
                        }
                    }
                } .background(Color.orange)
            }
        }
    }
}

#Preview {
    PantallaPersonajes()
        .environment(ControladorAplicacion())
}
