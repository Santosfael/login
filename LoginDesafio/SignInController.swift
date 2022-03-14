//
//  ViewController.swift
//  LoginDesafio
//
//  Created by Idwall Go Dev 008 on 14/03/22.
//

import UIKit

class SignInController: UIViewController, UITextFieldDelegate {
    
    let email = "rafael@gmail.com"
    let password = "123456"

    @IBOutlet var textFieldEmail: UITextField!
    @IBOutlet var labelErrorEmail: UILabel!
    
    @IBOutlet var textFieldPassword: UITextField!
    @IBOutlet var labelErrorPassword: UILabel!
    
    @IBOutlet var buttonLogin: UIButton!
    
    //MARK: - File cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        delegates()
    }
    
    //MARK: - Methods privates
    private func delegates() {
        textFieldEmail.delegate = self
        textFieldPassword.delegate = self
    }
    
    // MARK: - Verifica se os campos de texto estão vazios
    var shouldEnabledButton: Bool {
        guard let email = textFieldEmail.text, let password = textFieldPassword.text else {
            return false
        }
        return email.isEmpty || password.isEmpty ? false : true
    }
    
    //MARK: - Verifica se o e-mail é valido e o habilita o botão ao incluir informação nos campos te texto
    @IBAction func handleEnabled(_ sender: UITextField) {
        let validate = validateEmail(email: textFieldEmail.text!)
        buttonLogin.isEnabled = shouldEnabledButton
        //buttonLogin.alpha = 1
        if !validate {
            errorEmailAndPassword(labelError: 1, message: "Digite um e-mail válido")
            buttonLogin.isEnabled = false
        } else {
            labelErrorEmail.text = ""
        }
        
        if buttonLogin.isEnabled {
            buttonLogin.alpha = 1
        } else {
            buttonLogin.alpha = 0.5
        }
    }
    
    //MARK: - Methods Action buttons
    @IBAction func ButtonSignIn(_ sender: UIButton) {
        
        if let emailText = textFieldEmail,
           let passwordText = textFieldPassword {
            if emailText.text != email || passwordText.text != password {
                alertInfor(title: "Login", message: "E-mail ou senha Inválidos")
                textFieldEmail.text = ""
                textFieldPassword.text = ""
                buttonLogin.isEnabled = false
                buttonLogin.alpha = 0.5
            }
            alertInfor(title: "Login", message: "Login realizado com sucesso")
        }
    }
    
    //MARK: - Methods publics
    func validateEmail(email: String) -> Bool {
        let regexEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", regexEmail)
        return emailPred.evaluate(with: email)
    }
    
    func errorEmailAndPassword(labelError: Int, message: String) {
        let colorError: UIColor = UIColor.red
        
        switch labelError {
            case 1:
                labelErrorEmail.isHidden = false
                labelErrorEmail.text = message
                labelErrorEmail.textColor = colorError
            case 2:
                labelErrorPassword.isHidden = false
                labelErrorPassword.text = message
                labelErrorPassword.textColor = colorError
        default:
            return
        }
    }
    
    func alertInfor(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
}

extension SignInController: UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

