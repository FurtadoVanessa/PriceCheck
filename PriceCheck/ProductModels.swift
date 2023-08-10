import Foundation

struct Product: Codable, Identifiable {
    let id: UUID
    let name: String
    let type: ProductType
    let options: [Option]
    
    init(id: UUID = UUID(), name: String, type: ProductType, options: [Option]) {
        self.id = id
        self.name = name
        self.type = type
        self.options = options
    }
    
    enum ProductType: String, Codable, CaseIterable {
        case solid = "solid"
        case liquid = "liquid"
        case length = "length"
    }
    
    struct Option: Codable, Equatable, Identifiable {
        var id: UUID
        var quantity: Int?
        var size: Int?
        var unitOfDisplay: Double
        var price: Double?
        var pricePerBaseUnit: Double?
        
        init(id: UUID = UUID(), quantity: Int? = nil, size: Int? = nil, unitOfDisplay: Double = 1.0, price: Double? = nil, pricePerBaseUnit: Double? = nil) {
            self.id = id
            self.quantity = quantity
            self.size = size
            self.unitOfDisplay = unitOfDisplay
            self.price = price
            self.pricePerBaseUnit = pricePerBaseUnit
        }
    }
    
    func getDisplayedMeasure(for option: Option) -> String {
        switch type {
        case .solid:
            return SolidUnitMeasures(rawValue: option.unitOfDisplay)?.stringValues() ?? ""
        case .liquid:
            return LiquidUnitMeasures(rawValue: option.unitOfDisplay)?.stringValues() ?? ""
        case .length:
            return SolidUnitMeasures(rawValue: option.unitOfDisplay)?.stringValues() ?? ""
        }
    }
}

enum SolidUnitMeasures: Double, CaseIterable {
    case kg = 1000
    case grams = 1.0
    case lbs = 453.59237
    case stone = 6350.29318
    case quarter = 11340.46226
    case hundredweight = 453592.37
    
    func stringValues() -> String {
        switch self {
        case .kg:
            return "kg"
        case .grams:
            return "grs"
        case .lbs:
            return "lbs"
        case .stone:
            return "stone"
        case .quarter:
            return "quarter"
        case .hundredweight:
            return "hundredweight"
        }
    }
}

enum LiquidUnitMeasures: Double, CaseIterable {
    case liter = 1000
    case milliliters = 1.0
    case gallon = 3785.411784
    case ounce = 29.57353
    case cup = 236.588237
    case pint = 473.176473
    
    func stringValues() -> String {
        switch self {
        case .liter:
            return "l"
        case .milliliters:
            return "ml"
        case .gallon:
            return "gl"
        case .ounce:
            return "oz"
        case .cup:
            return "cup"
        case .pint:
            return "pint"
        }
    }
}

enum LengthUnitMeasures: Double, CaseIterable {
    case meter = 1.0
    case kilometer = 1000
    case millimeter = 0.001
    case centimeter = 0.01
    case inch = 0.0254
    case foot = 0.3048
    case yard = 0.9144
    
    func stringValues() -> String {
        switch self {
        case .meter:
            return "m"
        case .kilometer:
            return "km"
        case .millimeter:
            return "mm"
        case .centimeter:
            return "cm"
        case .inch:
            return "in"
        case .foot:
            return "ft"
        case .yard:
            return "yd"
        }
    }
}
