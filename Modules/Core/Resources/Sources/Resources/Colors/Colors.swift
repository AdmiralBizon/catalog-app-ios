import SwiftUI

/// A collection of available colors for use in the application’s UI.
public enum Colors {
    public enum Buttons {
        public static var background: Color {
            Color(uiColor: ColorSets.Buttons.background.color)
        }
        public static var text: Color {
            Color(uiColor: ColorSets.Buttons.text.color)
        }
    }

    public enum Product {
        public static var background: Color {
            Color(uiColor: ColorSets.Product.background.color)
        }
        public static var imageBackground: Color {
            Color(uiColor: ColorSets.Product.imageBackground.color)
        }
    }

    public enum Text {
        public static var main: Color {
            Color(uiColor: ColorSets.Text.main.color)
        }
        public static var support: Color {
            Color(uiColor: ColorSets.Text.support.color)
        }
    }

    public enum Toasts {
        public static var error: Color {
            Color.red
        }
    }

    public enum Shimmers {
        public static var main: Color {
            Color.black.opacity(0.05)
        }

        public static var highlighted: Color {
            Color.white.opacity(0.5)
        }
    }
}
