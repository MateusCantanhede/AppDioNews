//
//  NewsRepository.swift
//  AppDioNews
//
//  Created by Mrpay on 15/03/24.
//

import Foundation
enum NewsListError:Error{
    case FileNotFound
}
class NewsRepository{
    static var shared: NewsRepository = {
        let instance = NewsRepository()
        return instance
    }()
    
    private init (){}
    
    func getNewsList(completation: ([NewsModel]?,Error?)->Void){
        if let path = Bundle.main.path(forResource: "NewsList", ofType: "json"){
            do{
                let url = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: url, options: .mappedIfSafe)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                let newsModelList = try decoder.decode([NewsModel].self, from: data)
                completation(newsModelList,nil)
            }catch{
                completation(nil,error)
            }
        }else{
            completation(nil,NewsListError.FileNotFound)
        }
    }
}
extension DateFormatter{
    static let iso8601Full:DateFormatter = {
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formater
    }()
}
