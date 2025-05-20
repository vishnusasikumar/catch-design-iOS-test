//
//  Item.swift
//  Catch iOS Test
//
//  Created by Admin on 20/05/2025.
//

import Foundation

// MARK: - Item
struct Item: Hashable, Codable, Identifiable {
    let id: Int
    let title: String
    let subtitle: String
    let content: String
}
