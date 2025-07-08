//
//  ListResponseDTO.swift
//  Imdb
//
//  Created by Lukasz Fabia on 08/07/2025.
//

struct ListResponseDTO<T: Decodable>: Decodable {
    let items: [T]

    private enum CodingKeys: String, CodingKey {
        case items = "genres"
    }
}
