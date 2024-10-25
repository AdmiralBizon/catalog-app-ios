import Resources
import SwiftUI

/// List of available styles for toast notification views.
public enum ToastStyle {
    case error
}

extension ToastStyle {
    
    struct ToastConfiguration {
        let themeColor: Color
        let icon: Image
    }

    var config: ToastConfiguration {
        switch self {
        case .error:
            ToastConfiguration(
                themeColor: Colors.Toasts.error,
                icon: Image(systemName: "xmark.circle.fill")
            )
        }
    }

}
