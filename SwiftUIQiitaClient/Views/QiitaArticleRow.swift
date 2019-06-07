//
//  QiitaArticleRow.swift
//  SwiftUIQiitaClient
//
//  Created by 伊藤凌也 on 2019/06/07.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import SwiftUI

struct QiitaArticleRow : View {
    @EnvironmentObject var viewModel: QiitaArticleListViewModel
    
    let article: QiitaData.Article
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "book")
                    .imageScale(.medium)
                    .font(.title)
                    .foregroundColor(Color.green)
                Text(article.title)
                    .bold()
                    .lineLimit(3)
                Spacer()
            }
            
            Spacer()
            
            HStack {
                Image(systemName: "heart.fill")
                    .imageScale(.small)
                    .foregroundColor(Color.red)
                Text(("\(article.reactionsCount)"))
                    .font(.subheadline)
                Spacer()
                Text("by @\(article.user.id)")
                    .font(.caption)
                    .color(.gray)
                    .fontWeight(Font.Weight.light)
            }
        }
    }
}

#if DEBUG
struct QiitaArticleRow_Previews : PreviewProvider {
    static var previews: some View {
        QiitaArticleRow(article: QiitaArticleListViewModel().articles[0])
            .environmentObject(QiitaArticleListViewModel())
    }
}
#endif
