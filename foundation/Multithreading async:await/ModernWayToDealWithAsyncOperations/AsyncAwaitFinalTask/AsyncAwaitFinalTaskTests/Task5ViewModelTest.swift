//
//  Task5ViewModelTest.swift
//  AsyncAwaitFinalTaskTests
//
//  Created by Lukasz Fabia on 27/07/2025.
//

import XCTest
@testable import AsyncAwaitFinalTask

class Task5ViewModelTests: XCTestCase {
    var mockAPI: Task5APIMock!
    
    override func setUp() {
        super.setUp()
        mockAPI = Task5APIMock()
    }
    
    override func tearDown() {
        mockAPI = nil
        super.tearDown()
    }
    
    func test_InitialValues() throws {
        let sut = makeSut()
        
        XCTAssertEqual("Not running", sut.displayedText)
        XCTAssertEqual("Start", sut.buttonTitle)
        XCTAssertEqual("loaded sequence: ", sut.loadedSequence)
    }
    
    func test_buttonPressed() throws {
        let sut = makeSut()
        
        sut.buttonPressed()
        
        XCTAssertEqual("loaded 0 of 3", sut.displayedText)
        XCTAssertEqual("Start", sut.buttonTitle)
        XCTAssertEqual("loaded sequence: ", sut.loadedSequence)
    }
    
    func test_buttonPressedAndEndActing() async throws {
        let sut = makeSut()
        
        sut.buttonPressed()
        
        try? await Task.sleep(for: .milliseconds(500))
        
        XCTAssertEqual(sut.displayedText, "Completed")
        
        XCTAssertTrue(sut.loadedSequence.contains("[one]"))
        XCTAssertTrue(sut.loadedSequence.contains("[two]"))
        XCTAssertTrue(sut.loadedSequence.contains("[three]"))
        
        XCTAssertEqual(sut.loadedSequence, "loaded sequence:  [one] [two] [three]")
    }
    
    func test_buttonPressedLoaded1Of3() async throws {
        let sut = makeSut()
        
        mockAPI.hasDelay = false
        mockAPI.checkFor1Of3 = true
        
        sut.buttonPressed()
        
        try? await Task.sleep(for: .milliseconds(50))
        
        XCTAssertEqual(sut.displayedText, "loaded 1 of 3")
        XCTAssertEqual(sut.loadedSequence, "loaded sequence:  [one]")
        XCTAssertFalse(sut.loadedSequence.contains("[two]"))
        XCTAssertFalse(sut.loadedSequence.contains("[three]"))
        
        print(sut.loadedSequence)
    }

    func test_buttonPressedLoaded2Of3() async throws {
        let sut = makeSut()
        
        mockAPI.hasDelay = false
        mockAPI.checkFor2Of3 = true
        
        sut.buttonPressed()
        
        try? await Task.sleep(for: .milliseconds(50))
        
        XCTAssertEqual(sut.displayedText, "loaded 2 of 3")
        XCTAssertTrue(sut.loadedSequence.contains("[one]"))
        XCTAssertTrue(sut.loadedSequence.contains("[two]"))
        XCTAssertFalse(sut.loadedSequence.contains("[three]"))
        
        print(sut.loadedSequence)
    }
    
    func test_doublePressedButton() throws {
        let sut = makeSut()
        
        sut.buttonPressed()
        sut.buttonPressed()
        
        XCTAssertEqual("loaded 0 of 3", sut.displayedText)
        XCTAssertEqual("Start", sut.buttonTitle)
        XCTAssertEqual("loaded sequence: ", sut.loadedSequence)
    }

    private func makeSut() -> Task5ViewModel {
        return Task5ViewModel(api: mockAPI)
    }
}
