//
//  File.swift
//  Deep Dive Part 2
//
//  Created by Nick Liu on 2023/5/30.
//
import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate  {
    
    var textField = UITextField()
    private var button = UIButton()
    weak var delegate: updateTextProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [textField, button].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        [textField, button].forEach { view.addSubview($0) }
        
        setupUI()
        textField.delegate = self
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func setupUI() {
        button.setTitle("Button", for: .normal)
        button.backgroundColor = .black
        
        textField.borderStyle = .roundedRect
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            textField.widthAnchor.constraint(equalToConstant: view.frame.width * 2/3),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.heightAnchor.constraint(equalToConstant: 40),
            
            button.widthAnchor.constraint(equalToConstant: view.frame.width * 2/3),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 20)
        ])
    }
    
    @objc func buttonTapped() {
        delegate?.updateText(didGet: textField.text ?? "")
        navigationController?.popViewController(animated: true)
    }
    
}

protocol updateTextProtocol: AnyObject {
    
    func updateText(didGet text: String)
    
}
