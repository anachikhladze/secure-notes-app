//
//  AddNoteViewController.swift
//  SecureNotesApp
//
//  Created by Anna Sumire on 05.11.23.
//

import UIKit

protocol AddNewNoteDelegate: AnyObject {
    func addNewNote(_ title: String, _ text: String)
}

final class AddNoteViewController: UIViewController {
    
    // MARK: - Properties
    weak var delegate: AddNewNoteDelegate?
    
    private let titleLabel = UILabel()
    private let titleTextField = UITextField()
    private let descriptionTextField = UITextField()
    private let saveButton = UIButton()
    private let stackView = UIStackView()
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitleLabel()
        setupTitleTextField()
        setupDescriptionTextField()
        setupSaveButton()
        setupStackView()
        setupSubviews()
        setupBackground()
    }
    
    // MARK: - Private Methods
    private func setupTitleLabel() {
        titleLabel.numberOfLines = 0
        titleLabel.text = "Add New Note"
    }
    
    private func setupTitleTextField() {
        titleTextField.placeholder = "Name your note here"
        titleTextField.layer.cornerRadius = 30
    }
    
    private func setupDescriptionTextField() {
        descriptionTextField.placeholder = "Type your text here"
        descriptionTextField.layer.cornerRadius = 30
    }
    
    private func setupSaveButton() {
        saveButton.frame = CGRect(x: 100, y: 100, width: 200, height: 40)
        saveButton.configuration = .filled()
        saveButton.setTitle("Save Note", for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
    }
    
    private func setupStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .equalCentering
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 60),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -60),
            stackView.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
    
    private func setupSubviews() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(titleTextField)
        stackView.addArrangedSubview(descriptionTextField)
        stackView.addArrangedSubview(saveButton)
        setupConstraints()
    }
    
    private func setupBackground() {
        view.backgroundColor = .white
    }
    
    @objc private func saveButtonPressed() {
        if let text = descriptionTextField.text, let title = titleTextField.text {
            delegate?.addNewNote(title, text)
            navigationController?.popViewController(animated: true)
        }
    }
}
