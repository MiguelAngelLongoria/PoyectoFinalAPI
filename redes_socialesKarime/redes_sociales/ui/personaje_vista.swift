//
//  personaje_vista.swift
//  redes_sociales
//
//  Created by alumno on 4/7/25.
//

import SwiftUI

struct PersonajeVista: View {
    @Environment(ControladorAplicacion.self) var controlador
    
    var body: some View {
        ScrollView{
            Text("\(controlador.personaje_seleccionado?.name ?? "Valor por defecto")")
                .font(Font.custom("Saiyan-Sans Left Oblique", size: 50))
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding()
                .shadow(color: Color.yellow, radius: 0, x: 5, y:5)
                
            
            AsyncImage(url: URL(string: "\(controlador.personaje_seleccionado?.image ?? "Valor por defecto")")){ image in
                image
                    .image?.resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 300)
            }.shadow(color: Color.yellow, radius: 0, x: 5, y:5)
            
            ZStack{
                Rectangle()
                    .foregroundColor(Color.white)
                    .cornerRadius(40)
                    .shadow(color: Color.yellow, radius: 0, x: 5, y:5)
                
                VStack{

                    Text("Raza: \(controlador.personaje_seleccionado?.race ?? "Valor por defecto")")
                    Text("Género: \(controlador.personaje_seleccionado?.gender ?? "Valor por defecto")")
                    Text("Afiliación: \(controlador.personaje_seleccionado?.affiliation ?? "Valor por defecto")")
                    
                    Text("Ki: \(controlador.personaje_seleccionado?.ki ?? "0")")
                    Text("Ki máximo: \(controlador.personaje_seleccionado?.maxKi ?? "0")")
                    
                }.padding()
                
            }.padding()
            
            

            ZStack{
                Rectangle()
                    .foregroundColor(Color.white)
                    .cornerRadius(40)
                    .shadow(color: Color.yellow, radius: 0, x: 5, y:5)
                
                Text("\(controlador.personaje_seleccionado?.description ?? "Aquí va la descripción de los personajes")")
                    .padding(30)
                    .multilineTextAlignment(.center)
                    
            }.padding()
            
            ZStack{
                Rectangle()
                    .foregroundColor(Color.white)
                    .cornerRadius(40)
                    .shadow(color: Color.yellow, radius: 0, x: 5, y:5)
                
                VStack{
                    Text("Planeta de origen")
                        .font(.title2)
                        .padding()
                    Divider()
                    AsyncImage(url: URL(string: "\(controlador.personaje_seleccionado?.originPlanet?.image ?? "Valor por defecto")")){ image in
                        image
                            .image?.resizable()
                            .scaledToFit()
                            .frame(width: 300)
                    }
                    Text("\(controlador.personaje_seleccionado?.originPlanet?.name ?? "Nombre de planeta")")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding()
                    Text("\(controlador.personaje_seleccionado?.originPlanet?.description ?? "Descripcion del planeta")")
                        .multilineTextAlignment(.center)
                        .padding()
                    if(controlador.personaje_seleccionado?.originPlanet?.isDestroyed == true){
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
            
            if(controlador.personaje_seleccionado?.transformations?.isEmpty == false){
                ZStack{
                    Rectangle()
                        .foregroundColor(Color.white)
                        .cornerRadius(40)
                        .shadow(color: Color.yellow, radius: 0, x: 5, y:5)
                    
                    VStack{
                        Text("Transformaciones")
                            .font(.title2)
                            .padding()
                        Divider()
                        
                        ForEach(controlador.personaje_seleccionado?.transformations ?? []){ transformacion in
                            HStack{
                                AsyncImage(url: URL(string: "\(transformacion.image ?? "Valor por defecto")")){ image in
                                    image
                                        .image?.resizable()
                                        .scaledToFit()
                                        .frame(width: 150, height: 300)
                                }
                                
                                VStack{
                                    Text("\(transformacion.name)")
                                        .padding(30)
                                        .multilineTextAlignment(.center)
                                    Text("Ki: \(transformacion.ki)")
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
    PersonajeVista()
        .environment(ControladorAplicacion())
}
