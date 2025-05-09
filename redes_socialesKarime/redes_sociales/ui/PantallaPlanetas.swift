//
//  PantallaPlanetas.swift
//  redes_sociales
//
//  Created by alumno on 5/2/25.
//

import SwiftUI

struct PantallaPlanetas: View {
    @Environment(ControladorAplicacion.self) var controlador
    
    var body: some View {
        if(controlador.pagina_resultados_planetas != nil){
            NavigationStack{
                ScrollView{
                    LazyVStack{
                        ForEach(controlador.pagina_resultados_planetas!.items){ planeta in
                            NavigationLink{
                                PlanetaVista()
                            } label: {
                                VStack{
                                    Text("\(planeta.name)")
                                        .font(.title)
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                        .padding()
                                    
                                    Divider()
                                    
                                    AsyncImage(url: URL(string: "\(planeta.image)")) { image in
                                        image
                                            .image?.resizable()
                                            .scaledToFit()
                                            .frame(width: 200)
                                            .padding()
                                    }
                                }
                                .frame(width: 300)
                                .shadow(color: Color.yellow, radius: 0, x: 5, y:5)
                                .padding()
                                .background(Color.white .cornerRadius(30) .shadow(color: Color.yellow, radius: 0, x: 5, y:5) )
                                .tint(Color.black)
                            }.simultaneousGesture(TapGesture().onEnded({
                                controlador.descargar_informacion_planeta(id: planeta.id)
                            }))
                            .padding()
                        }
                    }
                }.background(Color.orange)
            }.background(Color.orange)
        }
        Text("")
            .onAppear{
                Task{
                    await controlador.descargar_planetas()
                }
            }
    }
}

#Preview {
    PantallaPlanetas()
        .environment(ControladorAplicacion())
}
