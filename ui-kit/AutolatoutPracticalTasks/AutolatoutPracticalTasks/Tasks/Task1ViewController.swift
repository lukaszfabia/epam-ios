//
//  Task1ViewController.swift
//  AutolatoutPracticalTasks
//
//  Created by Kakhaberi Kiknadze on 20.03.25.
//

import UIKit

final class Task1ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        let label = UILabel()
        label.text = "Label here"
        label.backgroundColor = .white
        // added
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        NSLayoutConstraint.activate(
            [
                label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//                label.widthAnchor.constraint(equalToConstant: 100),
//                label.heightAnchor.constraint(equalToConstant: 20)
            ]
        )
    
    }
}

#Preview {
    Task1ViewController()
}
