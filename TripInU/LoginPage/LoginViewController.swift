//
//  LoginViewController.swift
//  TripInU
//
//  Created by 박다미 on 2023/05/05.
//


import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty
        else {
            // 이메일과 비밀번호 필드가 모두 채워졌는지 확인
            emailLabel.text = "모든 필드를 채워주세요"
            return
        }
        
        // 이메일과 비밀번호로 로그인
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                // 로그인 실패
                self?.emailLabel.text = "로그인 실패: \(error.localizedDescription)"
            } else {
                // 로그인 성공
                guard let user = result?.user else { return }
                self?.emailLabel.text = "로그인 성공! 사용자 이메일: \(user.email ?? "")"
            }
        }
    }
}
