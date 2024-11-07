//
//  LoginViewController.swift
//  SOPT_Week4_NetWork
//
//  Created by 정정욱 on 11/2/24.
//

import UIKit
import Then
import SnapKit
import SwiftUI

// 💁 상속하지 않는다면 final 키워드 붙여주기

final class LoginViewController: UIViewController {
    
    // MARK: - 상단 타이틀 뷰
    private let titleLabel = UILabel().then {
        $0.text = "SOPT iOS 4WEEK!"
        $0.font = .boldSystemFont(ofSize: 24)
        $0.textColor = #colorLiteral(red: 0.837, green: 0.837, blue: 0.837, alpha: 1)
    }
    
    // MARK: - 이메일 입력 텍스트 필드 뷰
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
    
    // MARK: - 비밀번호 입력 텍스트 필드 뷰
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
    
    // MARK: - 로그인 버튼
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
    
    @objc func nextButtonTapped() {
        UserService.shared.Login(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "") { result in
            switch result {
            case .success(let loginResponse):
                // 로그인 성공 시 토큰을 받아서 처리
                let token = loginResponse.result.token // LoginResponse에서 토큰 추출
                print("Received token: \(token)")
                
                // 필요한 경우 토큰을 UserDefaults에 저장
                UserDefaults.standard.set(token, forKey: "userToken")
                
                // 다음 페이지로 넘어가기
                let mcController = MainViewController()
                self.navigationController?.pushViewController(mcController, animated: true)
                // 푸시한 뷰 컨트롤러에서 SwiftUI 뷰 표시
                mcController.showNextView() // 여기에서 showNextView 호출
                
            case .failure(let error):
                // 실패 시 에러 메시지 표시
                print("에러 표시: \(error)")
                // self.showAlert(with: error.localizedDescription) // 에러 메시지 알림 표시
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
    // 애니메이션을 텍스트필드 시작할때와 끝날때 주면 되니까 아래와 같은메서드를 구현함
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == usernameTextField {    // 유저가 선택한게 emailTextField라면 백그라운드 색상을 바꾸고, 폰트 크기를 바꿈
            userNameTextFieldView.backgroundColor = #colorLiteral(red: 0.2972877622, green: 0.2973434925, blue: 0.297280401, alpha: 1)
            usernameInfoLabel.font = UIFont.systemFont(ofSize: 11)
            
            // 오토레이아웃 업데이트
            emailInfoLabelCenterYConstraint.constant = -13 // -13 만큼 높이가 올라가는 것임
        }
        
        if textField == passwordTextField { // 유저가 선택한게 passwordTextField라면
            passwordTextFieldView.backgroundColor = #colorLiteral(red: 0.2972877622, green: 0.2973434925, blue: 0.297280401, alpha: 1)
            passwordInfoLabel.font = UIFont.systemFont(ofSize: 11)
            // 오토레이아웃 업데이트
            passwordInfoLabelCenterYConstraint.constant = -13
        }
        
        // 실제 레이아웃 변경은 애니메이션으로 줄꺼야
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded() // 하위에 있는 모든걸 자연 스럽게 이동 시키는 코드
        }
    }
    
    // 택스트 필드 끝나면 원래대로 되돌리기 위와 반대되는 코드 삽입
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == usernameTextField {
            userNameTextFieldView.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            // 빈칸이면 원래로 되돌리기
            if usernameTextField.text == "" { // 입력된게 없으면 다시 되돌리기
                usernameInfoLabel.font = UIFont.systemFont(ofSize: 18)
                emailInfoLabelCenterYConstraint.constant = 0
            }
        }
        if textField == passwordTextField {
            passwordTextFieldView.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            // 빈칸이면 원래로 되돌리기
            if passwordTextField.text == "" {
                passwordInfoLabel.font = UIFont.systemFont(ofSize: 18)
                passwordInfoLabelCenterYConstraint.constant = 0
            }
        }
        
        // 실제 레이아웃 변경은 애니메이션으로 줄꺼야
        UIView.animate(withDuration: 0.3) { // 이코드가 없으면 애니메이션이 따로 없어서 조금 딱딱하게 보여짐 그래서 애니메이션 효과 주기위한 코드
            self.stackView.layoutIfNeeded() // 0.3 초동안 애니메이션 효과가 일어남 : 오토레이아웃 동적 조정할때는 이런 애니메이션 코드를 꼭 삽입함
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
            let email = usernameTextField.text, !email.isEmpty, // 텍스트가 있고, 비어있지 않다면 (! 붙여서 부정으로 아니라면)
            let password = passwordTextField.text, !password.isEmpty // 텍스트가 있고 비어있지 않다면
        else {
            loginButton.backgroundColor = .clear    // 조건에 맞지않다면 원래대로 클리어 색상에 버튼 활성화 시키지 않음
            loginButton.isEnabled = false
            return
        }
        loginButton.backgroundColor = .red // 색상을 바꾸고
        loginButton.isEnabled = true    // 버튼을 활성화 시킴
    }
    //⭐️ 현제 글자가 하나하나 입력 될때마다 이 함수를 실행 시키는 것임
}




// 파트장 tip 구분을 위해 extension 사용
//extension LoginViewController: NicknameDelegate {
//  func dataBind(nickname: String) {
//    guard !nickname.isEmpty else { return }
//    self.titleLabel.text = nickname
//  }
//}
