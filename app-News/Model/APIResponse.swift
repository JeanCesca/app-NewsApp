//
//  APIResponse.swift
//  app-News
//
//  Created by Jean Ricardo Cesca on 05/09/22.
//

import Foundation

//Model
struct APIResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Articles]
}

struct Articles: Codable {
    let source: Source
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
}

struct Source: Codable {
    let id: String?
    let name: String
}
