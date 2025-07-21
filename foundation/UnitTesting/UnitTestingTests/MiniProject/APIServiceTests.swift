//
//  APIServiceTests.swift
//  UnitTesting
//

import XCTest
@testable import UnitTesting

final class APIServiceTests: XCTestCase {
    var mockURLSession: MockURLSession!
    
    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
    }
    
    override func tearDown() {
        mockURLSession = nil
        super.tearDown()
    }
    
    // MARK: Fetch Users

    // pass some invalid url and assert that method completes with .failure(.invalidUrl)
    // use expectations
    func test_apiService_fetchUsers_whenInvalidUrl_completesWithError() {
        let sut = makeSut()
        let exp = expectation(description: "Fetch data with error.")
        
        sut.fetchUsers(urlString: "") {result in
            switch result {
            case .failure(let err):
                XCTAssertEqual(APIError.invalidUrl, err)
            case .success(_):
                XCTFail("Expected to be error cause of invalid url.")
            }
            
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 2)
    }

    // assert that method completes with .success(expectedUsers)
    func test_apiService_fetchUsers_whenValidSuccessfulResponse_completesWithSuccess() {
        let response = """
        [
            { "id": 1, "name": "John Doe", "username": "johndoe", "email": "johndoe@gmail.com" },
            { "id": 2, "name": "Jane Doe", "username": "johndoe", "email": "johndoe@gmail.com" }
        ]
        """.data(using: .utf8)
        mockURLSession.mockData = response
        
        let sut = makeSut()
        
        let exp = expectation(description: "Fetch data with success.")
        
        sut.fetchUsers(urlString: "validurl") {result in
            switch result {
            case .failure(_):
                XCTFail()
            case .success(let users):
                XCTAssertEqual(users.count, 2)
                
                let john = users[0]
                let jane = users[1]
                
                // ids
                XCTAssertEqual(john.id, 1)
                XCTAssertEqual(jane.id, 2)
                
                // names
                XCTAssertEqual(john.name, "John Doe")
                XCTAssertEqual(jane.name, "Jane Doe")
                
                // usernames
                XCTAssertEqual(john.username, "johndoe")
                XCTAssertEqual(jane.username, "johndoe")
                
                // emails
                XCTAssertEqual(john.email, "johndoe@gmail.com")
                XCTAssertEqual(jane.email, "johndoe@gmail.com")
            }
            
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 2)
    }

    // assert that method completes with .failure(.parsingError)
    func test_apiService_fetchUsers_whenInvalidSuccessfulResponse_completesWithFailure() {
        let response = """
        [
            { "id": 1, "name": "John Doe", "userna": "johndoe", "email": "johndoe@gmail.com" },
            { "name": "Jane Doe", "username": "johndoe", "email": "johndoe@gmail.com" }
        ]
        """.data(using: .utf8)
        mockURLSession.mockData = response
        
        let sut = makeSut()
        let exp = expectation(description: "Fetch data with error.")
        
        sut.fetchUsers(urlString: "validurl") {result in
            switch result {
            case .failure(let err):
                XCTAssertEqual(APIError.parsingError, err)
            case .success(_):
                XCTFail("Expected to be error cause of invalid response from api.")
            }
            
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 2)
    }

    // assert that method completes with .failure(.unexpected)
    func test_apiService_fetchUsers_whenError_completesWithFailure() {
        mockURLSession.mockError = URLError(.unknown)

        let sut = makeSut()
        let exp = expectation(description: "Fetch data with error.")
        
        sut.fetchUsers(urlString: "validurl") {result in
            switch result {
            case .failure(let err):
                XCTAssertEqual(APIError.unexpected, err)
            case .success(_):
                XCTFail("Expected to be error.")
            }
            
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 2)
    }

    // MARK: Fetch Users Async

    // pass some invalid url and assert that method completes with .failure(.invalidUrl)
    func test_apiService_fetchUsersAsync_whenInvalidUrl_completesWithError() async {
        // TODO: Implement test
        
        let sut = makeSut()
        
        let result = await sut.fetchUsersAsync(urlString: "")
        
        switch result {
        case .failure(let err):
            XCTAssertEqual(APIError.invalidUrl, err)
        case .success(_):
            XCTFail("Expected to be error cause of invalid url.")
        }
    }
    
    // check for error when response has invalid strucutre
    func test_apiService_fetchUsersAsync_whenInvalidSuccessfulResponse_completesWithFailure() async {
        let response = """
        [
            { "id": 1, "name": "John Doe", "userna": "johndoe", "email": "johndoe@gmail.com" },
            { "name": "Jane Doe", "username": "johndoe", "email": "johndoe@gmail.com" }
        ]
        """.data(using: .utf8)
        mockURLSession.mockData = response
        
        let sut = makeSut()
        
        let result = await sut.fetchUsersAsync(urlString: "vallid")
        
        switch result {
        case .failure(let err):
            XCTAssertEqual(APIError.parsingError, err)
        case .success(_):
            XCTFail("Expected to be error cause of invalid response from api.")
        }
    }
    
    // assert that method completes with .failure(.unexpected)
    func test_apiService_fetchUsersAsync_whenError_completesWithFailure() async {
        mockURLSession.mockError = URLError(.unknown)

        let sut = makeSut()
        let result = await sut.fetchUsersAsync(urlString: "validurl")
      
        switch result {
        case .failure(let err):
            XCTAssertEqual(APIError.unexpected, err)
        case .success(_):
            XCTFail("Expected to be error cause of error from api.")
        }
    
    }
    
    func test_apiService_fetchUsersAsync_whenValidSuccessfulResponse_completesWithSuccess() async {
        let response = """
        [
            { "id": 1, "name": "John Doe", "username": "johndoe", "email": "johndoe@gmail.com" },
            { "id": 2, "name": "Jane Doe", "username": "janedoe", "email": "janedoe@gmail.com" }
        ]
        """.data(using: .utf8)
        mockURLSession.mockData = response
        
        let sut = makeSut()
        
        let result = await sut.fetchUsersAsync(urlString: "validurl")
        
        switch result {
        case .failure(_):
            XCTFail()
        case .success(let users):
            XCTAssertEqual(users.count, 2)
            
            let john = users[0]
            let jane = users[1]
            
            // ids
            XCTAssertEqual(john.id, 1)
            XCTAssertEqual(jane.id, 2)
            
            // names
            XCTAssertEqual(john.name, "John Doe")
            XCTAssertEqual(jane.name, "Jane Doe")
            
            // usernames
            XCTAssertEqual(john.username, "johndoe")
            XCTAssertEqual(jane.username, "janedoe")
            
            // emails
            XCTAssertEqual(john.email, "johndoe@gmail.com")
            XCTAssertEqual(jane.email, "janedoe@gmail.com")
        }
    }
    
    func test_apiService_fetchUsersAsync_whenResponseHasNoData_completesWithFailure() async {
        mockURLSession.mockData = nil
        
        let sut = makeSut()
        
        let result = await sut.fetchUsersAsync(urlString: "validurl")
        
        switch result {
        case .failure(let err):
            XCTAssertEqual(APIError.unexpected, err)
        case .success(_):
            XCTFail("Expected to be error cause of error from api.")
        }
    }

    private func makeSut() -> APIService {
        APIService(urlSession: mockURLSession)
    }
}
