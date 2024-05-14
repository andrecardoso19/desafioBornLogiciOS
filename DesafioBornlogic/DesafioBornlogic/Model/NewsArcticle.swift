//
//  NewsArticle.swift
//  DesafioBornlogic
//
//  Created by André Cardoso Aragão on 14/05/24.
//

import Foundation

struct NewsArticleResponse: Decodable {
    let status: String
    let totalResults: Int
    let articles : [NewsArcticle]
}

struct NewsArcticle: Decodable {
    var source: Source?
    let author: String
    let title: String
    let description: String
    let urlToImage: String
}

struct Source: Codable {
    let id: String?
    let name: String
}
