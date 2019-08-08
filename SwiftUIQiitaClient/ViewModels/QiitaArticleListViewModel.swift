//
//  QiitaArticleListViewModel.swift
//  SwiftUIQiitaClient
//
//  Created by 伊藤凌也 on 2019/06/07.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import Combine
import SwiftUI

final class QiitaArticleListViewModel: ObservableObject, Identifiable {
    
    private var cancellables: Set<AnyCancellable> = []
    var objectWillChange: ObservableObjectPublisher = ObservableObjectPublisher()
    
    private(set) var articles: [QiitaData.Article] = [] {
        didSet {
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    
    init() {
        QiitaAPIClient.fetchArticles(query: "Swift")
            .sink(receiveCompletion: { fail in
                switch fail {
                case .failure(let e):
                    print(e.localizedDescription)
                case .finished:
                    print("finished")
                }
            }) { articles in
                self.articles = articles
            }.store(in: &cancellables)
    }
}
