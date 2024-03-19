//
//  SystemExtensions.swift
//  AppDioNews
//
//  Created by Mrpay on 18/03/24.
//

import Foundation
import UIKit

extension Date{
    func ToString(with formater:String = "dd/MM/yyyy")->String{
        let dateFormat = DateFormatter()
        if(Calendar.current.isDateInToday(self)){
            dateFormat.dateFormat = "HH:mm"
            dateFormat.locale = Locale.init(identifier: "pt-br")
            dateFormat.timeZone = TimeZone(abbreviation: "UTC")
            return "Hoje às \(dateFormat.string(from: self))"
        }
        dateFormat.dateFormat = formater
        return dateFormat.string(from: self)
    }
}

extension UIImageView{
    func downloaded(from url:URL,contentMode mode: ContentMode = .scaleAspectFill){
        contentMode = mode
        URLSession.shared.dataTask(with: url){
            data,response,error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mineType = response?.mimeType, mineType.hasPrefix("image"),
                let data = data,error == nil,
                let image = UIImage(data: data)
            else{
                DispatchQueue.main.async {
                    [weak self] in
                    self?.image = UIImage(named: "NoImage.png")
                }
                return
            }
            DispatchQueue.main.async{[weak self] in
                self?.image = image
                
            }
        }.resume()
    }
    func LoadImage(from link:String?, contentMode mode:ContentMode = .scaleAspectFill){
        
        guard let link = link, let url = URL(string: link) else{
            self.image = UIImage(named: "NoImage.png")
            return
        }
        downloaded(from: url, contentMode: contentMode)
        let image = UIImage(named:"NoImage.png")
        if image == nil {
            print("imagem nao carregada")
        }
        self.image = image
    }
}
