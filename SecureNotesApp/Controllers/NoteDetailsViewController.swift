//
//  NoteDetailsViewController.swift
//  SecureNotesApp
//
//  Created by Anna Sumire on 05.11.23.
//

import UIKit

protocol NoteDetailsDelegate: AnyObject {
    func updateNote(note: String, index: Int)
}

final class NoteDetailsViewController: UIViewController {
    
    weak var delegate: NoteDetailsDelegate?
    var noteIndex: Int
    var note: String
    
    private var titleLabel = UILabel()
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
    
    init(noteIndex: Int, note: String) {
        self.noteIndex = noteIndex
        self.note = note
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupTitleLabel() {
        titleLabel.numberOfLines = 0
        titleLabel.text = "Edit Your Notes"
    }
    
    private func setupTitleTextField() {
        titleTextField.placeholder = ""
        titleTextField.layer.cornerRadius = 30
    }
    
    private func setupDescriptionTextField() {
        descriptionTextField.placeholder = ""
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
        if let note = descriptionTextField.text, !note.isEmpty {
            delegate?.updateNote(note: note, index: noteIndex)
            dismiss(animated: true, completion: nil)
        }
    }
}
