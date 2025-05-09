//
//  PokemonA.swift
//  redes_sociales
//
//  Created by alumno on 5/7/25.
//

import SwiftUI

/// Representa una generación de Pokémon con sus datos esenciales
struct PokemonGeneration: Identifiable, Codable {
    let id: Int
    let name: String
    let mainRegion: String
    
    let pokemonSpecies: [PokemonSpecies]

}

