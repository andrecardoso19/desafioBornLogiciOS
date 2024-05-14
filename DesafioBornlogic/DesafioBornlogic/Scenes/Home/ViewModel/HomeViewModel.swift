//
//  HomeViewModel.swift
//  DesafioBornlogic
//
//  Created by André Cardoso Aragão on 14/05/24.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func onSuccess()
    func onFailure(message: String)
}

protocol HomeViewModelProtocol {
    var newsList: [NewsArticle] { get }
    var delegate: HomeViewModelDelegate? { get set }
    func getNewsData()
}

final class HomeViewModel: HomeViewModelProtocol {
    let service: NewsServiceProtocol
    weak var delegate: HomeViewModelDelegate?
    
    init(service : NewsServiceProtocol = NewsService()) {
        self.service = service
    }
    
    private (set) var newsList: [NewsArticle] = [NewsArticle]()
    
    internal func getNewsData() {
        service.fetchNews { [ weak self ] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let newsList):
                self.newsList = newsList
                self.delegate?.onSuccess()
            case .failure(let error):
                self.delegate?.onFailure(message: error.message)
            }
        }
    }
}
