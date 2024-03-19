//
//  NewsModel.swift
//  AppDioNews
//
//  Created by Mrpay on 15/03/24.
//

import Foundation
struct NewsModel: Codable {
    var source:SourceModel
    var autor:String?
    var title:String?
    var description:String?
    var url:String
    var urlToImage:String?
    var publishedAt:Date
    var content:String?
}
