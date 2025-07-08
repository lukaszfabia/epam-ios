//
//  PaginatedReponseDTO.swift
//  Imdb
//
//  Created by Lukasz Fabia on 08/07/2025.
//

struct PaginatedReponseDTO<T: Decodable>: Decodable {
    let page: Int
    let results: [T]
    let total_pages: Int
    let total_results: Int
}
