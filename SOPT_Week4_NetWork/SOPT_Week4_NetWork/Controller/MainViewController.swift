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

    }

    func showNextView() {
        let mainView = MainView()
        let hostingController = UIHostingController(rootView: mainView) // Wrap it in a UIHostingController
        
        // Present the hosting controller
        self.present(hostingController, animated: true, completion: nil)
    }
}

