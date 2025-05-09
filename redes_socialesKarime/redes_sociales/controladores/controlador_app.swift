//
//  controlador_app.swift
//  redes_sociales
//
//  Created by alumno on 3/26/25.
//

import SwiftUI

@Observable
@MainActor
public class ControladorAplicacion {
    var publicaciones: Array<Publicacion> = []
    var comentarios: Array<Comentario> = []
    
    var publicacion_seleccionada: Publicacion? = nil
    var perfil_a_mostrar: Perfil? = nil
    
    var pagina_resultados: PaginaResultado? = nil
    var pagina_resultados_planetas: PaginaResultadoPlaneta? = nil
    
    var personaje_seleccionado: MonoChino? = nil
    var transformaciones: Array<Transformacion> = []
    
    var planeta_seleccionado: Planeta? = nil
    
    var estado_actual_de_la_aplicacion: EstadosDeLaAplicacion = .mostrando_personajes
    
    init(){
        Task.detached(priority: .high){
            await self.descargar_publicaciones()
            
            await self.descargar_monos_chinos()
        }
    }
    
    func cambiar_a_personajes() -> Void{
        estado_actual_de_la_aplicacion = .mostrando_personajes
    }
    
    func cambiar_a_planetas() -> Void{
        estado_actual_de_la_aplicacion = .mostrando_planetas
    }
    
    func descargar_monos_chinos() async{
        guard let pagina_descargada: PaginaResultado = try? await DragonBallAPI().descargar_pagina_personajes() else { return }
        
        self.pagina_resultados = pagina_descargada
    }
    
    func descargar_planetas() async{
        guard let pagina_planetas_descargada: PaginaResultadoPlaneta = try? await DragonBallAPI().descargar_informacion_planetas() else { return }
        
        self.pagina_resultados_planetas = pagina_planetas_descargada
    }
    
    func descargar_info_personaje(id: Int) async {
        guard let mono_chino: MonoChino = try? await DragonBallAPI().descargar_informacion_personaje(id: id) else { return }
        
        self.personaje_seleccionado = mono_chino
    }
    
    func descargar_info_planeta(id: Int) async {
        guard let planeta: Planeta = try? await DragonBallAPI().descargar_informacion_planetas(id: id) else { return }
        
        self.planeta_seleccionado = planeta
    }
    
    func descargar_informacion_personaje(id: Int){
        Task.detached(operation: {
            await self.descargar_info_personaje(id: id)
        })
    }
    
    func descargar_informacion_planeta(id: Int){
        Task.detached(operation: {
            await self.descargar_info_planeta(id: id)
        })
    }
    
    func seleccionar_mono_chino(_ personaje: MonoChino) -> Void {
        personaje_seleccionado = personaje
    }
    
    func seleccionar_planeta(_ planeta: Planeta) -> Void {
        planeta_seleccionado = planeta
    }
    // Publicaciones
    
    func descargar_publicaciones() async {
        defer {
            print("Esta funcion se mandó a llamar después de todos los await en mi función \(#function)")
        }
        
        guard let publicaciones_dercargadas: [Publicacion] = try? await PlaceHolderAPI().descargar_publicaciones() else { return }
        
        publicaciones = publicaciones_dercargadas
    }
    
    func descargar_comentarios() async {
        defer {
            print("Esta funcion se mandó a llamar después de todos los await en mi función \(#function)")
        }
        
        guard let comentarios_descargados: [Comentario] = try? await PlaceHolderAPI().descargar_comentarios(post_id: self._publicacion_seleccionada!.id) else { return }
        
        comentarios = comentarios_descargados
    }
    
    func seleccionar_publicacion(_ publicacion: Publicacion) -> Void {
        publicacion_seleccionada = publicacion
        
        Task.detached(operation: {
            await self.descargar_comentarios()
        })
    }
    
    func descargar_perfil(id: Int) async -> Void {
        guard let perfil : Perfil = try? await PlaceHolderAPI().descargar_perfil(id: id) else { return }
        perfil_a_mostrar = perfil
    }
    
    func ver_perfil(id: Int) -> Void {
        Task.detached {
            await self.descargar_perfil(id: id)
        }
    }
}
