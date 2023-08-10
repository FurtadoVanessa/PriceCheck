import Foundation
import SwiftUI

struct ProductPriceComparisonView: View {
    @ObservedObject var viewModel: PriceComparisonViewModel
    
  var body: some View {
    Form {
      Section(header: Text("Product Details")) {
          TextField("Product Name", text: $viewModel.productName)
          Picker("Product Type", selection: $viewModel.productType) {
              ForEach(Product.ProductType.allCases, id: \.self) { type in
                  Text(type.rawValue).tag(type)
              }
        }
        Button(action: {
            viewModel.addProductOption()
        }) {
          Text("Add Product Option")
        }
      }
      Section {
          ForEach($viewModel.productOptions, id: \.id) { option in
              QuantityAndUnitOfMeasureView(option: option, productType: $viewModel.productType)
          }
      }
        Section {
            Button(action: {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                saveProduct()
            }) {
              Text("Save Product")
            }
        }
    }
  }
    
    func saveProduct() {
        viewModel.saveProduct()
    }
}

struct QuantityAndUnitOfMeasureView: View {
    @Binding var option: Product.Option
    @Binding var productType: Product.ProductType
    
    var id = UUID()
    
    var body: some View {
        HStack {
            TextField("Quantity", value: $option.quantity, format: .number)
            TextField("Size", value: $option.size, format: .number)
            VStack {
                Text("Unit of measure")
                switch productType {
                case .solid:
                    Picker("", selection: $option.unitOfDisplay) {
                        ForEach(SolidUnitMeasures.allCases, id: \.self) { type in
                            Text(type.stringValues()).tag(type.rawValue)
                        }
                    }
                case .liquid:
                    Picker("", selection: $option.unitOfDisplay) {
                        ForEach(LiquidUnitMeasures.allCases, id: \.self) { type in
                            Text(type.stringValues()).tag(type.rawValue)
                        }
                    }
                case .length:
                    Picker("", selection: $option.unitOfDisplay) {
                        ForEach(LengthUnitMeasures.allCases, id: \.self) { type in
                            Text(type.stringValues()).tag(type.rawValue)
                        }
                    }
                }
            }
            TextField("Price", value: $option.price, format: .number)
        }
    }
}
