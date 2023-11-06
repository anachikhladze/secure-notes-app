//
//  LoginViewController.swift
//  SecureNotesApp
//
//  Created by Anna Sumire on 05.11.23.
//

import UIKit

final class LoginViewController: UIViewController {
    
    let keyChainManager = KeyChainManager()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 35, left: 52, bottom: 35, right: 52)
        return stackView
    }()
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .label
        textField.tintColor = .systemBlue
        textField.textAlignment = .left
        textField.font = .systemFont(ofSize: 17, weight: .semibold)
        
        textField.layer.cornerRadius = 11
        textField.backgroundColor = .secondarySystemBackground
        textField.keyboardType = .decimalPad
        
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 17, height: 0))
        textField.leftViewMode = .always
        
        textField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor : UIColor.secondaryLabel])
        textField.autocapitalizationType = .sentences
        textField.autocorrectionType = .default
        
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .label
        textField.tintColor = .systemBlue
        textField.textAlignment = .left
        textField.font = .systemFont(ofSize: 17, weight: .semibold)
        
        textField.layer.cornerRadius = 11
        textField.backgroundColor = .secondarySystemBackground
        textField.keyboardType = .decimalPad
        
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 17, height: 0))
        textField.leftViewMode = .always
        
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.secondaryLabel])
        textField.autocapitalizationType = .sentences
        textField.autocorrectionType = .default
        
        return textField
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign in", for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupBackground()
        addSubviews()
        setupStackViewConstraints()
        setupConstraints()
        setupNavBar()
    }
    
    private func setupBackground() {
        view.backgroundColor = .gray
    }
    
    private func addSubviews() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(signInButton)
    }
    
    private func setupStackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            usernameTextField.heightAnchor.constraint(equalToConstant: 52),
            passwordTextField.heightAnchor.constraint(equalToConstant: 52),
            signInButton.heightAnchor.constraint(equalToConstant: 46)
        ])
    }
    
    private func setupNavBar() {
        self.navigationItem.title = "Notes"
    }
    
    func Alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let button = UIAlertAction(title: "Dismiss", style: .default)
        
        alert.addAction(button)
        self.present(alert, animated: true)
    }
    
    @objc private func signInButtonPressed() {
        guard let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            Alert(title: "Invalid Input", message: "Please fill in all required fields!")
            return
        }
        
        let loginKey = "\(username)"
        var isNotFirstLogin = UserDefaults.standard.bool(forKey: loginKey)
        
        if isNotFirstLogin {
            guard let retrievedPassword = KeyChainManager.shared.retrievePassword(username: username) else {
                return
            }
            if password == retrievedPassword {
                let noteListVC = NoteListViewController()
                self.navigationController?.pushViewController(noteListVC, animated: true)
            }
        } else {
            isNotFirstLogin = true
            UserDefaults.standard.setValue(isNotFirstLogin, forKey: loginKey)
            do {
                try KeyChainManager.shared.saveCredentials(username: username, password: password)
                let noteListVC = NoteListViewController()
                self.navigationController?.pushViewController(noteListVC, animated: true)
                Alert(title: "Hello!", message: "Welcome to Secure Notes App!")
            } catch {
                print(error)
            }
        }
    }
}
