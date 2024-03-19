//
//  NewsListLocalDataProvider.swift
//  AppDioNews
//
//  Created by Mrpay on 15/03/24.
//

import Foundation

protocol NewsListDataProviderProcotol: DataProviderProcotol { }

class NewsListDataProvider : DataProvider<NewsListDataProviderProcotol,NewsModel>{
    func getNewsList(){
        // implementacao da clousure
        NewsRepository.shared.getNewsList {newModelList,error in
            if let error = error{
                self.delegate?.errorData(self.delegate, error: error)
                return
            }
            if let model = newModelList{
                self.delegate?.success(model: model)
            }
        }
    }
    
}
