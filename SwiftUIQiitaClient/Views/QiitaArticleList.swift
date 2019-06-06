//
//  QiitaArticleList.swift
//  SwiftUIQiitaClient
//
//  Created by 伊藤凌也 on 2019/06/07.
//  Copyright © 2019 ry-itto. All rights reserved.
//

import SwiftUI

struct QiitaArticleList : View {
    @EnvironmentObject var viewModel: QiitaArticleListViewModel
    var body: some View {
        NavigationView {
            List(viewModel.articles) { article in
                NavigationButton(destination: QiitaArticleDetail()) {
                    QiitaArticleRow(article: article)
                        .environmentObject(self.viewModel)
                }
            }
            .navigationBarTitle(Text("\"Swift\"の新着記事一覧"))
        }
    }
}

#if DEBUG
struct QiitaArticleList_Previews : PreviewProvider {
    static var previews: some View {
        QiitaArticleList()
            .environmentObject(QiitaArticleListViewModel())
    }
}
#endif
