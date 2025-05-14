//
//  pokemon_api.swift
//  redes_sociales
//
//  Created by alumno on 5/7/25.
//

import SwiftUI

class pokemon_api: Codable {
    let url_base = "https://pokeapi.co/docs/v2"
    
    func descargar_berry() async -> PaginaResultado? {
        let ubicacion_recurso = "/berry"
        
        return await descargar(recurso: ubicacion_recurso)
    }
    
    func descargar_generation(id: Int) async -> MonoChino? {
        let ubicacion_recurso = "/generation"
        
        return await descargar(recurso: ubicacion_recurso)
    }
    
    func descargar_informacion_planetas() async -> PaginaResultadoPlaneta? {
        let ubicacion_recurso = "/PokemonEvolution"
        
        return await descargar(recurso: ubicacion_recurso)
    }
    
    
    
    private func descargar<TipoGenerico: Codable>(recurso: String) async -> TipoGenerico? {
        do {
            guard let url = URL(string: "\(url_base)\(recurso)") else { throw ErroresDeRed.malaDireccionUrl }
            let (datos, respuesta) = try await URLSession.shared.data(from: url)
            guard let respuesta = respuesta as? HTTPURLResponse else {throw ErroresDeRed.badResponse}
            guard respuesta.statusCode >= 200 && respuesta.statusCode < 300 else { throw ErroresDeRed.badStatus }
            guard let respuesta_decodificada = try? JSONDecoder().decode(TipoGenerico.self, from: datos) else { throw ErroresDeRed.fallaAlConvertirLaRespuesta }
            
            return respuesta_decodificada
        }
        catch ErroresDeRed.malaDireccionUrl {
            print("Tenes mala la url capo, cambiala")
        }
        catch ErroresDeRed.badResponse {
            print("Algo salio mal con la respuesta, revisa por favor")
        }
        catch ErroresDeRed.badStatus {
            print("Como consigues un status negativo de algo que ni siquiera se mueve")
        }
        catch ErroresDeRed.fallaAlConvertirLaRespuesta {
            print("Tienes mal el modelo o la implementacion de este")
        }
        catch ErroresDeRed.invalidRequest {
            print("Como llegaste aquí?")
        }
        catch{
            print("Algo terriblemente mal que no se que es, pasó. No deberías ver esto.")
        }
        
        return nil
    }

    |
}

