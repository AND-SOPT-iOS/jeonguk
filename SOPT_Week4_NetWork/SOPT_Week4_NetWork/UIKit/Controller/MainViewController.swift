//
//  MainViewController.swift
//  SOPT_Week4_NetWork
//
//  Created by 정정욱 on 11/2/24.
//

import UIKit
import SwiftUI

class MainViewController: UIViewController {
    
    private let apiService: APIService  // 주입받은 apiService 저장
    init(apiService: APIService) {
         self.apiService = apiService
         super.init(nibName: nil, bundle: nil)
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        showNextView()
    }
    
    // SwiftUI 뷰를 화면에 표시
        func showNextView() {
            let mainView = MainView(apiService: apiService)
            let hostingController = UIHostingController(rootView: mainView)
            self.addChild(hostingController)
            hostingController.view.frame = self.view.bounds
            self.view.addSubview(hostingController.view)
            hostingController.didMove(toParent: self)
        }
}

