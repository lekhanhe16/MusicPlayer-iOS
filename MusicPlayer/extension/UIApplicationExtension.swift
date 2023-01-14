//
//  UIApplicationExtension.swift
//  MusicPlayer
//
//  Created by acupofstarbugs on 03/01/2023.
//

import Foundation
import UIKit

extension UIApplication {
    var keyWindow: UIWindow? {
            // Get connected scenes
            return UIApplication.shared.connectedScenes
                // Keep only active scenes, onscreen and visible to the user
                .filter { $0.activationState == .foregroundActive }
                // Keep only the first `UIWindowScene`
                .first(where: { $0 is UIWindowScene })
                // Get its associated windows
                .flatMap({ $0 as? UIWindowScene })?.windows
                // Finally, keep only the key window
                .first(where: \.isKeyWindow)
        }
}

//extension UIApplication {
//    static var keyWindow: UIWindow? {
//        return shared.windows.first(where: {$0.isKeyWindow})
//    }
//}
