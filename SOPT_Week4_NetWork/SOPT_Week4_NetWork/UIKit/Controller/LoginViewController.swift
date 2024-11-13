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
    
    // MARK: - Constants
    
    private let apiService: APIService
    private let keyChainManager: KeyChainManager
    private let textViewHeight: CGFloat = 48
    
    private lazy var emailInfoLabelCenterYConstraint = usernameInfoLabel.centerYAnchor
        .constraint(equalTo: usernameTextFieldView.centerYAnchor)
    private lazy var passwordInfoLabelCenterYConstraint = passwordInfoLabel.centerYAnchor
        .constraint(equalTo: passwordTextFieldView.centerYAnchor)
    
    private var id: String {
        return usernameTextField.text ?? ""
    }
    private var password: String {
        return passwordTextField.text ?? ""
    }
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel()
    private let usernameTextFieldView = UIView()
    private let usernameInfoLabel = UILabel()
    private lazy var usernameTextField = UITextField()
    private lazy var passwordTextFieldView = UIView()
    private let passwordInfoLabel = UILabel()
    private lazy var passwordTextField = UITextField()
    private lazy var passwordSecureButton = UIButton(type: .custom)
    private lazy var loginButton = UIButton(type: .custom)
    private lazy var signUpButton = UIButton()
    
    private lazy var stackView = UIStackView(arrangedSubviews: [usernameTextFieldView, passwordTextFieldView, loginButton]).then {
        $0.spacing = 18
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.alignment = .fill
    }
    
    
    private let loginAlert: UIAlertController = {
        let alert = UIAlertController(
            title: "로그인 실패",
            message: "아이디와 비밀번호를 확인해주세요",
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: "확인", style: .default)
        alert.addAction(action)

        return alert
    }()

    private let errorAlert: UIAlertController = {
        let alert = UIAlertController(
            title: "오류",
            message: "알 수 없는 오류가 발생했습니다.",
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: "확인", style: .default)
        alert.addAction(action)

        return alert
    }()
    
    // MARK: - Lifecycle
    
    init(apiService: APIService, keyChainManager: KeyChainManager) {
          self.keyChainManager = keyChainManager
          self.apiService = apiService
          super.init(nibName: nil, bundle: nil)
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setUI()
        setLayout()
        checkForExistingToken()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // 부모 클래스의 기본 동작 호출
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
    
    // MARK: - UI Setup
    
    private func setStyle() {
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        self.view.backgroundColor = .black
        
        titleLabel.do {
            $0.text = "SOPT iOS 4WEEK!"
            $0.font = .boldSystemFont(ofSize: 24)
            $0.textColor = #colorLiteral(red: 0.837, green: 0.837, blue: 0.837, alpha: 1)
        }
        
        usernameTextFieldView.do {
            $0.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            $0.layer.cornerRadius = 5
            $0.clipsToBounds = true
            $0.addSubview(usernameTextField)
            $0.addSubview(usernameInfoLabel)
        }
        
        
        usernameInfoLabel.do {
            $0.text = "가입된 사용자의 이름"
            $0.font = .systemFont(ofSize: 18)
            $0.textColor = #colorLiteral(red: 0.837, green: 0.837, blue: 0.837, alpha: 1)
        }
        
        usernameTextField.do {
            $0.backgroundColor = .clear
            $0.textColor = .white
            $0.tintColor = .white
            $0.autocapitalizationType = .none
            $0.autocorrectionType = .no
            $0.spellCheckingType = .no
            $0.keyboardType = .emailAddress
            $0.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        }
        
        passwordTextFieldView.do {
            $0.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            $0.layer.cornerRadius = 5
            $0.clipsToBounds = true
            $0.addSubview(passwordTextField)
            $0.addSubview(passwordInfoLabel)
            $0.addSubview(passwordSecureButton)
        }
        
        passwordInfoLabel.do {
            $0.text = "비밀번호"
            $0.font = .systemFont(ofSize: 18)
            $0.textColor = #colorLiteral(red: 0.837, green: 0.837, blue: 0.837, alpha: 1)
        }
        
        passwordTextField.do {
            $0.backgroundColor = .clear
            $0.textColor = .white
            $0.tintColor = .white
            $0.autocapitalizationType = .none
            $0.autocorrectionType = .no
            $0.spellCheckingType = .no
            $0.isSecureTextEntry = true
            $0.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        }
        
        passwordSecureButton.do {
            $0.setTitle("표시", for: .normal)
            $0.setTitleColor(#colorLiteral(red: 0.837, green: 0.837, blue: 0.837, alpha: 1), for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .light)
            $0.addTarget(self, action: #selector(passwordSecureModeSetting), for: .touchUpInside)
        }
        
        loginButton.do {
            $0.backgroundColor = .clear
            $0.layer.cornerRadius = 5
            $0.layer.borderWidth = 1
            $0.layer.borderColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            $0.setTitle("로그인", for: .normal)
            $0.titleLabel?.font = .boldSystemFont(ofSize: 16)
            $0.isEnabled = false
            $0.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        }
        
        signUpButton.do {
            $0.setTitle("회원 가입", for: .normal)
            $0.backgroundColor = .red
            $0.layer.cornerRadius = 5
            $0.layer.borderWidth = 1
            $0.setTitleColor(.white, for: .normal)
            $0.addTarget(self, action: #selector(signUpButtonDidTap), for: .touchUpInside)
        }
        
        
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
            $0.leading.trailing.equalTo(usernameTextFieldView).inset(8)
            emailInfoLabelCenterYConstraint.isActive = true
        }
        
        usernameTextField.snp.makeConstraints {
            $0.top.equalTo(usernameTextFieldView).offset(15)
            $0.bottom.equalTo(usernameTextFieldView).offset(-2)
            $0.leading.trailing.equalTo(usernameTextFieldView).inset(8)
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
    
    // MARK: - Methods

    private func checkForExistingToken() {
        if let token = keyChainManager.searchValue(), !token.isEmpty {
            print("자동 로그인: 키체인에서 기존 토큰이 발견되었습니다.")
            let mvController = MainViewController(apiService: apiService)
            self.navigationController?.pushViewController(mvController, animated: true)
        }
    }

    @objc func loginButtonDidTap() {
        apiService.login(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "") { [weak self] result in
                guard let self else { return }
                switch result {
                case .success:
                    UserDefaults.standard.set(id, forKey: "id")
                    UserDefaults.standard.set(password, forKey: "password")
                    let mvController = MainViewController(apiService: apiService)
                    self.navigationController?.pushViewController(mvController, animated: true)
                case .failure(let failure):
                    switch failure {
                    case .passwordInvalid, .loginInvalid:
                        present(loginAlert, animated: true)
                    default:
                        present(errorAlert, animated: true)
                    }
                }
            }
    }
    
    @objc func passwordSecureModeSetting() {
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    @objc func signUpButtonDidTap() {
        let signUpView = SignUpView(apiService: apiService) // apiService를 전달
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
            usernameTextFieldView.backgroundColor = #colorLiteral(red: 0.2972877622, green: 0.2973434925, blue: 0.297280401, alpha: 1)
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
            usernameTextFieldView.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
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

