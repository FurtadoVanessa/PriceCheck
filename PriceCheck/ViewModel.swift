import Foundation
import SwiftUI

class PriceComparisonViewModel: ObservableObject {
    
    @Published var productName = ""
    @Published var productType: Product.ProductType = .solid
    @Published var productOptions = [Product.Option]()
    
    @Published var products = [Product]()

    private let defaults = UserDefaults.standard
    
    private let userDefaultsKey = "product"

    init() {
        loadProducts()
    }
    
    func addProductOption() {
        productOptions.append(.init())
    }
    
    func clearSavedProducts() {
        products.removeAll()
        defaults.set(nil, forKey: userDefaultsKey)
    }

    func saveProduct() {
        getCheapiestOption()
        let product = Product(name: productName, type: productType, options: productOptions)
        products.append(product)
        let data = products.toData()
        defaults.set(data, forKey: userDefaultsKey)

        clearState()
    }
    
    private func clearState() {
        productName = ""
        productType = .solid
        productOptions.removeAll()
    }

    private func loadProducts() {
        if let data = defaults.data(forKey: userDefaultsKey) {
            let products = try? JSONDecoder().decode([Product].self, from: data)
            if let products = products {
                self.products = products
            }
        }
    }
    
    private func getCheapiestOption() {
        productOptions = productOptions.map { option in
            Product.Option(
                id: option.id,
                quantity: option.quantity,
                size: option.size,
                unitOfDisplay: option.unitOfDisplay,
                price: option.price,
                pricePerBaseUnit: ((option.price ?? 0.0) / Double(Double(option.size ?? 0) * option.unitOfDisplay * Double(option.quantity ?? 0))).roundToPlaces(places: 4)
            )
        }
        
        productOptions.sort { $0.pricePerBaseUnit! < $1.pricePerBaseUnit! }
    }
}
