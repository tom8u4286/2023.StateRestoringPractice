//
//  Product.swift
//  2023.StateRestoringPractice
//
//  Created by 曲奕帆(Tomtom) on 2023/4/27.
//

import Foundation

struct Product: Hashable, Codable {

    // MARK: - Types

    /// 有關於CodingKey類別的說明，可參考：
    /// https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/利用-enum-codingkeys-客製-json-對應的-property-1b27f29c0c32
    ///
    /// 主要的功能就是將JSON解析出來Key值，對應到這個Struct的變數中。
    /// 但是目前我們的JSON檔的Key值都與變數都相同，因此不需要另外在撰寫如 case name = "nameOfProudct" 等等。
    ///
    /// -Authors: Tomtom Chu
    /// -Date: 2023.4.26
    private enum CoderKeys: String, CodingKey {
        case text
    }

    // MARK: - Properties
    
    var text: String
        
    // MARK: - Initializers
    
    init(text: String) {
        self.text = text
    }
    
    // MARK: - Data Representation
    
    // Given the endoded JSON representation, return a product instance.
    func decodedProduct(data: Data) -> Product? {
        var product: Product?
        let decoder = JSONDecoder()
        if let decodedProduct = try? decoder.decode(Product.self, from: data) {
            product = decodedProduct
        }
        return product
    }
    
    // MARK: - Codable
    
    // For NSUserActivity scene-based state restoration.
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CoderKeys.self)
        try container.encode(text, forKey: .text)
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CoderKeys.self)

        let decodedText = try values.decode(String.self, forKey: .text)
        text = String(decodedText)
        
    }
    
}
