//
//  LoginViewController.swift
//  SOPT_Week4_NetWork
//
//  Created by 정정욱 on 11/2/24.
//

import UIKit
import SwiftUI

import Then
import SnapKit

final class LoginViewController: UIViewController {
    
    private let titleLabel = UILabel().then {
        $0.text = "SOPT iOS 4WEEK!"
        $0.font = .boldSystemFont(ofSize: 24)
        $0.textColor = #colorLiteral(red: 0.837, green: 0.837, blue: 0.837, alpha: 1)
    }
    
    private lazy var userNameTextFieldView = UIView().then {
        $0.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
        $0.addSubview(usernameTextField)
        $0.addSubview(usernameInfoLabel)
    }
    
    private let usernameInfoLabel = UILabel().then {
        $0.text = "가입된 사용자의 이름"
        $0.font = .systemFont(ofSize: 18)
        $0.textColor = #colorLiteral(red: 0.837, green: 0.837, blue: 0.837, alpha: 1)
    }
    
    private lazy var usernameTextField = UITextField().then {
        $0.backgroundColor = .clear
        $0.textColor = .white
        $0.tintColor = .white
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.keyboardType = .emailAddress
        $0.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
    }
    
    private lazy var passwordTextFieldView = UIView().then {
        $0.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
        $0.addSubview(passwordTextField)
        $0.addSubview(passwordInfoLabel)
        $0.addSubview(passwordSecureButton)
    }
    
    private let passwordInfoLabel = UILabel().then {
        $0.text = "비밀번호"
        $0.font = .systemFont(ofSize: 18)
        $0.textColor = #colorLiteral(red: 0.837, green: 0.837, blue: 0.837, alpha: 1)
    }
    
    private lazy var passwordTextField = UITextField().then {
        $0.backgroundColor = .clear
        $0.textColor = .white
        $0.tintColor = .white
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.isSecureTextEntry = true
        $0.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
    }
    
    private lazy var passwordSecureButton = UIButton(type: .custom).then {
        $0.setTitle("표시", for: .normal)
        $0.setTitleColor(#colorLiteral(red: 0.837, green: 0.837, blue: 0.837, alpha: 1), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .light)
        $0.addTarget(self, action: #selector(passwordSecureModeSetting), for: .touchUpInside)
    }
    
    private lazy var loginButton = UIButton(type: .custom).then {
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 5
        $0.layer.borderWidth = 1
        $0.layer.borderColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        $0.setTitle("로그인", for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 16)
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    private lazy var stackView = UIStackView(arrangedSubviews: [userNameTextFieldView, passwordTextFieldView, loginButton]).then {
        $0.spacing = 18
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.alignment = .fill
    }
    
    private lazy var signUpButton = UIButton().then {
        $0.setTitle("회원 가입", for: .normal)
        $0.backgroundColor = .red
        $0.layer.cornerRadius = 5
        $0.layer.borderWidth = 1
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(changeModeButtonTapped), for: .touchUpInside)
    }

    private let textViewHeight: CGFloat = 48
    lazy var emailInfoLabelCenterYConstraint = usernameInfoLabel.centerYAnchor.constraint(equalTo: userNameTextFieldView.centerYAnchor)
    lazy var passwordInfoLabelCenterYConstraint = passwordInfoLabel.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        setStyle()
        setUI()
        setLayout()
        // 토큰이 있다면 자동으로 로그인 처리
        checkForExistingToken()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // 부모 클래스의 기본 동작 호출
        usernameTextField.text = ""
        passwordTextField.text = ""
    }

    private func setStyle() {
        self.view.backgroundColor = .black
    }
    
    private func setUI() {
        [titleLabel, stackView, signUpButton].forEach { view.addSubview($0) }
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(220)
            $0.centerX.equalToSuperview()
        }
        
        usernameInfoLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(userNameTextFieldView).inset(8)
            emailInfoLabelCenterYConstraint.isActive = true
        }
        
        usernameTextField.snp.makeConstraints {
            $0.top.equalTo(userNameTextFieldView).offset(15)
            $0.bottom.equalTo(userNameTextFieldView).offset(-2)
            $0.leading.trailing.equalTo(userNameTextFieldView).inset(8)
        }
        
        passwordInfoLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(passwordTextFieldView).inset(8)
            passwordInfoLabelCenterYConstraint.isActive = true
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextFieldView).offset(15)
            $0.bottom.equalTo(passwordTextFieldView).offset(-2)
            $0.leading.trailing.equalTo(passwordTextFieldView).inset(8)
        }
        
        passwordSecureButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextFieldView).offset(15)
            $0.bottom.equalTo(passwordTextFieldView).offset(-15)
            $0.trailing.equalTo(passwordTextFieldView).offset(-8)
        }
        
        stackView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(textViewHeight * 3 + 36)
        }
        
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(44)
        }
    }
    
    private func checkForExistingToken() {
        // UserDefaults에서 토큰을 확인
        if let token = UserDefaults.standard.string(forKey: "userToken"), !token.isEmpty {
            // 토큰이 있다면 자동으로 로그인 처리를 호출
            print("자동 로그인: 기존 토큰이 발견되었습니다.")
            
            // 다음 페이지로 넘어가기
            let mcController = MainViewController() 
            self.navigationController?.pushViewController(mcController, animated: true)
        }
    }
    
    @objc func nextButtonTapped() {
        UserService.shared.Login(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "") { result in
            switch result {
            case .success(let loginResponse):
                // 로그인 성공 시 토큰을 받아서 처리
                let token = loginResponse.result.token // LoginResponse에서 토큰 추출
                print("Received token: \(token)")
                
                UserDefaults.standard.set(token, forKey: "userToken")
                
                let mcController = MainViewController()
                self.navigationController?.pushViewController(mcController, animated: true)
                
            case .failure(let error):
                print("에러 표시: \(error)")
            }
        }
    }
 
    @objc func passwordSecureModeSetting() {
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    @objc func changeModeButtonTapped() {
          let signUpView = SignUpView()
          let hostingController = UIHostingController(rootView: signUpView)
          present(hostingController, animated: true, completion: nil)
      }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    // MARK: - 텍스트필드 편집 시작할때의 설정 - 문구가 위로올라가면서 크기 작아지고, 오토레이아웃 업데이트

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == usernameTextField {
            userNameTextFieldView.backgroundColor = #colorLiteral(red: 0.2972877622, green: 0.2973434925, blue: 0.297280401, alpha: 1)
            usernameInfoLabel.font = UIFont.systemFont(ofSize: 11)
            emailInfoLabelCenterYConstraint.constant = -13 // 오토레이아웃 업데이트
        }
        
        if textField == passwordTextField {
            passwordTextFieldView.backgroundColor = #colorLiteral(red: 0.2972877622, green: 0.2973434925, blue: 0.297280401, alpha: 1)
            passwordInfoLabel.font = UIFont.systemFont(ofSize: 11)
            passwordInfoLabelCenterYConstraint.constant = -13
        }
        
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded() // 하위에 있는 모든걸 자연 스럽게 이동 시키는 코드
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == usernameTextField {
            userNameTextFieldView.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            if usernameTextField.text == "" { // 빈칸이면 원래로 되돌리기
                usernameInfoLabel.font = UIFont.systemFont(ofSize: 18)
                emailInfoLabelCenterYConstraint.constant = 0
            }
        }
        if textField == passwordTextField {
            passwordTextFieldView.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            if passwordTextField.text == "" {
                passwordInfoLabel.font = UIFont.systemFont(ofSize: 18)
                passwordInfoLabelCenterYConstraint.constant = 0
            }
        }
        // 0.3 초동안 애니메이션 효과가 일어남 : 오토레이아웃 동적 조정할때는 이런 애니메이션 코드를 꼭 삽입해주기
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
        }
    }
    
    // MARK: - 이메일텍스트필드, 비밀번호 텍스트필드 두가지 다 채워져 있을때, 로그인 버튼 빨간색으로 변경
    
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " { // 텍스트 필드가 한게인데 공백문자면
                textField.text = "" // 빈 문자열로 만들고 해당 함수 빠져나감
                return
            }
        }
        guard
            let email = usernameTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty
        else {
            loginButton.backgroundColor = .clear
            loginButton.isEnabled = false
            return
        }
        loginButton.backgroundColor = .red
        loginButton.isEnabled = true // 버튼을 활성화 시킴
    }
}

