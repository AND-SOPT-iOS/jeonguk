//
//  ReviewView.swift
//  SOPT_Week3_Table&CollectionView
//
//  Created by 정정욱 on 11/1/24.
//

import UIKit
import SnapKit
import Then

class ReviewView: UIView {

    // MARK: - Properties
    private lazy var reviewView: UIView = {
        return UIView().then {_ in 
            let mainVStack = UIStackView().then {
                $0.axis = .vertical
                $0.spacing = 4
                $0.alignment = .leading
            }
            
            let titleAndArrowStackView = UIStackView().then {
                $0.axis = .horizontal
                $0.spacing = 4
                $0.alignment = .center
            }
            
            let titleLabel = UILabel().then {
                $0.text = "평가 및 리뷰"
                $0.textColor = .white
                $0.font = UIFont.boldSystemFont(ofSize: 24)
            }
            
            let arrowImageView = UIImageView().then {
                $0.image = UIImage(systemName: "chevron.right")
                $0.tintColor = .systemGray
                $0.contentMode = .scaleAspectFit
            }
            
            titleAndArrowStackView.addArrangedSubview(titleLabel)
            titleAndArrowStackView.addArrangedSubview(arrowImageView)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(reviewTapped))
            titleAndArrowStackView.addGestureRecognizer(tapGesture)
            titleAndArrowStackView.isUserInteractionEnabled = true
            
            let ratingAndStarsStackView = UIStackView().then {
                $0.axis = .horizontal
                $0.spacing = 140
                $0.alignment = .lastBaseline
            }
            
            let ratingLabel = UILabel().then {
                $0.text = "4.4"
                $0.textColor = .white
                $0.font = UIFont.boldSystemFont(ofSize: 54)
            }
            
            let starsAndReviewsVStack = UIStackView().then {
                $0.axis = .vertical
                $0.spacing = 4
                $0.alignment = .center
            }
            
            let starStackView = createStarStackView(count: 4, filled: true)
            let halfStarImageView = UIImageView().then {
                $0.image = UIImage(systemName: "star.leadinghalf.filled")
                $0.tintColor = .white
                $0.contentMode = .scaleAspectFit
                $0.translatesAutoresizingMaskIntoConstraints = false
                $0.widthAnchor.constraint(equalToConstant: 24).isActive = true
                $0.heightAnchor.constraint(equalToConstant: 24).isActive = true
            }
            
            starStackView.addArrangedSubview(halfStarImageView)
            
            let reviewCountLabel = UILabel().then {
                $0.text = "8.4만개의 평가"
                $0.textColor = .systemGray
                $0.font = UIFont.boldSystemFont(ofSize: 18)
                $0.numberOfLines = 0
            }
            
            starsAndReviewsVStack.addArrangedSubview(starStackView)
            starsAndReviewsVStack.addArrangedSubview(reviewCountLabel)
            
            ratingAndStarsStackView.addArrangedSubview(ratingLabel)
            ratingAndStarsStackView.addArrangedSubview(starsAndReviewsVStack)
            
            mainVStack.addArrangedSubview(titleAndArrowStackView)
            mainVStack.addArrangedSubview(ratingAndStarsStackView)

            mainVStack.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(reviewView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc private func reviewTapped() {
        // Handle review tapped action
    }
    
    // MARK: - Helper Methods
    private func createStarStackView(count: Int, filled: Bool) -> UIStackView {
        let starStackView = UIStackView()
        starStackView.axis = .horizontal
        starStackView.spacing = 4
        starStackView.alignment = .center
        
        for _ in 0..<count {
            let starImageView = UIImageView().then {
                $0.image = UIImage(systemName: filled ? "star.fill" : "star")
                $0.tintColor = .white
                $0.contentMode = .scaleAspectFit
                $0.translatesAutoresizingMaskIntoConstraints = false
                $0.widthAnchor.constraint(equalToConstant: 24).isActive = true
                $0.heightAnchor.constraint(equalToConstant: 24).isActive = true
            }
            starStackView.addArrangedSubview(starImageView)
        }
        
        return starStackView
    }
}
