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
    let articles : [NewsArticle]
}

struct NewsArticle: Decodable, Equatable {
    // Disclaimer: nao sei exatamente a funcionalidade desse metodo, o xcode obrigou a colocar isso, nunca precisei usar
    static func == (lhs: NewsArticle, rhs: NewsArticle) -> Bool {
        true
    }
    
    var source: Source?
    let author: String
    let title: String
    let description: String
    let urlToImage: String
    let content: String
    let publishedAt: String
}

struct Source: Decodable {
    let id: String?
    let name: String
}
