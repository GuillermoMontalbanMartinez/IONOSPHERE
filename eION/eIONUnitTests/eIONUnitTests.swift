//
//  eIONUnitTests.swift
//  eIONUnitTests
//
//  Created by Marta Fernandez Garcia on 30/12/21.
//

import XCTest

@testable import eION // Importamos el otro esquema

class eIONUnitTests: XCTestCase {

    var vm : ViewModel!
    
    override func setUp() {
        super.setUp()
        vm = ViewModel()
    }
    
    override func tearDown() {
        vm = nil
        super.tearDown()
    }
    
    
    /* El nombre debe empezar por "test" **/
    func testItShouldCreateAnUser() throws {
        // Given
        let name = self.randomString(of: 4)
        let password = self.randomString(of: 5)
        
        // When
        var result = false
        do {
            try vm.addUsuario(nombre: name, password: password)
            result = vm.iniciarSesion(nombre: name, contraseña: password)
        } catch {
            
        }
        
        // Then
        XCTAssertTrue(result)
    }
    
    func testItShouldThrowExceptionIfUserAlreadyExists() throws {
        // Given
        let name = "Marta"
        let password = "0707"
        
        // When + Then
        XCTAssertThrowsError(try vm.addUsuario(nombre: name, password: password))
    }
    
    
    private func randomString(of length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var s = ""
        for _ in 0 ..< length {
            s.append(letters.randomElement()!)
        }
        return s
    }

}
