//
//  ViewModel.swift
//  eION
//
//  Created by Guillermo Montalban Martinez on 19/11/21.
//

import Foundation
import CoreData
import UIKit
import SwiftUI

class ViewModel: ObservableObject {
    let gestorCoreData = CoreDataManager.instace // singleton
    
    enum error: Error {
            case datoRepetido
            case uncorrect
        }
    
    @Published var usuarios:[Usuario] = []
    @Published var pulsos: [Pulso] = []
    @Published var usuarioLogeado: Usuario? = nil
    
    init(){
        loadData()
    }
    
    /**
        Funcion que cargar los datos en memoria.
        Los usuario los ordena por el nombre y los pulsos por fecha de creación
     */
    func loadData() {
        usuarios.removeAll()
        pulsos.removeAll()
        let fetchUsuarios = NSFetchRequest<Usuario>(entityName: "Usuario")
        let fetchPulsos = NSFetchRequest<Pulso>(entityName: "Pulso")
        do {
            self.usuarios = try gestorCoreData.contexto.fetch(fetchUsuarios).sorted(){$0.nombre!<$1.nombre!}
            self.pulsos = try gestorCoreData.contexto.fetch(fetchPulsos).sorted(){$0.nombrePulso! < $1.nombrePulso!}
        } catch let error {
            print("Error al cargar los datos :\(error)")
        }
    }
    /**
        Guardamos los datos y volvemos a cargarlos en memoria
     */
    func saveData() {
        gestorCoreData.save()
        loadData()
    }
    
    /**
        Creacion de los usuarios
     */
    func addUsuario(nombre: String, password: String) throws {
        let newUser = Usuario(context: gestorCoreData.contexto)
        newUser.nombre = nombre
        newUser.password = password
        newUser.tipoUsuario = 1
        var errorEncontrado: Bool = false

        for u in usuarios {
            if (u.nombre == newUser.nombre) {
                errorEncontrado = true
                throw error.datoRepetido
            }
        }
        if (errorEncontrado) {
            
        } else {
            print("milagro")
            saveData()
        }
        
        
    }
    
    func deleteUsuario(indexSet: IndexSet) {
        for index in indexSet {
            gestorCoreData.contexto.delete(usuarios[index])
        }
        saveData()
    }
    
    func addPulso(fechaCreacion: Date, clase:Bool, ubicacion:String, a27:Double, a03:Double, nombrePulso:String) {
        let newPulso = Pulso(context: gestorCoreData.contexto)
        newPulso.nombrePulso = nombrePulso
        newPulso.fechaCreacion = fechaCreacion
        newPulso.clase = clase
        newPulso.ubicacion = ubicacion
        newPulso.a03 = a03
        newPulso.a27 = a27
        saveData()
    }
    
    func deletePulso(pulso: Pulso) {
        gestorCoreData.contexto.delete(pulso)
        saveData()
    }
    
    func iniciarSesion(nombre:String, contraseña:String) -> Bool {
        let user:Usuario = usuarios.filter({$0.nombre == nombre && $0.password == contraseña})[0]
        
        guard user != nil else {
            print("usuario nil")
            return false
        }
        print("usuario no nil devuelve true")
        usuarioLogeado = user
        return true
    }
    
    func getInstanciasClases() -> [String: Int] {
        let numPulsosGood: Int = pulsos.filter({$0.clase == true}).count
        let numPulsosBad: Int = pulsos.filter({$0.clase == false}).count
        
        var result : [String:Int] = [:]
    
        
        result["Good"] = numPulsosGood
        result["Bad"]  = numPulsosBad
                
        return result
    }
    
    
}
