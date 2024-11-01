//
//  AppRecommendationTableView.swift
//  SOPT_Week3_Table&CollectionView
//
//  Created by 정정욱 on 10/31/24.
//

import UIKit

class AppRecommendationTableView: UIViewController {
    
    private let tableView = UITableView()
    private var appList: [App] = App.apps // 데이터 소스

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        tableView.do {
            $0.register(AppTableViewCell.self, forCellReuseIdentifier: AppTableViewCell.identifier)
            $0.delegate = self
            $0.dataSource = self
            $0.rowHeight = 80
            $0.separatorStyle = .singleLine
            $0.backgroundColor = .white
        }
    }
    
    private func setLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension AppRecommendationTableView: UITableViewDelegate { }

extension AppRecommendationTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: AppTableViewCell.identifier,
            for: indexPath
        ) as? AppTableViewCell else { return UITableViewCell() }
        
        let app = appList[indexPath.row]
        cell.configure(app: app)
        return cell
    }
}

#if DEBUG
import SwiftUI

struct AppRecommendationTableView_Previews: PreviewProvider {
    static var previews: some View {
        AppRecommendationTableView().toPreview()
    }
}
#endif
