//
//  MainViewController.swift
//  SOPT_Week4_NetWork
//
//  Created by 정정욱 on 11/2/24.
//

import UIKit
import SwiftUI

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        showNextView()
    }
    
    func showNextView() {
        let mainView = MainView() // SwiftUI View
        let hostingController = UIHostingController(rootView: mainView) // Wrap it in a UIHostingController
        
        // SwiftUI 뷰를 화면에 표시
        self.addChild(hostingController)
        hostingController.view.frame = self.view.bounds
        self.view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }
}

