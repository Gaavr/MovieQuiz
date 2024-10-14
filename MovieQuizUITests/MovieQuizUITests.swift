//
//  MovieQuizUITests.swift
//  MovieQuizUITests
//
//  Created by Andrei Gavrilenko on 13.10.2024.
//

import XCTest

class MovieQuizUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        app = XCUIApplication()
        app.launch()
        
        // Не продолжаем выполнение, если один тест упал
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
        app.terminate()
        app = nil
        try super.tearDownWithError()
    }

    // Вспомогательная функция для ожидания появления элемента
    func waitForElement(_ element: XCUIElement, timeout: TimeInterval = 5) -> Bool {
        let predicate = NSPredicate(format: "exists == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
        return XCTWaiter().wait(for: [expectation], timeout: timeout) == .completed
    }
    
    // Вспомогательная функция для получения изображения из Poster
    func getPosterData() -> Data? {
        let poster = app.images["Poster"]
        XCTAssertTrue(waitForElement(poster), "Poster не отображается.")
        return poster.screenshot().pngRepresentation
    }
    
    func testYesButtonChangesPoster() {
        let firstPosterData = getPosterData()
        XCTAssertNotNil(firstPosterData, "Первый постер отсутствует.")
        
        app.buttons["Yes"].tap()
        
        let secondPosterData = getPosterData()
        XCTAssertNotEqual(firstPosterData, secondPosterData, "Постер не изменился после нажатия Yes.")
    }

    func testNoButtonChangesPosterAndUpdatesIndex() {
        let firstPosterData = getPosterData()
        XCTAssertNotNil(firstPosterData, "Первый постер отсутствует.")
        
        let indexLabel = app.staticTexts["Index"]
        XCTAssertTrue(indexLabel.exists, "Label с индексом не отображается.")
        
        app.buttons["No"].tap()
        
        let secondPosterData = getPosterData()
        XCTAssertNotEqual(firstPosterData, secondPosterData, "Постер не изменился после нажатия No.")
        
        // Ожидание с циклом
        var isUpdated = false
        let timeout: TimeInterval = 5
        let startTime = Date()

        while Date().timeIntervalSince(startTime) < timeout {
            if indexLabel.label == "2/10" {
                isUpdated = true
                break
            }
            usleep(100_000) // Ждём 0.1 секунду перед следующей проверкой
        }

        XCTAssertTrue(isUpdated, "Индекс не обновился до '2/10' за \(timeout) секунд.")
    }


    func testGameFinish() {
        sleep(2)
        for _ in 1...10 {
            app.buttons["No"].tap()
            sleep(2)
        }

        let alert = app.alerts["Этот раунд окончен!"]
        
        XCTAssertTrue(alert.exists)
        XCTAssertTrue(alert.label == "Этот раунд окончен!")
        XCTAssertTrue(alert.buttons.firstMatch.label == "Сыграть ещё раз")
    }

    func testAlertDismiss() {
        sleep(2)
        for _ in 1...10 {
            app.buttons["No"].tap()
            sleep(2)
        }
        
        let alert = app.alerts["Этот раунд окончен!"]
        alert.buttons.firstMatch.tap()
        
        sleep(2)
        
        let indexLabel = app.staticTexts["Index"]
        
        XCTAssertFalse(alert.exists)
        XCTAssertTrue(indexLabel.label == "1/10")
    }
}
