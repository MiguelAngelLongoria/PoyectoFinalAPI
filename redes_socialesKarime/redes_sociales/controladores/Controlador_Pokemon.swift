//
//  Controlador_Pokemon.swift
//  redes_sociales
//
//  Created by alumno on 5/14/25.
//
import SwiftUI

@Observable
@MainActor
public final class Controlador_Pokemon {
    // MARK: - Estado
 var generaciones: [PokemonGeneration] = []
     var isLoading = false
    var error: Error?
     var currentPage = 1
     var totalPages = 1
    
    // MARK: - Dependencias
    private let pokemonService: PokemonServiceProtocol
    private let cacheManager: CacheManagerProtocol
    
    // MARK: - Inicialización
    public init(
        pokemonService: PokemonServiceProtocol = PokemonService(),
        cacheManager: CacheManagerProtocol = CacheManager.shared
    ) {
        self.pokemonService = pokemonService
        self.cacheManager = cacheManager
        loadCachedData()
    }
    
    // MARK: - Acciones Públicas
    public func cargarGeneraciones(page: Int = 1) async {
        guard !isLoading else { return }
        
        isLoading = true
        error = nil
        
        do {
            let response = try await pokemonService.fetchGeneraciones(page: page)
            await handleResponse(response, for: page)
        } catch {
            await handleError(error)
        }
        
        isLoading = false
    }
    
    public func cargarSiguientePaginaSiEsNecesario() {
        guard !isLoading, currentPage < totalPages else { return }
        Task {
            await cargarGeneraciones(page: currentPage + 1)
        }
    }
    
    public func refrescarDatos() async {
        await cargarGeneraciones(page: 1)
    }
    
    // MARK: - Métodos Privados
    private func loadCachedData() {
        if let cachedGenerations: [PokemonGeneration] = cacheManager.load(forKey: .generacionesPokemon) {
            generaciones = cachedGenerations
        }
    }
    
    @MainActor
    private func handleResponse(_ response: PagedPokemonResponse, for page: Int) {
        if page == 1 {
            generaciones = response.items
        } else {
            generaciones.append(contentsOf: response.items)
        }
        
        currentPage = page
        totalPages = response.meta.totalPages
        cacheManager.save(generaciones, forKey: .generacionesPokemon)
    }
    
    @MainActor
    private func handleError(_ error: Error) {
        self.error = error
        if generaciones.isEmpty {
            loadCachedData()
        }
    }
    
    // MARK: - Métodos Utilitarios
    public func buscarGeneracion(porId id: Int) -> PokemonGeneration? {
        generaciones.first { $0.id == id }
    }
    
    public func contarPokemonEnGeneracion(_ generacionId: Int) -> Int {
        buscarGeneracion(porId: generacionId)?.pokemonSpecies.count ?? 0
    }
}

// MARK: - Protocolos de Dependencias
public protocol PokemonServiceProtocol {
    func fetchGeneraciones(page: Int) async throws -> PagedPokemonResponse
}

public protocol CacheManagerProtocol {
    func save<T: Codable>(_ value: T, forKey key: CacheKey)
    func load<T: Codable>(forKey key: CacheKey) -> T?
}

public enum CacheKey: String {
    case generacionesPokemon
    case pokemonDetalles
}

// MARK
