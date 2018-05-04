//
//  LoginController.swift
//  Greeny
//
//  Created by Ha Nguyen on 3/23/18.
//  Copyright © 2018 Ha Nguyen. All rights reserved.
//

import UIKit

class LoginController: BaseController, UITextFieldDelegate {

    let blueHeaderView: UIView = {
        let view = UIView()
        view.backgroundColor = Const.LIGHT_GRAY
        return view
    }()

    let headerImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "headerImage")
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "headerImage")
        return iv
    }()

    let inputContainerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 3
        view.layer.masksToBounds = true
        return view
    }()

    lazy var emailTextField: PaddedTextField = {
        let txtField = PaddedTextField()
        txtField.placeholder = "Email"
        txtField.returnKeyType = UIReturnKeyType.next
        txtField.delegate = self
        return txtField
    }()

    let separatorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()

    lazy var passwordTextField: PaddedTextField = {
        let txtField = PaddedTextField()
        txtField.placeholder = "Password"
        txtField.returnKeyType = UIReturnKeyType.done
        txtField.delegate = self
        txtField.isSecureTextEntry = true
        return txtField
    }()

    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.backgroundColor = Const.BLUE
        button.setTitleColor(Const.WHITE_ALPHA15, for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()

    @objc func handleLogin() {
        //        let url = URL(string: "http://localhost/Facklone/login.php")
        //        var request = URLRequest(url: url!)
        //        request.httpMethod = "POST"
        //        let body = "email=\(emailTextField.text!.lowercased())&password=\(passwordTextField.text!)"
        //        request.httpBody = body.data(using: .utf8)
        //
        //        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        //            if (error != nil) {
        //                print(error!)
        //            } else {
        //                guard let data = data else {
        //                    print("Data is empty")
        //                    return
        //                }
        //                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary else {
        //                    print("Cannot JSONSerialize data")
        //                    return
        //                }
        //                guard let status = json["status"] as? String,
        //                        let message = json["message"] as? String else {
        //                    print("Status or message not found")
        //                    return
        //                }
        //                if (status == "200") {
        //                    print("Logged in succesfully")
        //                    if let username = json["username"] as? String {
        //                        Client.shared.getModelUser().username = username
        //                    }
        //                    if let firstName = json["first_name"] as? String {
        //                        Client.shared.getModelUser().firstName = firstName
        //                    }
        //                    if let lastName = json["last_name"] as? String {
        //                        Client.shared.getModelUser().lastName = lastName
        //                    }
        //                    if let email = json["email"] as? String {
        //                        Client.shared.getModelUser().email = email
        //                    }
        //                    if let phoneNumber = json["phone_number"] as? String {
        //                        Client.shared.getModelUser().phoneNumber = phoneNumber
        //                    }
        //                    self.defaultAlertWithMessage("Logged in succesfully", completion: {
        //                        self.dismiss(animated: true, completion: nil)
        //                    })
        //                    print(json)
        //                } else {
        //                    self.defaultAlertWithMessage(message, completion: nil)
        //                }
        //            }
        //        }
        //        task.resume()
        self.dismiss(animated: true, completion: nil)
    }

    let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forgot Password?", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 11)
        button.setTitleColor(Const.BLUE, for: .normal)
        return button
    }()

    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up for \(Const.APP_NAME)", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.setTitleColor(Const.BLUE, for: .normal)
        button.layer.borderColor = Const.MEDIUM_BLUE.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 3
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()

    @objc func handleSignUp() {
//        let signUpController = SignUpController()
//        signUpController.loginController = self
//        present(signUpController, animated: true, completion: nil)
    }

    let orLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()

    let orLabel: UILabel = {
        let label = UILabel()
        label.text = "OR"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))

        view.addSubview(inputContainerView)
        setupInputContainerView()

        view.addSubview(blueHeaderView)
        setupBlueHeaderView()

//        blueHeaderView.addSubview(headerImageView)
//        setupHeaderImageView()

        blueHeaderView.addSubview(logoImageView)
        setupLogoImageView()

        inputContainerView.addSubview(emailTextField)
        setupEmailTextField()

        inputContainerView.addSubview(separatorLineView)
        setupSeparatorLineView()

        inputContainerView.addSubview(passwordTextField)
        setupPasswordTextField()

        view.addSubview(signUpButton)
        setupSignUpButton()

        view.addSubview(orLineView)
        setupOrLineView()

        view.addSubview(orLabel)
        setupOrLabel()

        view.addSubview(loginButton)
        setupLoginButton()

        view.addSubview(forgotPasswordButton)
        setupForgotPasswordButton()
    }

    override func handleKeyboardShowing() {
        signUpButtonBottomConstraint?.constant -= keyboardHeight
        inputContainerViewCenterYAnchor?.constant -= keyboardHeight / 2 + 20
        logoImageViewHeightConstraint?.constant -= 160
        logoImageViewWidthConstraint?.constant -= 160

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.headerImageView.alpha = 0
            self.orLineView.alpha = 0
            self.orLabel.alpha = 0
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    override func handleKeyboardHiding() {
        signUpButtonBottomConstraint?.constant += keyboardHeight
        inputContainerViewCenterYAnchor?.constant += keyboardHeight / 2 + 20
        logoImageViewHeightConstraint?.constant += 160
        logoImageViewWidthConstraint?.constant += 160

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.headerImageView.alpha = 1
            self.orLineView.alpha = 1
            self.orLabel.alpha = 1
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    private func setupBlueHeaderView() {
        blueHeaderView.anchorWithConstraints(topAnchor: view.topAnchor,
                                             leftAnchor: view.leftAnchor,
                                             bottomAnchor: inputContainerView.topAnchor,
                                             bottomConstant: 30,
                                             rightAnchor: view.rightAnchor)
    }

    private var logoImageViewWidthConstraint: NSLayoutConstraint?
    private var logoImageViewHeightConstraint: NSLayoutConstraint?

    private func setupLogoImageView() {
        logoImageView.anchorWithConstraints(centerXAnchor: blueHeaderView.centerXAnchor,
                                            centerYAnchor: blueHeaderView.centerYAnchor,
                                            centerYConstant: 5,
                                            widthConstant: 200,
                                            heightConstant: 200)
        logoImageViewWidthConstraint = logoImageView.getWidthConstraint()
        logoImageViewHeightConstraint = logoImageView.getHeightConstraint()
    }

    private func setupHeaderImageView() {
        headerImageView.anchorWithConstraints(topAnchor: blueHeaderView.topAnchor,
                                              leftAnchor: blueHeaderView.leftAnchor,
                                              bottomAnchor: blueHeaderView.bottomAnchor,
                                              rightAnchor: blueHeaderView.rightAnchor)
    }

    private var inputContainerViewCenterYAnchor: NSLayoutConstraint?

    private func setupInputContainerView() {
        inputContainerView.anchorWithConstraints(centerXAnchor: view.centerXAnchor,
                                                 centerYAnchor: view.centerYAnchor,
                                                 widthConstant: view.frame.width - 32,
                                                 heightConstant: 80)
        inputContainerViewCenterYAnchor = inputContainerView.getCenterYConstraint()
    }

    private func setupEmailTextField() {
        emailTextField.anchorWithConstraints(topAnchor: inputContainerView.topAnchor,
                                             leftAnchor: inputContainerView.leftAnchor,
                                             rightAnchor: inputContainerView.rightAnchor,
                                             heightConstant: 40)
    }

    private func setupSeparatorLineView() {
        separatorLineView.anchorWithConstraints(leftAnchor: inputContainerView.leftAnchor,
                                                rightAnchor: inputContainerView.rightAnchor,
                                                centerYAnchor: inputContainerView.centerYAnchor,
                                                heightConstant: 1)
    }

    private func setupPasswordTextField() {
        passwordTextField.anchorWithConstraints(leftAnchor: inputContainerView.leftAnchor,
                                                bottomAnchor: inputContainerView.bottomAnchor,
                                                rightAnchor: inputContainerView.rightAnchor,
                                                heightConstant: 40)
    }

    private func setupLoginButton() {
        loginButton.anchorWithConstraints(topAnchor: inputContainerView.bottomAnchor,
                                          topConstant: 12,
                                          leftAnchor: view.leftAnchor,
                                          leftConstant: 16,
                                          centerXAnchor: view.centerXAnchor,
                                          heightConstant: 36)
    }

    private func setupForgotPasswordButton() {
        forgotPasswordButton.anchorWithConstraints(topAnchor: loginButton.bottomAnchor,
                                                   topConstant: 8,
                                                   centerXAnchor: view.centerXAnchor)
    }

    private var signUpButtonBottomConstraint: NSLayoutConstraint?

    private func setupSignUpButton() {
        signUpButton.anchorWithConstraints(leftAnchor: view.leftAnchor,
                                           leftConstant: 16,
                                           bottomAnchor: view.bottomAnchor,
                                           bottomConstant: 16,
                                           centerXAnchor: view.centerXAnchor,
                                           heightConstant: 36)
        signUpButtonBottomConstraint = signUpButton.getBottomConstraint()
    }

    private func setupOrLineView() {
        orLineView.anchorWithConstraints(leftAnchor: view.leftAnchor,
                                         leftConstant: 36,
                                         bottomAnchor: signUpButton.topAnchor,
                                         bottomConstant: 24,
                                         centerXAnchor: view.centerXAnchor,
                                         heightConstant: 1)
    }

    private func setupOrLabel() {
        orLabel.anchorWithConstraints(centerXAnchor: view.centerXAnchor,
                                      centerYAnchor: orLineView.centerYAnchor,
                                      widthConstant: 36)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            emailTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            passwordTextField.resignFirstResponder()
        }
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if emailTextField.text! != "" && passwordTextField.text! != "" {
            loginButton.isEnabled = true
            loginButton.setTitleColor(Const.WHITE, for: .normal)
        } else {
            loginButton.isEnabled = false
            loginButton.setTitleColor(Const.WHITE_ALPHA15, for: .normal)
        }
    }
}

