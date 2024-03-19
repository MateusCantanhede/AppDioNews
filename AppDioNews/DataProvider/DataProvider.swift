//
//  GenericDataProvider.swift
//  AppDioNews
//
//  Created by Mrpay on 15/03/24.
//

import Foundation

protocol DataProviderProcotol{
    func success(model:Any)
    func errorData(_ provide:DataProviderProcotol?,error:Error)
}
class DataProvider<T,S>{
    var delegate:T?
    var model:S?
}
