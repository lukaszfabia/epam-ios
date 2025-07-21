//
//  MockAPIService.swift
//  UnitTesting
//

@testable import UnitTesting

final class MockAPIService: APIServiceProtocol {
    var fetchUsersResult: Result<[User], APIError>?
    
    private(set) var fetchUsersCallsCount = 0
    
    // added
    private(set) var lastUrl: String = ""

    func fetchUsers(
        urlString: String,
        completion: @escaping (Result<[User], APIError>) -> Void
    ) {
        lastUrl = urlString
        fetchUsersCallsCount += 1
        if let fetchUsersResult {
            completion(fetchUsersResult)
        } else {
            completion(.failure(.unexpected))
        }
    }

    func fetchUsersAsync(urlString: String) async -> Result<[User], APIError> {
        .failure(.unexpected)
    }
}
