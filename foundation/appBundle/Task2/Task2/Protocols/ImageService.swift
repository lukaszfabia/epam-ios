//
//  Downloader.swift
//  Task2
//
//  Created by Lukasz Fabia on 15/07/2025.
//

import Foundation

protocol ImageService {
    func fetchImageList(perPage: Int) async throws -> [URL]
}
