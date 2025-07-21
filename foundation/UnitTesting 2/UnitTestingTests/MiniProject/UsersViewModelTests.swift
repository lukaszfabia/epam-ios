//
//  UsersViewModelTests.swift
//  UnitTesting
//

@testable import UnitTesting
import XCTest
// sut - system under test, what are we testing

class UsersViewModelTests: XCTestCase {
    var mockService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        mockService = MockAPIService()
    }
    
    override func tearDown() {
        mockService = nil
        super.tearDown()
    }
    
    // assert that sut.fetchUsers(completion: {}) calls appropriate method of api service
    // use XCAssertEqual, fetchUsersCallsCount
    func test_viewModel_whenFetchUsers_callsApiService() {
        let sut = makeSut()
        sut.fetchUsers(completion: {})
        
        XCTAssertEqual(mockService.fetchUsersCallsCount, 1)
        
    }

    // assert that the passed url to api service is correct
    // so we're testing wheater out hardcoded api url is passed to wrapper???
    func test_viewModel_whenFetchUsers_passesCorrectUrlToApiService() {
        let sut = makeSut()
        sut.fetchUsers(completion: {})
        
        XCTAssertEqual(mockService.lastUrl, "https://jsonplaceholder.typicode.com/users")

    }

    // assert that view model users are updated and error message is nil
    func test_viewModel_fetchUsers_whenSuccess_updatesUsers() {
        mockService.fetchUsersResult = .success(
            [User(id: 1, name: "name", username: "surname", email: "user@email.com")]
        )
        
        let sut = makeSut()
        
        let exp = expectation(description: "Data fetched")

        sut.fetchUsers {
            exp.fulfill()
        }

        waitForExpectations(timeout: 1)
        
        
        XCTAssertNil(sut.errorMessage, "Expected to be nil")
        
        XCTAssertEqual(sut.users.count, 1)
        
        let updatedUser = sut.users[0]
        
        XCTAssertEqual(updatedUser.id, 1)
        XCTAssertEqual(updatedUser.name, "name")
        XCTAssertEqual(updatedUser.username, "surname")
        XCTAssertEqual(updatedUser.email, "user@email.com")
    }

    // assert that view model error message is "Unexpected error"
    func test_viewModel_fetchUsers_whenInvalidUrl_updatesErrorMessage() {
        mockService.fetchUsersResult = .failure(.invalidUrl)
        
        let sut = makeSut()
        
        let exp = expectation(description: "Data fetched")
        
        sut.fetchUsers {
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 1)
        
        XCTAssertNotNil(sut.errorMessage, "Expected to be error")
        XCTAssertEqual(sut.errorMessage, "Unexpected error")
        
    }

    // assert that view model error message is "Unexpected error"
    func test_viewModel_fetchUsers_whenUnexectedFailure_updatesErrorMessage() {
        mockService.fetchUsersResult = .failure(.unexpected)
        
        let sut = makeSut()
        
        let exp = expectation(description: "Data fetched")
        
        sut.fetchUsers {
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 1)
        
        XCTAssertNotNil(sut.errorMessage, "Expected to be error")
        XCTAssertEqual(sut.errorMessage, "Unexpected error")
    }

    // assert that view model error message is "Error parsing JSON"
    func test_viewModel_fetchUsers_whenParsingFailure_updatesErrorMessage() {
        mockService.fetchUsersResult = .failure(.parsingError)
        
        let sut = makeSut()
        
        let exp = expectation(description: "Data fetched")
        
        sut.fetchUsers {
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 1)
        
        XCTAssertNotNil(sut.errorMessage, "Expected to be error")
        XCTAssertEqual(sut.errorMessage, "Error parsing JSON")
    }

    // fetch users with successful result and after calling clear() assert users are empty
    func test_viewModel_clearUsers() {
        mockService.fetchUsersResult = .success(
            [
                User(id: 1, name: "name", username: "surname", email: "user@email.com"),
                User(id: 2, name: "lukasz", username: "lukaszfabia", email: "ufabia03@gmail.com"),
            ]
        )
        
        let sut = makeSut()
        
        let exp = expectation(description: "Users fetched")
        
        sut.fetchUsers {
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 1)
        
        XCTAssertEqual(sut.users.count, 2)
        
        sut.clearUsers()
        
        XCTAssertEqual(sut.users.count, 0)
    }

    private func makeSut() -> UsersViewModel {
        UsersViewModel(apiService: mockService)
    }
}
