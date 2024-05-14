//
//  ArticleViewController.swift
//  DesafioBornlogic
//
//  Created by Ana Beatriz Santos on 14/05/24.
//

import Foundation
import UIKit

final class ArticleViewController: UIViewController {
    private let newsArticle: NewsArticle
    
    init (newsArticle: NewsArticle) {
        self.newsArticle = newsArticle
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupView()
    }
    
    private func setupView() {
        title = "News Article"
        let view = ArticleView()
        
        view.setupView(imageUrl: newsArticle.urlToImage,
                       title: newsArticle.title,
                       author: newsArticle.author,
                       date: setupDate(date: newsArticle.publishedAt),
                       content: newsArticle.content)
        
        self.view = view
    }
    
    private func setupDate(date: String) -> String {
        let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
                    let date : Date? = dateFormatter.date(from: date)
                    let formatterString = DateFormatter()
                    formatterString.dateStyle = .short
                    let dateString = formatterString.string(from: date ?? Date())
        
        return dateString
    }
}
