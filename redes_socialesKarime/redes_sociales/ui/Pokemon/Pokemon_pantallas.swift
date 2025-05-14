import SwiftUI

struct PokemonPantalla: View {
    @Environment(ControladorAplicacion.self) var controlador
    
    var body: some View {
        if let generaciones = controlador.Controlador_Pokemon {
            NavigationStack {
                ScrollView {
                    LazyVStack {
                        ForEach(generaciones) { generacion in
                            NavigationLink {
                                GeneracionDetalleVista(generacion: generacion)
                            } label: {
                                HStack {
                                    // Imagen representativa de la generación (podrías usar un icono o imagen específica)
                                    Image(systemName: "leaf.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 80, height: 80)
                                        .foregroundColor(.green)
                                        .shadow(color: .green, radius: 3, x: 0, y: 3)
                                        .padding()
                                    
                                    VStack(alignment: .leading) {
                                        Text(generacion.name)
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .padding(.bottom, 2)
                                        
                                        Divider()
                                        
                                        Text("Región: \(generacion.mainRegion)")
                                            .font(.subheadline)
                                        
                                        Text("Pokémon: \(generacion.pokemonSpecies.count)")
                                            .font(.subheadline)
                                    }
                                    .padding()
                                    .background(Color.white.cornerRadius(20).shadow(color: .green, radius: 3, x: 0, y: 3))
                                    .tint(.black)
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.top)
                }
                .background(Color.green.opacity(0.2))
                .navigationTitle("Generaciones Pokémon")
            }
        } else {
            ProgressView("Cargando generaciones...")
                .task {
                    await controlador.cargarGeneracionesPokemon()
                }
        }
    }
}

struct GeneracionDetalleVista: View {
    let generacion: PokemonGeneration
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(generacion.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Región principal: \(generacion.mainRegion)")
                    .font(.title2)
                
                Divider()
                
                Text("Pokémon en esta generación:")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))], spacing: 15) {
                    ForEach(generacion.pokemonSpecies) { especie in
                        VStack {
                            // Aquí podrías implementar AsyncImage para cargar imágenes de cada Pokémon
                            Image(systemName: "questionmark.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.blue)
                            
                            Text(especie.name)
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                        .background(Color.white.cornerRadius(10).shadow(radius: 3))
                    }
                }
            }
            .padding()
        }
        .background(Color.green.opacity(0.1))
        .navigationTitle(generacion.name)
    }
}

#Preview {
    PokemonPantalla()
        .environment(ControladorAplicacion())
}
