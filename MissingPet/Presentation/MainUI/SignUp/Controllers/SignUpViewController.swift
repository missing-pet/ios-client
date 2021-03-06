//
//  SignUpViewController.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 28.11.2020.
//

import UIKit

class SignUpViewController: Controller<SignUpPresenter>, UITextFieldDelegate {

    @IBOutlet weak var nicknameTextField: TextFieldWithImageView!
    @IBOutlet weak var emailTextField: TextFieldWithImageView!
    @IBOutlet weak var passwordTextField: TextFieldWithImageView!
    @IBOutlet weak var repeatPasswordTextField: TextFieldWithImageView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!

    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var largeActivityIndicatorView: UIActivityIndicatorView!

    override func viewDidLoad() {
        presenter?.startLoadingSetter = { [weak self] in
            self?.loadingView.isHidden = false
            self?.largeActivityIndicatorView.startAnimating()
            self?.view.isUserInteractionEnabled = false
            self?.tabBarController?.view.isUserInteractionEnabled = false
        }
        presenter?.stopLoadingSetter = { [weak self] in
            self?.loadingView.isHidden = true
            self?.largeActivityIndicatorView.stopAnimating()
            self?.view.isUserInteractionEnabled = true
            self?.tabBarController?.view.isUserInteractionEnabled = true
        }

        super.viewDidLoad()

        nicknameTextField.delegate = self
        nicknameTextField.keyboardType = .default
        nicknameTextField.textContentType = .username
        nicknameTextField.isSecureTextEntry = false

        emailTextField.delegate = self
        emailTextField.keyboardType = .emailAddress
        emailTextField.textContentType = .emailAddress
        emailTextField.isSecureTextEntry = false

        passwordTextField.delegate = self
        passwordTextField.keyboardType = .default
        passwordTextField.textContentType = .password
        passwordTextField.isSecureTextEntry = true

        repeatPasswordTextField.delegate = self
        repeatPasswordTextField.keyboardType = .default
        repeatPasswordTextField.textContentType = .password
        repeatPasswordTextField.isSecureTextEntry = true

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))

    }

    @IBAction func signUp(_ sender: UIButton) {
        let nickname = nicknameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let repeatedPassword = repeatPasswordTextField.text ?? ""
        presenter?.singUp(self,
                          nickname: nickname,
                          email: email,
                          password: password,
                          repeatedPassword: repeatedPassword)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
