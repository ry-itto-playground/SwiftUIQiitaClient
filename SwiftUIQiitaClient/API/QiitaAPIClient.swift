//
//  QiitaAPIClient.swift
//  SwiftUIQiitaClient
//
//  Created by 伊藤凌也 on 2019/06/07.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import Foundation

final class QiitaAPIClient {
    
    /// QiitaAPI v2 記事一覧検索
    /// https://qiita.com/api/v2/docs#get-apiv2items
    ///
    /// - Parameters:
    ///     - page: 何ページ分か, default=1
    ///     - perPage: 1ページごとの記事数, default=20
    ///     - query: 検索クエリ, 必須
    ///     - completion: 終了時処理
    static func fetchArticles(page: Int = 1, perPage: Int = 20, query: String, completion: @escaping (Result<[QiitaData.Article], Error>) -> ()) {
        var components = URLComponents(string: "https://qiita.com/api/v2/items")!
        components.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "perPage", value: "\(perPage)"),
            URLQueryItem(name: "query", value: query)
        ]
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        var request = URLRequest(url: components.url!)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                let decoded = try decoder.decode([QiitaData.Article].self, from: data!)
                completion(.success(decoded))
            } catch let e {
                completion(.failure(e))
            }
        }
        task.resume()
    }
}
