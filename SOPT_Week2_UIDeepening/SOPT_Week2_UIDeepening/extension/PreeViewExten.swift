//
//  PreeViewExten.swift
//  SOPT_Week2_UIDeepening
//
//  Created by 정정욱 on 10/18/24.
//

import SwiftUI


#if DEBUG
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
            let viewController: UIViewController

            func makeUIViewController(context: Context) -> UIViewController {
                return viewController
            }

            func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            }
        }

        func toPreview() -> some View {
            Preview(viewController: self)
        }
}
#endif
