//
//  planteta_vista.swift
//  redes_sociales
//
//  Created by alumno on 5/2/25.
//

import SwiftUI

struct PlanetaVista: View {
    @Environment(ControladorAplicacion.self) var controlador
    
    var body: some View {
        ScrollView{
            Text("\(controlador.planeta_seleccionado?.name ?? "Valor por defecto")")
                .font(Font.custom("Saiyan-Sans Left Oblique", size: 50))
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding()
                .shadow(color: Color.yellow, radius: 0, x: 5, y:5)
            
            
            AsyncImage(url: URL(string: "\(controlador.planeta_seleccionado?.image ?? "Valor por defecto")")){ image in
                image
                    .image?.resizable()
                    .scaledToFit()
                    .frame(width: 300)
            }.shadow(color: Color.yellow, radius: 0, x: 5, y:5)
            
            ZStack{
                Rectangle()
                    .foregroundColor(Color.white)
                    .cornerRadius(40)
                    .shadow(color: Color.yellow, radius: 0, x: 5, y:5)
                
                VStack{

                    Text("\(controlador.planeta_seleccionado?.description ?? "Descripcion del planeta")")
                        .multilineTextAlignment(.center)
                        .padding()
                    if(controlador.planeta_seleccionado?.isDestroyed == true){
                        Text("Destruido: Si")
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    else{
                        Text("Destruido: No")
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                }.padding()
            }.padding()
            
            if(controlador.planeta_seleccionado?.personajes_afiliados?.isEmpty == false){
                ZStack{
                    Rectangle()
                        .foregroundColor(Color.white)
                        .cornerRadius(40)
                        .shadow(color: Color.yellow, radius: 0, x: 5, y:5)
                    
                    VStack{
                        Text("Personajes afiliados")
                            .font(.title2)
                            .padding()
                        Divider()
                        
                        ForEach(controlador.planeta_seleccionado?.personajes_afiliados ?? []){ personaje in
                            HStack{
                                AsyncImage(url: URL(string: "\(personaje.image ?? "Valor por defecto")")){ image in
                                    image
                                        .image?.resizable()
                                        .scaledToFit()
                                        .frame(width: 150, height: 300)
                                }
                                
                                VStack{
                                    Text("\(personaje.name)")
                                        .padding(30)
                                        .multilineTextAlignment(.center)
                                }
                            }
                        }
                    }
                    
                }.padding()
                
            }
            
        }.background(Color.orange)
    }
}

#Preview {
    PlanetaVista()
        .environment(ControladorAplicacion())
}
