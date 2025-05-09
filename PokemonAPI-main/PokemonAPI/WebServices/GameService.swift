//
//  GameService.swift
//  PokemonAPI
//
//  Created by Christopher Jennewein on 6/13/20.
//  Copyright © 2020 Prismatic Games. All rights reserved.
//

import Foundation


protocol PKMGameService: HTTPWebService {
    func fetchGenerationList(paginationState: PaginationState<PKMGeneration>) async throws -> PKMPagedObject<PKMGeneration>
    func fetchGeneration(_ generationID: Int) async throws -> PKMGeneration
    func fetchGeneration(_ generationName: String) async throws -> PKMGeneration
    func fetchPokedexList(paginationState: PaginationState<PKMPokedex>) async throws -> PKMPagedObject<PKMPokedex>
    func fetchPokedex(_ pokedexID: Int) async throws -> PKMPokedex
    func fetchPokedex(_ pokedexName: String) async throws -> PKMPokedex
    func fetchVersionList(paginationState: PaginationState<PKMVersion>) async throws -> PKMPagedObject<PKMVersion>
    func fetchVersion(_ versionID: Int) async throws -> PKMVersion
    func fetchVersion(_ versionName: String) async throws -> PKMVersion
    func fetchVersionGroupList(paginationState: PaginationState<PKMVersionGroup>) async throws -> PKMPagedObject<PKMVersionGroup>
    func fetchVersionGroup(_ versionGroupID: Int) async throws -> PKMVersionGroup
    func fetchVersionGroup(_ versionGroupName: String) async throws -> PKMVersionGroup
}



// MARK: - Web Services

public struct GameService: PKMGameService, Sendable {
    public enum API: APICall {
        case fetchGenerationList
        case fetchGenerationByID(Int)
        case fetchGenerationByName(String)
        case fetchPokedexList
        case fetchPokedexByID(Int)
        case fetchPokedexByName(String)
        case fetchVersionList
        case fetchVersionByID(Int)
        case fetchVersionByName(String)
        case fetchVersionGroupList
        case fetchVersionGroupByID(Int)
        case fetchVersionGroupByName(String)
        
        
        var path: String {
            switch self {
            case .fetchGenerationList:
                return "/generation"
            case .fetchGenerationByID(let id):
                return "/generation/\(id)"
            case .fetchGenerationByName(let name):
                return "/generation/\(name)"
            case .fetchPokedexList:
                return "/pokedex"
            case .fetchPokedexByID(let id):
                return "/pokedex/\(id)"
            case .fetchPokedexByName(let name):
                return "/pokedex/\(name)"
            case .fetchVersionList:
                return "/version"
            case .fetchVersionByID(let id):
                return "/version/\(id)"
            case .fetchVersionByName(let name):
                return "/version/\(name)"
            case .fetchVersionGroupList:
                return "/version-group"
            case .fetchVersionGroupByID(let id):
                return "/version-group/\(id)"
            case .fetchVersionGroupByName(let name):
                return "/version-group/\(name)"
            }
        }
    }
    
    public var session: URLSession
    
    public var baseURL: String = "https://pokeapi.co/api/v2"
    
    
    
    /**
     Fetch Generations list
     */
    public func fetchGenerationList(paginationState: PaginationState<PKMGeneration> = .initial(pageLimit: 20)) async throws -> PKMPagedObject<PKMGeneration> {
        try await callPaginated(endpoint: API.fetchGenerationList, paginationState: paginationState)
    }
    
    
    /**
     Fetch Generation Information
     
     - parameter generationID: Generation ID
     */
    public func fetchGeneration(_ generationID: Int) async throws -> PKMGeneration {
        try await PKMGeneration.decode(from: call(endpoint: API.fetchGenerationByID(generationID)))
    }
    
    
    /**
     Fetch Generation Information
     
     - parameter generationName: Generation Name
     */
    public func fetchGeneration(_ generationName: String) async throws -> PKMGeneration {
        try await PKMGeneration.decode(from: call(endpoint: API.fetchGenerationByName(generationName)))
    }
    
    
    /**
     Fetch Pokedex list
     */
    public func fetchPokedexList(paginationState: PaginationState<PKMPokedex> = .initial(pageLimit: 20)) async throws -> PKMPagedObject<PKMPokedex> {
        try await callPaginated(endpoint: API.fetchPokedexList, paginationState: paginationState)
    }
    
    
    /**
     Fetch Pokedex Information
     
     - parameter pokedexID: Pokedex ID
     */
    public func fetchPokedex(_ pokedexID: Int) async throws -> PKMPokedex {
        try await PKMPokedex.decode(from: call(endpoint: API.fetchPokedexByID(pokedexID)))
    }
    
    
    /**
     Fetch Pokedex Information
     
     - parameter pokedexName: Pokedex Name
     */
    public func fetchPokedex(_ pokedexName: String) async throws -> PKMPokedex {
        try await PKMPokedex.decode(from: call(endpoint: API.fetchPokedexByName(pokedexName)))
    }
    
    
    /**
     Fetch Versions list
     */
    public func fetchVersionList(paginationState: PaginationState<PKMVersion> = .initial(pageLimit: 20)) async throws -> PKMPagedObject<PKMVersion> {
        try await callPaginated(endpoint: API.fetchVersionList, paginationState: paginationState)
    }
    
    
    /**
     Fetch Version Information
     
     - parameter versionID: Version ID
     */
    public func fetchVersion(_ versionID: Int) async throws -> PKMVersion {
        try await PKMVersion.decode(from: call(endpoint: API.fetchVersionByID(versionID)))
    }
    
    
    /**
     Fetch Version Information
     
     - parameter versionName: Version Name
     */
    public func fetchVersion(_ versionName: String) async throws -> PKMVersion {
        try await PKMVersion.decode(from: call(endpoint: API.fetchVersionByName(versionName)))
    }
    
    
    /**
     Fetch Versions Groups list
     */
    public func fetchVersionGroupList(paginationState: PaginationState<PKMVersionGroup> = .initial(pageLimit: 20)) async throws -> PKMPagedObject<PKMVersionGroup> {
        try await callPaginated(endpoint: API.fetchVersionGroupList, paginationState: paginationState)
    }
    
    
    /**
     Fetch Versions Groups list
     */
    public func fetchVersionGroup(_ versionGroupID: Int) async throws -> PKMVersionGroup {
        try await PKMVersionGroup.decode(from: call(endpoint: API.fetchVersionGroupByID(versionGroupID)))
    }
    
    
    /**
     Fetch Version Group Information
     
     - parameter versionGroupName: Version Group Name
     */
    public func fetchVersionGroup(_ versionGroupName: String) async throws -> PKMVersionGroup {
        try await PKMVersionGroup.decode(from: call(endpoint: API.fetchVersionGroupByName(versionGroupName)))
    }
}
