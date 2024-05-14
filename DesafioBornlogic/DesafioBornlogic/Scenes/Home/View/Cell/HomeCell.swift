//
//  HomeCell.swift
//  DesafioBornlogic
//
//  Created by André Cardoso Aragão on 14/05/24.
//

import Foundation
import UIKit

final class HomeCell: UITableViewCell {
    private lazy var newsTitleLabel: UILabel = {
       let view = UILabel()
        view.numberOfLines = 2
        view.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var newsAuthorLabel: UILabel = {
       let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 10, weight: .light)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var newsDescriptionLabel: UILabel = {
       let view = UILabel()
        view.numberOfLines = 3
        view.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var newsImageView: UIImageView = {
       let view = UIImageView()
        view.backgroundColor = .black
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContentView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(newsTitle: String, newsAuthor: String, newsDescription: String, imageUrl: String) {
        newsTitleLabel.text = newsTitle
        newsAuthorLabel.text = newsAuthor
        newsDescriptionLabel.text = newsDescription
        
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
    
    override func prepareForReuse() {
        newsTitleLabel.text = ""
        newsAuthorLabel.text = ""
        newsDescriptionLabel.text = ""
        newsImageView.image = nil
    }
    
    private func setupContentView() {
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(newsAuthorLabel)
        contentView.addSubview(newsDescriptionLabel)
        contentView.addSubview(newsImageView)
        
        NSLayoutConstraint.activate([
            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            newsImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.95),
            newsImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25),
            
            newsTitleLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 5),
            newsTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            newsAuthorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            newsAuthorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            newsDescriptionLabel.leadingAnchor.constraint(equalTo: newsTitleLabel.leadingAnchor),
            newsDescriptionLabel.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: 5),
            newsDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            newsDescriptionLabel.bottomAnchor.constraint(equalTo: newsAuthorLabel.topAnchor, constant: -5)
        ])
    }
}
