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
    @Published var loading = false
    
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
        self.loading = true
        let newUser = Usuario(context: gestorCoreData.contexto)
        newUser.nombre = nombre
        newUser.password = password
        newUser.tipoUsuario = 1
        var errorEncontrado: Bool = false
        
        for u in usuarios {
            if (u.nombre == newUser.nombre) {
                errorEncontrado = true
                self.loading = false
                throw error.datoRepetido
            }
        }
        if (errorEncontrado) {
            self.loading = false
        } else {
            self.loading = false
            print("milagro")
            saveData()
        }
    }
    
    func deleteUsuario(indexSet: IndexSet) {
        self.loading = true
        for index in indexSet {
            gestorCoreData.contexto.delete(usuarios[index])
        }
        saveData()
        self.loading = false
    }
    
    func addPulso(fechaCreacion: Date, clase:Bool, ubicacion:String, a27:Double, a03:Double, nombrePulso:String, nombreUsuario: String) {
        self.loading = true
        let newPulso = Pulso(context: gestorCoreData.contexto)
        newPulso.nombrePulso = nombrePulso
        newPulso.fechaCreacion = fechaCreacion
        newPulso.clase = clase
        newPulso.ubicacion = ubicacion
        newPulso.a03 = a03
        newPulso.a27 = a27
        
        newPulso.usuarioRelation = usuarios.filter({$0.nombre == nombreUsuario}).first
        
        print("Creando pulso")
        
        saveData()
        self.loading = false
    }
    
    func guardarPulsoUsuario(usuario: Usuario, pulso: Pulso){
        self.loading = true
        
        if ( usuario.guardaPulsoRelation?.contains(pulso) ?? false ) {
            pulso.pulsoGuardado = nil
        } else {
            pulso.pulsoGuardado = usuario
        }
        
        saveData()
        self.loading = false
    }
    
    func deletePulso(pulso: Pulso) {
        self.loading = true
        gestorCoreData.contexto.delete(pulso)
        saveData()
        self.loading = false
    }
    
    func iniciarSesion(nombre:String, contraseña:String) -> Bool {        
        self.loading = true
        let user:[Usuario] = usuarios.filter({$0.nombre == nombre && $0.password == contraseña})
        
        print( "USUARIO: \(user)")
        if !user.isEmpty {
            self.loading = false
            usuarioLogeado = user[0]
            return true
        } else {
            self.loading = false
            return false
        }
    }
    
    func getInstanciasClases() -> [String: Int] {
        self.loading = true
        let numPulsosGood: Int = pulsos.filter({$0.clase == true}).count
        let numPulsosBad: Int = pulsos.filter({$0.clase == false}).count
        
        var result : [String:Int] = [:]
        
        
        result["Good"] = numPulsosGood
        result["Bad"]  = numPulsosBad
        
        self.loading = false
        return result
    }
    
    /**
     Funcion para cambiar el tipo de usuario
     */
    func cambiarTipo(nombre: String){
        self.loading = true
        let usuario = usuarios.first(where: {$0.nombre == nombre})
        
        if (usuario!.tipoUsuario == 1){
            usuario!.tipoUsuario = 2
        }else{
            usuario!.tipoUsuario = 1
        }
        print("cambiando")
        saveData()
        self.loading = false
    }
    
    
    func calcularClase(a05: Double, a27: Double) -> Bool {
        var isClassB: Double
        var isClassG: Double
        
        if a05 <= 0.0409 {
            isClassB = 1.07 + a05*(-0.7)
            isClassG = -1.07 + a05*(0.7)
        } else {
            if a27 <= 0.99989 {
                isClassB = -0.36 + a05*(-0.95) + a27*(0.12)
                isClassG = -0.36 + a05*(0.95) + a27*(-0.12)
            } else {
                isClassB = -0.44 + a05*(0.29) + a27*(0.69)
                isClassG = 0.44 + a05*(-0.29) + a27*(-0.69)
            }
        }
        
        return isClassB > isClassG ? false : true
    }
    
    
    func ordenarPulsos(propiedad: String) -> Void {
        
        let fetchPulsos = NSFetchRequest<Pulso>(entityName: "Pulso")
        
        do {
            
            if propiedad == "nombre" {
                self.pulsos = try gestorCoreData.contexto.fetch(fetchPulsos).sorted(){$0.nombrePulso! < $1.nombrePulso!}
            } else if propiedad == "fecha" {
                self.pulsos = try gestorCoreData.contexto.fetch(fetchPulsos).sorted(){$0.fechaCreacion! < $1.fechaCreacion!}
                
            }
            
        } catch let error {
            print("Error al cargar los datos :\(error)")
        }
    }
    
    
    func updateUserData(nombre: String, imagen: UIImage) -> Bool {
        self.loading = true
        let user:[Usuario] = usuarios.filter({$0.nombre == nombre})
        
        //let jpegImageData = imagen.jpegData(compressionQuality: 1.0)
        let pngImageData  = imagen.pngData()
        
        if !user.isEmpty {
            user[0].foto = pngImageData
            print( "USUARIO: \(user)")
            saveData()
            self.loading = false
            return true
        } else {
            self.loading = false
            return false
        }
        
    }
    
   
}
