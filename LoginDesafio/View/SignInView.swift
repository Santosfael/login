//
//  SignInView.swift
//  LoginDesafio
//
//  Created by Idwall Go Dev 008 on 24/03/22.
//

import UIKit

struct ErrorValidateTextField {
    var nameErrorLabel: UILabel
    var nameTextField: UITextField
    var message: String
}

final class SignInView: UIView {
    
    private var safeArea: UILayoutGuide!
    private let borderColorTextField = UIColor.lightGray
    
    lazy var imageLogo: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "logo_wash")
        return image
    }()
    
    lazy var containerForm: UIStackView = {
        let containerForm = UIStackView(frame: .zero)
        containerForm.translatesAutoresizingMaskIntoConstraints = false
        containerForm.distribution = .equalSpacing
        containerForm.axis = .vertical
        containerForm.spacing = 10
        return containerForm
    }()
    
    lazy var welcomeLabel: UILabel = {
        let welcomeLabel = UILabel()
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        welcomeLabel.text = "Bem vindo"
        
        return welcomeLabel
    }()
    
    lazy var emailLabel: UILabel = {
        let emailLabel = UILabel()
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        emailLabel.text = "E-mail"
        
        return emailLabel
    }()
    
    lazy var emailTextField: UITextField = {
        let emailText = UITextField()
        emailText.translatesAutoresizingMaskIntoConstraints = false
        emailText.layer.cornerRadius = 8
        emailText.layer.borderWidth = 1
        emailText.setLeftPaddingPoints(10)
        emailText.setRightPaddingPoints(10)
        emailText.addTarget(self, action: #selector(verifyEmail(_:)), for: .editingDidEnd)
        emailText.placeholder = "Digite o seu e-mail"
        emailText.layer.borderColor = borderColorTextField.cgColor
        emailText.autocorrectionType = .no
        emailText.autocapitalizationType = .none
        emailText.keyboardType = .emailAddress
        return emailText
    }()
    
    lazy var emailErrorLabel: UILabel = {
        let emailErrorLabel = UILabel()
        emailErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        emailErrorLabel.font = UIFont.systemFont(ofSize: 12)
        emailErrorLabel.textColor = .red
        emailErrorLabel.isHidden = true
        return emailErrorLabel
    }()
    
    lazy var passwordLabel: UILabel = {
        let passwordLabel = UILabel()
        passwordLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.text = "Senha"
        return passwordLabel
    }()
    
    lazy var passwordTextField: UITextField = {
        let passwordText = UITextField()
        passwordText.translatesAutoresizingMaskIntoConstraints = false
        passwordText.layer.cornerRadius = 8
        passwordText.layer.borderWidth = 1
        passwordText.layer.borderColor = borderColorTextField.cgColor
        passwordText.setLeftPaddingPoints(10)
        passwordText.setRightPaddingPoints(10)
        passwordText.addTarget(self, action: #selector(verifyPassword), for: .editingChanged)
        passwordText.placeholder = "Digite a sua senha"
        passwordText.autocorrectionType = .no
        passwordText.autocapitalizationType = .none
        passwordText.isSecureTextEntry = true
        return passwordText
    }()
    
    lazy var passwordErrorLabel: UILabel = {
        let passwordErrorLabel = UILabel()
        passwordErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordErrorLabel.font = UIFont.systemFont(ofSize: 12)
        passwordErrorLabel.textColor = .red
        passwordErrorLabel.isHidden = true
        return passwordErrorLabel
    }()
    
    lazy var loginButton: UIButton = {
        let buttonLogin = UIButton()
        buttonLogin.translatesAutoresizingMaskIntoConstraints = false
        buttonLogin.setTitle("Login", for: .normal)
        buttonLogin.backgroundColor = .systemBlue
        buttonLogin.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        buttonLogin.setTitleColor(UIColor.white, for: .normal)
        buttonLogin.layer.cornerRadius = 8
        buttonLogin.isEnabled = false
        buttonLogin.alpha = 0.5
        return buttonLogin
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        safeArea = self.layoutMarginsGuide
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Erro ao inicializar o front")
    }
    
    func validateEmail(email: String) -> Bool {
        let regexEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", regexEmail)
        return emailPred.evaluate(with: email)
    }
    
    var shouldEnabledLoginButton: Bool {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return false
        }
        return email.isEmpty || password.isEmpty ? false : true
    }
    
    private func errorValidateTextField( errorValidateTextField: ErrorValidateTextField) {
        let borderColor = UIColor.red
        errorValidateTextField.nameErrorLabel.isHidden = false
        errorValidateTextField.nameErrorLabel.text = errorValidateTextField.message
        errorValidateTextField.nameErrorLabel.textColor = .red
        errorValidateTextField.nameTextField.layer.borderWidth = 1
        errorValidateTextField.nameTextField.layer.borderColor = borderColor.cgColor
        errorValidateTextField.nameTextField.layer.cornerRadius = 8
        
    }
    
    private func alertInfor(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        print("Error \(message)")
        self.window?.rootViewController?.present(alert, animated: true)
    }
    
    @objc func verifyPassword() {
        loginButton.isEnabled = shouldEnabledLoginButton
        
        if passwordTextField.text!.count < 6 {
            errorValidateTextField(errorValidateTextField: ErrorValidateTextField.init(nameErrorLabel: passwordErrorLabel, nameTextField: passwordTextField, message: "A senha é maior que 6 caracteres"))
            loginButton.isEnabled = false
        } else {
            passwordErrorLabel.text = ""
            passwordTextField.layer.borderWidth = 1
            passwordTextField.layer.borderColor = borderColorTextField.cgColor
        }
        
        if loginButton.isEnabled {
            loginButton.alpha = 1
        } else {
            loginButton.alpha = 0.5
        }
    }
    
    @objc func verifyEmail(_ sender: UITextField) {
        let validate = validateEmail(email: emailTextField.text!)
        loginButton.isEnabled = shouldEnabledLoginButton
        
        if !validate {
            errorValidateTextField(errorValidateTextField: ErrorValidateTextField.init(nameErrorLabel: emailErrorLabel, nameTextField: emailTextField, message: "Digite um e-mail válido"))
            loginButton.isEnabled = false
        } else {
            emailErrorLabel.text = ""
            emailTextField.layer.borderWidth = 1
            emailTextField.layer.borderColor = borderColorTextField.cgColor
        }
        
        
        
        if loginButton.isEnabled {
            loginButton.alpha = 1
        } else {
            loginButton.alpha = 0.5
        }
    }
    
    @objc func handleLogin() {
        let email = "rafael@gmail.com"
        let password = "1234567"
        
        if email == emailTextField.text && password == passwordTextField.text {
            //performSegue(withIdentifier: "homeViewController", sender: nil)
            alertInfor(title: "Login", message: "Usuário logado")
            emailTextField.text = ""
            passwordTextField.text = ""
            loginButton.alpha = 0.5
            loginButton.isEnabled = false
        } else {
            alertInfor(title: "Login", message: "E-mail ou senha incorreto")
            emailTextField.text = ""
            passwordTextField.text = ""
            loginButton.alpha = 0.5
            loginButton.isEnabled = false
        }
        
    }
}

extension SignInView: ViewCode {
    func buildHierarchy() {
        containerForm.addArrangedSubviews(emailLabel,
                                          emailTextField,
                                          emailErrorLabel,
                                          passwordLabel,
                                          passwordTextField,
                                          passwordErrorLabel)
        self.addSubViews(imageLogo, welcomeLabel, containerForm, loginButton)
        
    }
    
    func setupConstraints() {
        
        //ImageView
        NSLayoutConstraint.activate([
            imageLogo.topAnchor.constraint(equalTo: topAnchor, constant: 80),
            imageLogo.heightAnchor.constraint(equalToConstant: 200),
            imageLogo.widthAnchor.constraint(equalToConstant: 200),
            imageLogo.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        //LoginLabel
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: imageLogo.bottomAnchor),
            welcomeLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        //Container
        NSLayoutConstraint.activate([
            containerForm.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 20),
            containerForm.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerForm.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
        
        //Email TextField
        NSLayoutConstraint.activate([
            emailTextField.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        //Password TextField
        NSLayoutConstraint.activate([
            passwordTextField.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        //ButtonLogin
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: containerForm.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func applyAdditionalChanges() {
        backgroundColor = .systemBackground
    }
    
    
}
