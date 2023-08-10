import Foundation
import SwiftUI

struct ProductListView: View {
    @ObservedObject var viewModel: PriceComparisonViewModel

    var body: some View {
        VStack {
            Text("Saved Products")
            List {
                ForEach($viewModel.products, id: \.id) { $product in
                    ListOptions(product: $product)
                }
            }
            Button(action: {
                viewModel.clearSavedProducts()
            }) {
              Text("Clear Products")
          }
        }
    }
}

struct ListOptions: View {
    
    @Binding var product: Product
    
    var body: some View {
            VStack {
                HStack() {
                    Text("Name").frame(maxWidth: .infinity, alignment: .leading)
                    Text(product.name).frame(maxWidth: .infinity, alignment: .trailing)
                }
                Spacer()
                HStack {
                    Text("Type").frame(maxWidth: .infinity, alignment: .leading)
                    Text(product.type.rawValue).frame(maxWidth: .infinity, alignment: .trailing)
                }
            HStack {
                Text("Quantity")
                Spacer()
                Text("Size")
                Spacer()
                Text("Measure")
                Spacer()
                Text("Price")
                Spacer()
                Text("Price/Base Measure")
            }
            ForEach(product.options) { option in
                HStack {
                    Text(String(option.quantity ?? 0))
                    Spacer()
                    Text(String(option.size ?? 0))
                    Spacer()
                    Text(product.getDisplayedMeasure(for: option))
                    Spacer()
                    Text(String(option.price ?? 0))
                    Spacer()
                    Text(String(option.pricePerBaseUnit ?? 0))
                }
                Spacer()
            }
        }
    }
}
