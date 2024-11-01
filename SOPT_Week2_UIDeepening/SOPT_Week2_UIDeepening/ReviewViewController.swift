//
//  ReviewViewController.swift
//  SOPT_Week2_UIDeepening
//
//  Created by 정정욱 on 10/25/24.
//

import UIKit
import SnapKit

protocol ReviewDelegate: AnyObject {
    func dataBind(titleText: String, subtitleText: String, userInput: String)
}


class ReviewViewController: UIViewController {
    
    weak var delegate: ReviewDelegate?
        
    
    // 제목 입력 필드
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "제목 입력"
        textField.font = UIFont.boldSystemFont(ofSize: 24)
        textField.textColor = .black
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 8
        textField.setLeftPaddingPoints(8) // 좌측 여백 추가
        return textField
    }()
    
    // 서브 제목 입력 필드
    private let subtitleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "서브 제목 입력"
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.textColor = .black
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 8
        textField.setLeftPaddingPoints(8) // 좌측 여백 추가
        return textField
    }()
    
    // 본문 타이틀 라벨
    private let bodyTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "본문 타이틀"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0 // 여러 줄 표시 가능
        return label
    }()
    
    // 사용자 입력 텍스트뷰
    private let userInputTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = .black
        textView.backgroundColor = .secondarySystemBackground
        textView.layer.cornerRadius = 8
        textView.isScrollEnabled = true
        return textView
    }()
    
    // 저장 버튼
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("저장", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupLayout()
    }
    
    private func setupLayout() {
        // 스택뷰 생성 및 속성 설정
        let stackView = UIStackView(arrangedSubviews: [titleTextField, subtitleTextField, bodyTitleLabel, userInputTextView, saveButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        
        view.addSubview(stackView)
        
        // SnapKit을 사용하여 제약 조건 설정
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        // 텍스트뷰와 버튼 높이 설정
        userInputTextView.snp.makeConstraints { make in
            make.height.equalTo(150)
        }
        
        saveButton.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
    }
    
    // 저장 버튼이 눌렸을 때 실행되는 메서드
    @objc private func saveButtonTapped() {
        guard let titleText = titleTextField.text, !titleText.isEmpty,
              let subtitleText = subtitleTextField.text, !subtitleText.isEmpty,
              let userInput = userInputTextView.text, !userInput.isEmpty else {
            print("모든 입력란을 채워주세요.")
            return
        }
        
        // 입력된 텍스트 처리
        print("제목: \(titleText)")
        print("서브 제목: \(subtitleText)")
        print("본문: \(userInput)")
        
        
        delegate?.dataBind(titleText: titleText, subtitleText: subtitleText, userInput: userInput)
        
            
        
        self.navigationController?.popViewController(animated: true)
        
        
    }
}

// UITextField에 왼쪽 여백을 설정하기 위한 확장
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
