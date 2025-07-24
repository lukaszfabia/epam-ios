//
//  CacheService.swift
//  Task2
//
//  Created by Lukasz Fabia on 24/07/2025.
//

import Foundation
import UIKit

protocol Cachable {
    func load(from url: URL) async -> UIImage
    func download(from url: URL) async -> UIImage
    func retrieve(from url: URL) -> UIImage?
    func save(_ data: Data, to url: URL) throws
    func clear()
}
