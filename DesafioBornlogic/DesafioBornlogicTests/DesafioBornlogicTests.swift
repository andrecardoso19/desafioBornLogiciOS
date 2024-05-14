//
//  DesafioBornlogicTests.swift
//  DesafioBornlogicTests
//
//  Created by André Cardoso Aragão on 14/05/24.
//

import XCTest
@testable import DesafioBornlogic

final class NewsServiceMock : NewsServiceProtocol {
    var expectedResult: (Result<[NewsArticle], NewsArticleError>) = .failure(.dataError)
    
    func fetchNews(completion: @escaping (Result<[NewsArticle], NewsArticleError>) -> Void) {
        completion(expectedResult)
    }
}

final class HomeViewModelDelegateSpy: HomeViewModelDelegate {
    var onSuccessCount = 0
    func onSuccess() {
        onSuccessCount += 1
    }
    
    var onFailureCount = 0
    func onFailure(message: String) {
        onFailureCount += 1
    }
}


final class DesafioBornlogicTests: XCTestCase {
    typealias Sut = (viewModel: HomeViewModelProtocol, delegate: HomeViewModelDelegateSpy, service: NewsServiceMock)
    
    private func makeSut() -> Sut {
        let serviceMock = NewsServiceMock()
        let sut = HomeViewModel(service: serviceMock)
        let delegateSpy = HomeViewModelDelegateSpy()
        sut.delegate = delegateSpy
        
        return (sut, delegateSpy, serviceMock)
    }
    
    func testGetNews_WhenFailure_ShouldCallDelegateOnFailure() {
        let sut = makeSut()
        sut.service.expectedResult = .failure(.dataError)
        
        sut.viewModel.getNewsData()
        
        XCTAssertEqual(sut.delegate.onFailureCount, 1)
    }
    
    func testGetNews_WhenSuccess_ShouldCallDelegateOnSuccess() {
        let sut = makeSut()
        let news = [NewsArticle(author: "Author", title: "Title", description: "Description", urlToImage: "urlImage")]
        sut.service.expectedResult = .success(news)
        
        sut.viewModel.getNewsData()
        
        XCTAssertEqual(sut.viewModel.newsList, news)
        XCTAssertEqual(sut.delegate.onSuccessCount, 1)
    }
}
