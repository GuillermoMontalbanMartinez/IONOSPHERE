//
//  eIONUITests.swift
//  eIONUITests
//
//  Created by Marta Fernandez Garcia on 30/12/21.
//

import XCTest
import eION

@testable import eION // Importamos el otro esquema

class eIONUITests: XCTestCase {

    func testItShouldLoadLogin() throws {
        let app = XCUIApplication()
        app.launch()
        let login = app.staticTexts["Inicia sesión"]
        XCTAssert(login.exists)
    }
    
    func testItShouldLogin() throws{
        let app = XCUIApplication()
        app.launch()
        let loginButton = app.buttons["Iniciar sesión"]
        XCTAssert(loginButton.exists)
        loginButton.tap()
        let errorMessage = app.staticTexts["Introduzca el usuario y la contraseña"]
        XCTAssert(errorMessage.exists)
    }

    /*func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }*/
}
