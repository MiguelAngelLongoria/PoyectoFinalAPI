//
//  ContentView.swift
//  redes_sociales
//
//  Created by alumno on 3/24/25.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @State var foto_seleccionada: PhotosPickerItem? = nil
    @State var foto_a_mostrar: UIImage? = nil
    var body: some View {
        PhotosPicker(selection: $foto_seleccionada){
            Image(uiImage: foto_a_mostrar ?? UIImage(resource: .avatar))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                .clipShape(.circle)
        }
        .onChange(of: foto_seleccionada){valor_anterior, valor_nuevo in
            Task{
                if let foto_seleccionada, let datos = try? await foto_seleccionada.loadTransferable(type: Data.self){
                    if let image = UIImage(data: datos){
                        foto_a_mostrar = image
                    }
                }
            }
        }
        
        GeneralPublicaciones()
    }
}

#Preview {
    ContentView()
        .environment(ControladorAplicacion())
}
