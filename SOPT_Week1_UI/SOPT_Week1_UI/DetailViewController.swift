//
//  DetailViewController.swift
//  SOPT_Week1_UI
//
//  Created by 정정욱 on 10/5/24.
//

import UIKit


protocol NicknameDelegate: AnyObject {
    func dataBind(nickname: String)
}


final class DetailViewController: UIViewController {
    
    
    weak var delegate: NicknameDelegate? // == viewController
    
    //var completionHandler: ((String) -> ())?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    

    
    private lazy var detailTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.frame.size.height = 48
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.clearsOnBeginEditing = false
        //tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("이전 화면으로", for: .normal)
        button.backgroundColor = .tintColor
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(settingButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    @objc func settingButtonTapped() {
        if let nickname = detailTextField.text {
            delegate?.dataBind(nickname: nickname)
            
            //completionHandler?(nickname) // 힙의 메모리가 살아있어서 아래 코드와 순서가 바뀌어도 동작...?
            // 클로저의 생명주기와 같음
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    // 이전 뷰에서 받을 값
    private var receivedTitle: String?
    private var receivedContent: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setUI()
        setLayout()
    }
    
    private func setStyle() {
        self.view.backgroundColor = .lightGray
    }
    
    private func setUI() {
        [titleLabel, detailTextField, contentLabel, backButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        }
    }
    
    private func setLayout() {
        NSLayoutConstraint.activate(
            [
                titleLabel.topAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.topAnchor,
                    constant: 20
                ),
                titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                contentLabel.topAnchor.constraint(
                    equalTo: titleLabel.bottomAnchor,
                    constant: 20
                ),
                contentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                detailTextField.topAnchor.constraint(equalTo:
                        contentLabel.bottomAnchor,
                        constant: 20
                ),
                detailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                detailTextField.widthAnchor.constraint(equalToConstant: 300),
                
                backButton.topAnchor.constraint(
                    equalTo: detailTextField.bottomAnchor,
                    constant: 20
                ),
                backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                backButton.heightAnchor.constraint(equalToConstant: 44),
                backButton.widthAnchor.constraint(equalToConstant: 300),
            ]
        )
    }
    
    func updateUI() {
        self.titleLabel.text = receivedTitle
        self.contentLabel.text = receivedContent
    }
    
    func dataBind(
        title: String,
        content: String
    ) {
        self.receivedTitle = title
        self.receivedContent = content
        updateUI()
    }
    
    @objc func backButtonTapped() {
        if self.navigationController == nil {
            self.dismiss(animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
}


