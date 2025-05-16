struct Meta: Codable{
    let totalItems: Int
    let itemCount: Int
    let itemsPerPage: Int
    let totalPages: Int
    let currentPage: Int
}

struct PokeEnlaces: Codable{
    let first: String
    let previous: String
    let next: String
    let last: String
}

struct PokePaginaResultado: Codable {
    let items: [PokemonGeneration]
    let meta: Meta
    let links: Enlaces
}

struct PokePaginaResultadoPlaneta: Codable {
    let items: [PokemonEvolution]
    let meta: Meta
    let links: Enlaces
}
