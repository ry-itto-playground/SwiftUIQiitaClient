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
    var objectWillChange: ObservableObjectPublisher = ObservableObjectPublisher()
    
    private(set) var articles: [QiitaData.Article] = [] {
        didSet {
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    
    init() {
        QiitaAPIClient.fetchArticles(query: "Swift") { (result) in
            switch result {
            case .success(let articles):
                self.articles = articles
            case .failure:
                fatalError("fetch error")
            }
        }
    }
}
