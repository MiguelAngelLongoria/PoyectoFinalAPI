//
//  PokemonBerry.swift
//  redes_sociales
//
//  Created by alumno on 5/9/25.
//

import Foundation

struct PokemonBerry: Identifiable, Codable {
    let id: Int
    let name: String
    let firmness: String
    let dominantFlavor: String
    let flavors: [String: Int]
    
    /*
    
    enum CodingKeys: String, CodingKey {
        case id, name, firmness, flavors
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        
        // Decodificar firmness
        let firmnessContainer = try decoder.container(keyedBy: DynamicCodingKey.self)
            .nestedContainer(keyedBy: DynamicCodingKey.self, forKey: .init(stringValue: "firmness"))
        firmness = try firmnessContainer.decode(String.self, forKey: .init(stringValue: "name"))
        
        // Procesar sabores
        let flavorsArray = try container.decode([FlavorEntry].self, forKey: .flavors)
        flavors = Dictionary(uniqueKeysWithValues: flavorsArray.map { ($0.flavor.name, $0.potency) })
        
        // Determinar sabor dominante
        dominantFlavor = flavors.max(by: { $0.value < $1.value })?.key ?? "unknown"
    }
}

// Estructuras auxiliares
private struct FlavorEntry: Codable {
    let flavor: Flavor
    let potency: Int
}

private struct Flavor: Codable {
    let name: String
}

private struct DynamicCodingKey: CodingKey {
    var stringValue: String
    init(stringValue: String) { self.stringValue = stringValue }
    var intValue: Int? { nil }
    init?(intValue: Int) { nil }
}

// Extensión para previews
extension PokemonBerry {
    static var example: PokemonBerry {
        let json = """
        {
            "id": 1,
            "name": "cheri",
            "firmness": {"name": "soft", "url": ""},
            "flavors": [
                {"flavor": {"name": "spicy"}, "potency": 10},
                {"flavor": {"name": "dry"}, "potency": 0}
            ]
        }
        """.data(using: .utf8)!
        
        return try! JSONDecoder().decode(PokemonBerry.self, from: json)
    }
     */
}
