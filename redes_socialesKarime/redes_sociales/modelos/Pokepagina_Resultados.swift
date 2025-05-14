import SwiftUI

// Estructura para la página de resultados de Pokémon
struct Pokepagina_Resultados: Codable, Identifiable {
    let id = UUID() // Para conformar con Identifiable
    let items: [PokemonGeneration]
    let meta: Meta
    let links: Enlaces
}

// Pantalla principal de Pokémon
struct PokemonPantalla: View {
    @Environment(ControladorAplicacion.self) var controlador
    @State private var currentPage = 1
    
    var body: some View {
        if let paginaPokemon = controlador.paginaPokemon {
            NavigationStack {
                List {
                    ForEach(paginaPokemon.items) { generacion in
                        NavigationLink {
                            GeneracionDetalleVista(generacion: generacion)
                        } label: {
                            GeneracionRow(generacion: generacion)
                        }
                    }
                    
                    // Sección de paginación
                    if paginaPokemon.meta.totalPages > 1 {
                        HStack {
                            if currentPage > 1 {
                                Button(action: {
                                    currentPage -= 1
                                    loadPage(page: currentPage)
                                }) {
                                    Image(systemName: "arrow.left")
                                }
                            }
                            
                            Spacer()
                            
                            Text("Página \(currentPage) de \(paginaPokemon.meta.totalPages)")
                                .font(.caption)
                            
                            Spacer()
                            
                            if currentPage < paginaPokemon.meta.totalPages {
                                Button(action: {
                                    currentPage += 1
                                    loadPage(page: currentPage)
                                }) {
                                    Image(systemName: "arrow.right")
                                }
                            }
                        }
                        .padding()
                    }
                }
                .navigationTitle("Generaciones Pokémon")
                .refreshable {
                    await loadPage(page: currentPage)
                }
            }
        } else {
            ProgressView("Cargando Pokémon...")
                .task {
                    await loadPage(page: 1)
                }
        }
    }
    
    private func loadPage(page: Int) async {
        await controlador.cargarPaginaPokemon(page: page)
    }
}

// Vista de fila para cada generación
struct GeneracionRow: View {
    let generacion: PokemonGeneration
    
    var body: some View {
        HStack {
            Image(systemName: "leaf.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(.green)
            
            VStack(alignment: .leading) {
                Text(generacion.name)
                    .font(.headline)
                
                Text(generacion.mainRegion)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("\(generacion.pokemonSpecies.count) Pokémon")
                    .font(.caption)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
    }
}

// Vista de detalle de generación
struct GeneracionDetalleVista: View {
    let generacion: PokemonGeneration
    @State private var selectedBerry: PokemonBerry?
    
    var body: some View {
        List {
            Section("Información") {
                InfoRow(title: "Región", value: generacion.mainRegion)
                InfoRow(title: "Total Pokémon", value: "\(generacion.pokemonSpecies.count)")
            }
            
            Section("Pokémon") {
                ForEach(generacion.pokemonSpecies, id: \.name) { especie in
                    Text(especie.name.capitalized)
                }
            }
            
            Section("Bayas relacionadas") {
                // Aquí podrías mostrar bayas si las tienes en tu modelo
                Button("Ver bayas de esta región") {
                    // Acción para cargar bayas
                }
            }
        }
        .navigationTitle(generacion.name)
        .sheet(item: $selectedBerry) { berry in
            BerryDetailView(berry: berry)
        }
    }
}

// Componente reutilizable para filas de información
struct InfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .foregroundColor(.secondary)
        }
    }
}

// Vista de detalle para bayas (opcional)
struct BerryDetailView: View {
    let berry: PokemonBerry
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Información básica") {
                    InfoRow(title: "Nombre", value: berry.name.capitalized)
                    InfoRow(title: "Firmeza", value: berry.firmness.capitalized)
                    InfoRow(title: "Sabor dominante", value: berry.dominantFlavor.capitalized)
                }
                
                Section("Perfil de sabores") {
                    ForEach(berry.flavors.sorted(by: { $0.key < $1.key }), id: \.key) { flavor, potency in
                        HStack {
                            Text(flavor.capitalized)
                            Spacer()
                            ProgressView(value: Double(potency), total: 100)
                                .frame(width: 100)
                            Text("\(potency)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle(berry.name.capitalized)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// Previews
#Preview {
    PokemonPantalla()
        .environment(ControladorAplicacion())
}

struct GeneracionDetalleVista_Previews: PreviewProvider {
    static var previews: some View {
        GeneracionDetalleVista(generacion: PokemonGeneration(
            id: 1,
            name: "Generación Kanto",
            mainRegion: "Kanto",
            pokemonSpecies: [
                PokemonSpecies(name: "bulbasaur", url: ""),
                PokemonSpecies(name: "ivysaur", url: ""),
                PokemonSpecies(name: "venusaur", url: "")
            ]
        ))
    }
}
