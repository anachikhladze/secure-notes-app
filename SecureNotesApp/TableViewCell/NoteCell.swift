//
//  NoteCellTableViewCell.swift
//  SecureNotesApp
//
//  Created by Anna Sumire on 05.11.23.
//

import UIKit

class NoteCell: UITableViewCell {
    
    var noteTitleLabel = UILabel()
    var noteText = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        addSubview(noteTitleLabel)
        addSubview(noteText)
        
        configureTitleLabel()
        configureTextLabel()
        setTitleConstraints()
        setTextConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(note: Note) {
        noteTitleLabel.text = note.title
        noteText.text = note.text
    }
    
    private func configureTitleLabel() {
        noteTitleLabel.numberOfLines = 0
        noteTitleLabel.font = UIFont(name: "Helvetica Bold", size: 25)
        noteTitleLabel.adjustsFontSizeToFitWidth = true
        noteTitleLabel.textAlignment = .left
    }
    
    private func configureTextLabel() {
        noteText.numberOfLines = 1
        noteText.font = UIFont(name: "Helvetica", size: 18)
        noteText.textAlignment = .left
    }
    
    private func setTitleConstraints() {
        noteTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        noteTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        noteTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        noteTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }

    private func setTextConstraints() {
        noteText.translatesAutoresizingMaskIntoConstraints = false
        noteText.topAnchor.constraint(equalTo: noteTitleLabel.bottomAnchor, constant: 10).isActive = true
        noteText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        noteText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
}
