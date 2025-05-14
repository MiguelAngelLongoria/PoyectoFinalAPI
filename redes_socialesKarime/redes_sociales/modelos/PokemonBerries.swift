//
//  PokemonBerry.swift
//  redes_sociales
//
//  Created by alumno on 5/9/25.
//

import Foundation

public struct PKMBerry: Identifiable, Codable {
    
    public let id: Int?
    
    public let name: String?
    
    public let growthTime: Int?
    
    public let maxHarvest: Int?
    
    public let naturalGiftPower: Int?
    
    public let size: Int?
    
    public let smoothness: Int?
    
    public let soilDryness: Int?
    
}
