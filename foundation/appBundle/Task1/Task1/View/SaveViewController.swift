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
        field.layoutMargins = .init(top: 5, left: 5, bottom: 5, right: 5)
        field.insetsLayoutMarginsFromSafeArea = true
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
        label.textAlignment = .left
        label.text = """
        Save your note. Please provide filename and content. If you want to create a new one, provide a new filename.
        """
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let generateFileNameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "sparkles"), for: .normal)
        button.tintColor = .systemYellow
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
    
    private var keyboard: KeyboardHandler?
    private var bottom: NSLayoutConstraint!
    
    private var saveButton: UIBarButtonItem = .init()
    
    init(service: any FileService) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        noteField.delegate = self
        filenameField.delegate = self
        
        setupUI()
        setupSaveButton()
        setupGenerateFileNameButton()
        setupGestures()
        
        
        keyboard = KeyboardHandler(fn: { _ in
            self.view.layoutIfNeeded()
        })
    }
    
     private func setupGestures() {
         view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
     }
     
     @objc private func endEditing() {
         view.endEditing(true)
     }
    
    private func setupUI() {
        view.addSubview(vStack)
        
        vStack.addArrangedSubview(prompt)
        
        hStack.addArrangedSubview(filenameField)
        hStack.addArrangedSubview(generateFileNameButton)
        
        vStack.addArrangedSubview(hStack)
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
    
    private func setupGenerateFileNameButton() {
        generateFileNameButton.addTarget(self, action: #selector(generate), for: .touchUpInside)
    }
    
    @objc private func generate(_ sender: UIButton) {
        filenameField.text = service.uniqueFileName
    }
    
    @objc private func save() {
        guard let text = noteField.text, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showAlert("Note content cannot be empty.")
            return
        }
        
        do {
            note = try service.save(.init(filename: filenameField.text, content: text))
            showAlert("\(filenameField.text ?? "???") saved successfully.")
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


extension SaveViewController: UITextFieldDelegate, UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        guard text == "\n" else {return true}
        
        textView.resignFirstResponder()
        
        return false
    }
    
}
