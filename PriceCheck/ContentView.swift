import SwiftUI

struct TabbedView: View {
    @State private var selectedTab = 0
    
    @ObservedObject var viewModel = PriceComparisonViewModel()

    var body: some View {
        TabView(selection: $selectedTab) {
            ProductPriceComparisonView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "star")
                    Text("Compare")
                }
            ProductListView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "clock")
                    Text("History")
                }
        }
    }
}

struct ProductPriceComparisonView_Previews: PreviewProvider {
  static var previews: some View {
      TabbedView()
  }
}
