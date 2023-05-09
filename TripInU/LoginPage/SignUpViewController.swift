//
//  SignUpViewController.swift
//  TripInU
//
//  Created by 박다미 on 2023/05/07.
//

import UIKit
import FirebaseAuth
class SignUpViewController: UIViewController {
    private let textViewHeight: CGFloat = 48
    
    //email
    private lazy var emailTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        return view
    }()
    private var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일 주소"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    private var emailTextField: UITextField = {
        var tf = UITextField()
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .white
        tf.tintColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.keyboardType = .emailAddress
        
        return tf
    }()
    
    //password
    private lazy var passwordTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        return view
    }()
    private lazy var passwordLabel : UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    private lazy var passwordTextField: UITextField = {
        var tf = UITextField()
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .white
        tf.tintColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        
        return tf
    }()
    
    
    //password check
    private lazy var passwordCheckTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.addSubview(passwordCheckLabel)
        view.addSubview(passwordCheckTextField)
        return view
    }()
    private lazy var passwordCheckLabel : UILabel = {
        let label = UILabel()
        label.text = "비밀번호 확인"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    private lazy var passwordCheckTextField: UITextField = {
        var tf = UITextField()
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .white
        tf.tintColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        return tf
    }()
    
    private lazy var registerButton : UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        button.setTitle("가입하기", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        button.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [emailTextFieldView,passwordTextFieldView, passwordCheckTextFieldView,registerButton])
        stview.spacing = 18
        stview.axis = .vertical
        stview.distribution = .fillEqually
        stview.alignment = .fill
        return stview
    }()
    @objc func signupButtonTapped(){
        print(#function)
        guard let email = emailTextField.text,
              !email.isEmpty,
              let password = passwordTextField.text,
              !password.isEmpty,
              
            let passwordChecked = passwordCheckTextField.text,
              !passwordChecked.isEmpty
        
        else {
            emailLabel.text = "모든 필드를 채워주세요"
            passwordCheckLabel.textColor = .white
            
            return
        }
        if password != passwordChecked {
            passwordCheckLabel.text = "비밀번호를 확인해주세요"
            passwordCheckLabel.textColor = .red
            passwordTextField.becomeFirstResponder() //커서이동
            return
        }
      
        
        
        //성공했을때
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            print("Invalid email or password")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Failed to create user: \(error.localizedDescription)")
                return
            }
            //회원가입 되었습니다! 1초뒤 사라짐
            let alert = UIAlertController(title: "TripInU", message: "회원가입 되셨습니다", preferredStyle:.alert)
            self.present(alert, animated: true, completion:nil)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
                alert.dismiss(animated: true) {
                    self.dismiss(animated: true)
                }
            }
            
           
            
        }
        
        
    }
    lazy var emailLabelCenterYConstraint = emailLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor)
    lazy var passwordLabelCenterYConstraint = passwordLabel.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor)
    lazy var passwordCheckLabelCenterYConstraint = passwordCheckLabel.centerYAnchor.constraint(equalTo: passwordCheckTextFieldView.centerYAnchor)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        //        view.addSubview(emailTextFieldView)
        //        view.addSubview(passwordTextFieldView)
        //        view.addSubview(passwordCheckTextFieldView)
        //        view.addSubview(registerButton)
        view.addSubview(stackView)
        configure()
        setUp()
        
        
    }
    private func configure(){
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordCheckTextField.delegate = self
    }
    private func setUp(){
        
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailLabelCenterYConstraint.isActive = true
        
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordLabelCenterYConstraint.isActive = true
        
        passwordCheckLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordCheckTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordCheckLabelCenterYConstraint.isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            
            
            emailLabel.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
            emailLabel.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: -8),
           
            emailTextField.topAnchor.constraint(equalTo: emailTextFieldView.topAnchor, constant: 15),
            emailTextField.bottomAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: -2),
            emailTextField.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
            emailTextField.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: -8),
            
            passwordLabel.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 8),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordTextFieldView.topAnchor, constant: 15),
            passwordTextField.bottomAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: -2),
            passwordTextField.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 8),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -8),
            
            
            
            
            passwordCheckLabel.leadingAnchor.constraint(equalTo: passwordCheckTextFieldView.leadingAnchor, constant: 8),
            
            passwordCheckTextField.topAnchor.constraint(equalTo: passwordCheckTextFieldView.topAnchor, constant: 15),
            passwordCheckTextField.bottomAnchor.constraint(equalTo: passwordCheckTextFieldView.bottomAnchor, constant: -2),
            passwordCheckTextField.leadingAnchor.constraint(equalTo: passwordCheckTextFieldView.leadingAnchor, constant: 8),
            passwordCheckTextField.trailingAnchor.constraint(equalTo: passwordCheckTextFieldView.trailingAnchor, constant: -8),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackView.heightAnchor.constraint(equalToConstant: textViewHeight*4 + 36)
            
            
            
        ])
        
    }
    
    //password passCheck비교해서 같으면 버튼 빨간색, 다르면 passwordLabel의 텍스트가 빨간색 비밀번호를 확인해주세요.
    
    
    
}
extension SignUpViewController : UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == emailTextField {
            emailTextFieldView.backgroundColor = #colorLiteral(red: 0.2972877622, green: 0.2973434925, blue: 0.297280401, alpha: 1)
            emailLabel.font = UIFont.systemFont(ofSize: 11)
            // 오토레이아웃 업데이트
            emailLabelCenterYConstraint.constant = -13
        }
        
        if textField == passwordTextField {
            passwordTextFieldView.backgroundColor = #colorLiteral(red: 0.2972877622, green: 0.2973434925, blue: 0.297280401, alpha: 1)
            passwordLabel.font = UIFont.systemFont(ofSize: 11)
            // 오토레이아웃 업데이트
            passwordLabelCenterYConstraint.constant = -13
        }
        if textField == passwordCheckTextField {
            passwordCheckTextFieldView.backgroundColor = #colorLiteral(red: 0.2972877622, green: 0.2973434925, blue: 0.297280401, alpha: 1)
            passwordCheckLabel.font = UIFont.systemFont(ofSize: 11)
            // 오토레이아웃 업데이트
            passwordCheckLabelCenterYConstraint.constant = -13
        }
        
        // 실제 레이아웃 변경은 애니메이션
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == emailTextField {
            emailTextFieldView.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            // 빈칸이면 원래로 되돌리기
            if emailTextField.text == "" {
                emailLabel.font = UIFont.systemFont(ofSize: 18)
                emailLabelCenterYConstraint.constant = 0
            }
        }
        if textField == passwordTextField {
            passwordTextFieldView.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            // 빈칸이면 원래로 되돌리기
            if passwordTextField.text == "" {
                passwordLabel.font = UIFont.systemFont(ofSize: 18)
                passwordLabelCenterYConstraint.constant = 0
            }
        }
        if textField == passwordCheckTextField {
            passwordCheckTextFieldView.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
            // 빈칸이면 원래로 되돌리기
            if passwordCheckTextField.text == "" {
                passwordCheckLabel.font = UIFont.systemFont(ofSize: 18)
                passwordCheckLabelCenterYConstraint.constant = 0
            }
        }
        
        // 실제 레이아웃 변경은 애니메이션으로
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
        }
    }
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty,
            let passwordChecked = passwordCheckTextField.text,
            !passwordChecked.isEmpty,
            password == passwordChecked
        else {
            registerButton.backgroundColor = .clear
            registerButton.isEnabled = false
            return
        }
        
        registerButton.backgroundColor = .red
        registerButton.isEnabled = true
    }
    // 엔터 누르면 일단 키보드 내림
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
