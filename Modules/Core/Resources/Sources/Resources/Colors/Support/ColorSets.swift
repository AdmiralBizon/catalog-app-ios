import SwiftUI

// MARK: - ColorSets

enum ColorSets {
    enum Buttons {
        static let background = ColorAsset(name: "Buttons/background")
        static let text = ColorAsset(name: "Buttons/text")
    }

    enum Product {
        static let background = ColorAsset(name: "Product/background")
        static let imageBackground = ColorAsset(name: "Product/imageBackground")
    }

    enum Text {
        static let main = ColorAsset(name: "Text/main")
        static let support = ColorAsset(name: "Text/support")
    }
}

// MARK: - ColorAsset

final class ColorAsset {
    fileprivate(set) var name: String
    typealias Color = UIColor

    private(set) lazy var color: Color = Color(asset: self)

    func color(compatibleWith traitCollection: UITraitCollection) -> Color {
        let bundle = Bundle.module
        guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
            fatalError("Unable to load color asset named \(name).")
        }
        return color
    }

    fileprivate init(name: String) {
        self.name = name
    }
}

extension ColorAsset.Color {
    convenience init!(asset: ColorAsset) {
        let bundle = Bundle.module
        self.init(named: asset.name, in: bundle, compatibleWith: nil)
    }
}
