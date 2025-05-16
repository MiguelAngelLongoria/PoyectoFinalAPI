import Foundation
import SwiftUI

// Modelo simplificado para Generación
struct PokemonGeneration: Identifiable, Codable{
/// The identifier for this generation resource
 let id: Int

/// The name for this generation resource
 let name: String?

/// The name of this generation listed in different languages
 let names: String?

/// A list of abilities that were introduced in this generation
 let abilities: String?

/// The main region travelled in this generation
 let mainRegion: String?

/// A list of moves that were introduced in this generation
 let moves: String?

/// A list of Pokémon species that were introduced in this generation
 let pokemonSpecies: String?

/// A list of types that were introduced in this generation
 let types: String?

/// A list of version groups that were introduced in this generation
 let versionGroups: String?

}
