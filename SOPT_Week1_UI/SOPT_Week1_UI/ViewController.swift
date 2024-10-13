//
//  ViewController.swift
//  SOPT_Week1_UI
//
//  Created by 정정욱 on 10/5/24.
//

import UIKit

// 💁 상속하지 않는다면 final 키워드 붙여주기
final class ViewController: UIViewController {
    

    // MARK: - 상단 타이틀 뷰
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "SOPT iOS 1WEEK!"
        label.font = .boldSystemFont(ofSize: 24) // 볼드체로 설정
        label.textColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        return label
    }()
    
    // MARK: - 이메일 입력하는 텍스트 뷰
    
    // ⭐️  lazy var 해야 addSubview를 여기에 넣을 수 있음
    // ⭐️ private 접근제어 같은 클래스 내부에서만 사용하게 실무적 관점에서 final과 마찬가지로 붙이는 게 좋음
    private lazy var emailTextFieldView: UIView = {
      
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.addSubview(emailTextField) // 뷰 위에다 텍스트 필드와
        view.addSubview(emailInfoLabel) // 레이블을 올리는 것임
        // 가장 마지막 코드 순서대로 맨 마지막에 올라옴
        return view
    }()
    // 😀 뷰에 바로 올리기 위해 lazy var 로 선언
    
    
    private var emailInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일주소 또는 전화번호"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        return label
    }()
    
    // 로그인 - 이메일 입력 필드
    private lazy var emailTextField: UITextField = {
        var tf = UITextField()
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .white
        tf.tintColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.keyboardType = .emailAddress
        //값이 변할때마다 셀렉터를 통해서 해당 함수를 호출
        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    // MARK: - 비밀번호 입력하는 텍스트 뷰
    private lazy var passwordTextFieldView: UIView = {
        let view = UIView()
        //view.frame.size.height = 48
        view.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        
        // 여러개 올리면 스택구조임
        view.addSubview(passwordTextField)
        view.addSubview(passwordInfoLabel)
        view.addSubview(passwordSecureButton)
        return view
    }()
    
    // 패스워드텍스트필드의 안내문구
    private let passwordInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        return label
    }()
    
    // 로그인 - 비밀번호 입력 필드
    private lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .white
        tf.tintColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.isSecureTextEntry = true // 비번이라 가리는 설정
        tf.clearsOnBeginEditing = false
        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    
    // 따로 표시하는 게 없기 때문에 직접 구현
    // 패스워드에 "표시"버튼 비밀번호 가리기 기능
    private lazy var passwordSecureButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("표시", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
        button.addTarget(self, action: #selector(passwordSecureModeSetting), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - 로그인버튼
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1 // 보더의 넓이 설정
        button.layer.borderColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1) // 보더 컬러 설정
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.isEnabled = false   // 처음에 버튼 실행 안 되게 설정 나중에 이메일 입력하면 누를 수 있게 바꿀 것임
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    // 이메일텍스트필드, 패스워드, 로그인버튼 스택뷰에 배치
    private lazy var stackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [emailTextFieldView, passwordTextFieldView, loginButton])
        stview.spacing = 18 // 내부간격
        stview.axis = .vertical // 세로 축으로 설정
        stview.distribution = .fillEqually  // 분배는 동등하게 체운다
        stview.alignment = .fill    // 정렬은 완전 체워서 정렬
        return stview
    }()
    
    
    
    // 각 텍스트 필드 및 로그인 버튼의 높이 설정 변수 (애니메이션 효과를 주기 위해)
    // 이런 식으로 오토레이아웃 잡을 때 기준값을 만들면 나중에 아래에서 하나하나 값 잡은 거 한방에 수정 가능
    private let textViewHeight: CGFloat = 48
    
    // ⭐️ 오토레이아웃 향후 변경을 위한 변수(애니메이션)
    lazy var emailInfoLabelCenterYConstraint = emailInfoLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor)
    // y축 즉 가운데 제약을 담아둔것임
    lazy var passwordInfoLabelCenterYConstraint = passwordInfoLabel.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor)
    
    
    
    private lazy var pushModeToggleButton: UIButton = {
        let button = UIButton()
        button.setTitle("전환 모드 변경", for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1 // 보더의 넓이 설정
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(toggleButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var pushMode = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 델리게이트 설정
        emailTextField.delegate = self
        passwordTextField.delegate = self
        setStyle()
        setUI()
        setLayout()
    }
    
    private func setStyle() {
        self.view.backgroundColor = .black
    }
    
    private func setUI() {
        [   titleLabel,
            stackView,
            pushModeToggleButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        }
    }
    
    private func setLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        emailInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        passwordInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordSecureButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                
                titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 220),
                titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                
                emailInfoLabel.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
                emailInfoLabel.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: -8),
                
                emailInfoLabelCenterYConstraint, // 위에서 만든 변수로 선언
                
                emailTextField.topAnchor.constraint(equalTo: emailTextFieldView.topAnchor, constant: 15),
                emailTextField.bottomAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: -2),
                emailTextField.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
                emailTextField.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: -8),
                
                // 페스워드 관련 오토레이아웃
                passwordInfoLabel.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 8),
                passwordInfoLabel.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -8),
                passwordInfoLabelCenterYConstraint, // 위와 똑같이 동적으로 만들기 위해 변수 사용
                
                
                passwordTextField.topAnchor.constraint(equalTo: passwordTextFieldView.topAnchor, constant: 15),
                passwordTextField.bottomAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: -2),
                passwordTextField.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 8),
                passwordTextField.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -8),
                
                
                passwordSecureButton.topAnchor.constraint(equalTo: passwordTextFieldView.topAnchor, constant: 15),
                passwordSecureButton.bottomAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: -15),
                // 표시가 끝에 붙어있어서 끝에만 맞춰줌
                passwordSecureButton.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -8),
                
                
                // 스택뷰 오토레이아웃 잡아주기
                stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                stackView.heightAnchor.constraint(equalToConstant: textViewHeight*3 + 36),
                // 정적 값을 이용하여 넉넉하기 높이 잡아주기
                
                
                
                pushModeToggleButton.topAnchor.constraint(
                    equalTo: stackView.bottomAnchor,
                    constant: 20
                ),
                pushModeToggleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                pushModeToggleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                
                pushModeToggleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                pushModeToggleButton.heightAnchor.constraint(equalToConstant: 44)
            ]
        )
    }
    
    
    @objc func nextButtonTapped() {
        transitionToNextViewController()
    }
    
    
    private func transitionToNextViewController() {
        let nextViewController = DetailViewController()
        nextViewController.delegate = self // 델리게이트 내가 해줄게
        
        guard let title = emailTextField.text,
              let content = passwordTextField.text
        else {
            // 텍스트의 값들이 없으면 함수가 return
            return
        }
        // 존재할 경우 함수를 그대로 실행
        nextViewController.dataBind(
            title: title,
            content: content
        )
        
        // 💁 weak self를 사용하고 있음 : 이유는?
//        nextViewController.completionHandler = { [weak self] nickname in
//           guard let self else { return }
//            self.titleLabel.text = nickname
//         }
        
        if pushMode {
            self.navigationController?.pushViewController(
                nextViewController,
                animated: true
            )
        } else {
            self.present(
                nextViewController,
                animated: true
            )
        }
        
    }
    
    @objc func toggleButtonTapped() {
        self.pushMode.toggle()
    }
    
    
    @objc func passwordSecureModeSetting(){
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    
    // 앱의 화면을 터치하면 동작하는 함수
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}




extension ViewController: UITextFieldDelegate {
    
    // MARK: - 텍스트필드 편집 시작할때의 설정 - 문구가 위로올라가면서 크기 작아지고, 오토레이아웃 업데이트
    // 애니메이션을 텍스트필드 시작할때와 끝날때 주면 되니까 아래와 같은메서드를 구현함
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField {    // 유저가 선택한게 emailTextField라면 백그라운드 색상을 바꾸고, 폰트 크기를 바꿈
            emailTextFieldView.backgroundColor = #colorLiteral(red: 0.2972877622, green: 0.2973434925, blue: 0.297280401, alpha: 1)
            emailInfoLabel.font = UIFont.systemFont(ofSize: 11)
            
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
        if textField == emailTextField {
            emailTextFieldView.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            // 빈칸이면 원래로 되돌리기
            if emailTextField.text == "" { // 입력된게 없으면 다시 되돌리기
                emailInfoLabel.font = UIFont.systemFont(ofSize: 18)
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
            let email = emailTextField.text, !email.isEmpty, // 텍스트가 있고, 비어있지 않다면 (! 붙여서 부정으로 아니라면)
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
extension ViewController: NicknameDelegate {
  func dataBind(nickname: String) {
    guard !nickname.isEmpty else { return }
    self.titleLabel.text = nickname
  }
}
