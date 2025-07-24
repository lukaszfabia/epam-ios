//
//  Downloader.swift
//  Task2
//
//  Created by Lukasz Fabia on 15/07/2025.
//

import Foundation

protocol ImageService {
    func fetchImageList(page: Int, limit: Int) async throws -> [any Image]
}
