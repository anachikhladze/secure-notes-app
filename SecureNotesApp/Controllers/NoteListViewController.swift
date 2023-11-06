//
//  NoteListViewController.swift
//  SecureNotesApp
//
//  Created by Anna Sumire on 05.11.23.
//

import UIKit

final class NoteListViewController: UIViewController, AddNewNoteDelegate {
    
    // MARK: - Properties
    private var tableView = UITableView()
    var notes: [Note] = []
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notes"
        notes = fetchData()
        configureTableView()
        configureAddButton()
    }
    
    // MARK: - Private Methods
    private func configureAddButton() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToAddDetailsPage))
        let navigationItem = UINavigationItem(title: "Add Note")
        navigationItem.rightBarButtonItem = addButton
        
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44))
        navigationBar.setItems([navigationItem], animated: false)
        
        self.tableView.tableHeaderView = navigationBar
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 100
        tableView.register(NoteCell.self, forCellReuseIdentifier: "noteCell")
        tableView.pin(to: view)
    }
    
    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - TableVIew DataSource
extension NoteListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell") as! NoteCell
        let note = notes[indexPath.row]
        cell.set(note: note)
        
        return cell
    }
    
    @objc private func goToAddDetailsPage() {
        let addNotesPage = AddNoteViewController()
        addNotesPage.delegate = self
        navigationController?.pushViewController(addNotesPage, animated: true)
    }
    
    func addNewNote(_ title: String, _ text: String) {
        let newNote = Note(title: title, text: text)
        notes.append(newNote)
        tableView.reloadData()
    }
}

extension NoteListViewController {
    func fetchData() -> [Note] {
        Note.noteList
    }
}

extension NoteListViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = notes[indexPath.row].text
        let noteDetailsVC = NoteDetailsViewController(noteIndex: indexPath.row, note: note)
        noteDetailsVC.note = notes[indexPath.row].text
        noteDetailsVC.delegate = self
        noteDetailsVC.noteIndex = indexPath.row
        self.navigationController?.pushViewController(noteDetailsVC, animated: true)
    }
    
    // MARK: - Delete Note
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let noteToDelete = notes[indexPath.row]
            if let index = notes.firstIndex(where: { $0.title == noteToDelete.title }) {
                notes.remove(at: index)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
}

extension NoteListViewController: NoteDetailsDelegate {
    func updateNote(note: String, index: Int) {
        guard index >= 0 && index < notes.count else { return }
        notes[index].text = note
        tableView.reloadData()
    }
}
