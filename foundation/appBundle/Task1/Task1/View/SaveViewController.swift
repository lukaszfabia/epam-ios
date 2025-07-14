//
//  SaveViewController.swift
//  Task1
//
//  Created by Lukasz Fabia on 10/07/2025.
//


import UIKit

class SaveViewController: UIViewController {
    
    private let noteField: UITextView = {
        let field = UITextView()
        field.isScrollEnabled = true
        field.layer.cornerRadius = 10
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.systemGray5.cgColor
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let filenameField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.placeholder = "File name..."
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let prompt: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .label
        label.textAlignment = .right
        label.text = """
        Save your note. Please provide filename and content. If you want to create a new one, provide a new filename.
        """
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    private var service: FileService!
    private var note: JsonNote? = nil
    private var saveButton: UIBarButtonItem = .init()
    
    init(service: any FileService) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSaveButton()
        view.backgroundColor = .systemBackground
        title = "Save Note"
    }
    
    private func setupUI() {
        view.addSubview(vStack)
        
        vStack.addArrangedSubview(prompt)
        vStack.addArrangedSubview(filenameField)
        vStack.addArrangedSubview(noteField)
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            vStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            vStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            noteField.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    private func setupSaveButton() {
        saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc private func save() {
        guard let text = noteField.text, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showAlert("Note content cannot be empty.")
            return
        }
        
        do {
            note = try service.save(.init(filename: filenameField.text, content: text))
            showAlert("Note saved successfully.")
        } catch {
            showAlert("Error: \(error.localizedDescription)")
        }
    }
    
    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Info", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default){_ in
            self.noteField.text = ""
            self.filenameField.text = ""
        })
        present(alert, animated: true)
    }
}

