//
//  DataModel.swift
//  2023.StateRestoringPractice
//
//  Created by 曲奕帆(Tomtom) on 2023/4/27.
//

import UIKit


// Singleton data model.
class DataModelManager {
    static let sharedInstance: DataModelManager = {
        let instance = DataModelManager()
        instance.loadDataModel()
        return instance
    }()
    
    var dataModel: DataModel!
    
    private let dataFileName = "Products"
    
    private func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    private func dataModelURL() -> URL {
        let docURL = documentsDirectory()
        return docURL.appendingPathComponent(dataFileName)
    }

    func saveDataModel() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(dataModel) {
            do {
                // Save the 'Products' data file to the Documents directory.
                try encoded.write(to: dataModelURL())
            } catch {
                print("Couldn't write to save file: " + error.localizedDescription)
            }
        }
    }
    
    func loadDataModel() {
        // Load the data model from the 'Products' data file in the Documents directory.
        guard let codedData = try? Data(contentsOf: dataModelURL()) else {
            // No data on disk, create a new data model.
            dataModel = DataModel()
            return
        }
        // Decode the JSON file into a DataModel object.
        let decoder = JSONDecoder()
        if let decoded = try? decoder.decode(DataModel.self, from: codedData) {
            dataModel = decoded
        }
    }
    
    // MARK: - Accessors
    
    func products() -> [Product] {
        return dataModel.products
    }
    
    // 以Product名稱，找出DataModel中的特定Product。
//    func product(fromTitle: String) -> Product? {
//        let filteredProducts = dataModel.products.filter { product in
//            let productTitle = product.name.lowercased()
//            if productTitle == fromTitle.lowercased() { return true } else { return false }
//        }
//        if filteredProducts.count == 1 {
//            return filteredProducts[0]
//        } else {
//            return nil
//        }
//    }
    
    // 以product identifier，找出DataModel中的特定Product。
    func product(fromIdentifier: String) -> Product? {
        let filteredProducts = dataModel.products.filter { product in
            let productIdentifier = product.identifier.uuidString
            if productIdentifier == fromIdentifier { return true } else { return false }
        }
        if filteredProducts.isEmpty {
            fatalError("Can't find product from identifier.")
        }
        return filteredProducts[0]
    }
    
    // MARK: - Actions
     
    func remove(atLocation: Int) {
        dataModel.products.remove(at: atLocation)
    }
    
    func insert(product: Product, atLocation: Int) {
        dataModel.products.insert(product, at: atLocation)
    }

}


/// 儲存Product陣列的資料結構。
///
/// -Authors: Tomtom Chu
/// -Date: 2023.4.26
struct DataModel: Codable {
    
    var products: [Product] = []
    
    /// 有關於CodingKey類別的說明，可參考：
    /// https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/利用-enum-codingkeys-客製-json-對應的-property-1b27f29c0c32
    ///
    /// 主要的功能就是將JSON解析出來Key值，對應到這個Struct的變數中。
    /// 但是目前我們的JSON檔的Key值都與變數都相同，因此不需要另外在撰寫如 case name = "nameOfProudct" 等等。
    ///
    /// -Authors: Tomtom Chu
    /// -Date: 2023.4.26
    private enum CodingKeys: String, CodingKey {
        case products
    }
    
    // MARK: - Codable
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(products, forKey: .products)
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        products = try values.decode(Array.self, forKey: .products)
    }
    
    init() {
        /// No data on disk, read the products from the JSON file.
        /// 當沒有資料被存在disk時，從JSON檔讀取資料。
        ///
        /// -Authors: Tomtom Chu
        /// -Date: 2023.4.25
        products = Bundle.main.decode("products.json")
    }

}


// MARK: Bundle

extension Bundle {
    func decode(_ file: String) -> [Product] {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        let decoder = JSONDecoder()
        guard let loaded = try? decoder.decode([Product].self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        return loaded
    }
}
