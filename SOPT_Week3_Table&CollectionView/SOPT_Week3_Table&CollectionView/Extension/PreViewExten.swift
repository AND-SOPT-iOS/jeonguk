//
//  preViewExten.swift
//  SOPT_Week3_Table&CollectionView
//
//  Created by 정정욱 on 10/30/24.
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

extension UICollectionViewCell {
    private struct Preview: UIViewControllerRepresentable {
        let cell: UICollectionViewCell
        
        func makeUIViewController(context: Context) -> UIViewController {
            let viewController = UIViewController()
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
            collectionView.addSubview(cell)
            viewController.view.addSubview(collectionView)
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            // Here you can update the cell or collectionView if needed
        }
    }
    
    func toPreview() -> some View {
        Preview(cell: self)
    }
}


extension UIView {
    private struct Preview: UIViewRepresentable {
        let view: UIView
        
        func makeUIView(context: Context) -> UIView {
            return view
        }
        
        func updateUIView(_ uiView: UIView, context: Context) {
            // Here you can update the UIView if needed
        }
    }
    
    func toPreview() -> some View {
        Preview(view: self)
    }
}
#endif
