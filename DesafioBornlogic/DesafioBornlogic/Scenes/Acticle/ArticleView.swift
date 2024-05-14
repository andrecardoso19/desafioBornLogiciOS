//
//  ArticleView.swift
//  DesafioBornlogic
//
//  Created by André Cardoso Aragão on 14/05/24.
//

import Foundation
import UIKit

final class ArticleView: UIView {
    var pushToSafariView = {}
    
    private lazy var newsImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .white
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var newsTitleLabel: UILabel = {
       let view = UILabel()
        view.numberOfLines = -1
        view.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var newsAuthorLabel: UILabel = {
       let view = UILabel()
        view.numberOfLines = 2
        view.font = UIFont.systemFont(ofSize: 15, weight: .light)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var newsDateLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 13, weight: .ultraLight)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var newsContentLabel: UILabel = {
       let view = UILabel()
        view.numberOfLines = -1
        view.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var fullArticleButton: UIButton = {
       let view = UIButton()
        view.backgroundColor = .white
        view.setTitleColor(.tintColor, for: .normal)
        view.setTitle("Read full article", for: .normal)
        view.addTarget(self, action: #selector(goToSafariView), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        setupLayoutConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(imageUrl: String, title: String, author: String, date: String, content: String) {
        newsTitleLabel.text = title
        newsAuthorLabel.text = author
        newsDateLabel.text = date
        newsContentLabel.text = content
        
        DispatchQueue.global().async {
            if let urlPhoto = URL(string: imageUrl) {
                do {
                    let data = try Data(contentsOf: urlPhoto)
                    let image = UIImage(data: data)
                    DispatchQueue.main.async { [ weak self ] in
                        guard let self = self else { return }
                        self.newsImageView.image = image
                    }
                } catch _ {}
            }
        }
    }
    
    private func setupLayoutConstraints() {
        addSubview(newsImageView)
        addSubview(newsTitleLabel)
        addSubview(newsAuthorLabel)
        addSubview(newsDateLabel)
        addSubview(newsContentLabel)
        addSubview(fullArticleButton)
        
        NSLayoutConstraint.activate([
            newsImageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            newsImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
            newsImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            newsImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            
            newsTitleLabel.centerXAnchor.constraint(equalTo: newsImageView.centerXAnchor),
            newsTitleLabel.widthAnchor.constraint(equalTo: newsImageView.widthAnchor),
            newsTitleLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 10),
            
            newsAuthorLabel.centerXAnchor.constraint(equalTo: newsTitleLabel.centerXAnchor),
            newsAuthorLabel.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: 5),
            
            newsDateLabel.topAnchor.constraint(equalTo: newsAuthorLabel.bottomAnchor, constant: 5),
            newsDateLabel.centerXAnchor.constraint(equalTo: newsAuthorLabel.centerXAnchor),
            
            newsContentLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            newsContentLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            newsContentLabel.topAnchor.constraint(equalTo: newsDateLabel.bottomAnchor, constant: 15),
            
            fullArticleButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            fullArticleButton.topAnchor.constraint(equalTo: newsContentLabel.bottomAnchor, constant: 5),
            fullArticleButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4)
        ])
    }
    
    @objc func goToSafariView() {
        pushToSafariView()
    }
}
