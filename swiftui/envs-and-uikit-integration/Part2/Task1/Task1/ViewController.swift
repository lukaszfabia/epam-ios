//
//  ViewController.swift
//  Task1
//
//  Created by Lukasz Fabia on 14/08/2025.
//

import UIKit
import SwiftUI

fileprivate let openSheetButtonPadding: CGFloat = 5.0

class ViewController: UIViewController {
    
    private let openSheetButton: UIButton = {
        var buttonConfig = UIButton.Configuration.filled()
        buttonConfig.title = "Open SwiftUI View"
        buttonConfig.baseBackgroundColor = .systemIndigo.withAlphaComponent(0.8)
        buttonConfig.baseForegroundColor = .white
        buttonConfig.background.strokeWidth = 1
        buttonConfig.background.strokeColor = .systemIndigo
        buttonConfig.cornerStyle = .capsule
        
        buttonConfig.contentInsets = .init(
            top: openSheetButtonPadding,
            leading: openSheetButtonPadding,
            bottom: openSheetButtonPadding,
            trailing: openSheetButtonPadding
        )
        
        buttonConfig.titlePadding = 4
        
        let button = UIButton(configuration: buttonConfig)
        
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    private let swiftUIView = UIHostingController(rootView: SwiftUIView())

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Task 1 - uikit with swiftui"
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .systemBackground
        
        setupUI()
        setupHandlers()
    }


    private func setupUI() {
        view.addSubview(openSheetButton)
        
        NSLayoutConstraint.activate([
            openSheetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            openSheetButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            openSheetButton.widthAnchor.constraint(equalToConstant: 200),
            openSheetButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setupHandlers() {
        openSheetButton.addTarget(self, action: #selector(openSheet), for: .touchUpInside)
    }
    
    @objc
    private func openSheet() {
        present(swiftUIView, animated: true)
    }
}

