//
//  ViewController.swift
//  Deep Dive Part 2
//
//  Created by Nick Liu on 2023/5/30.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, updateTextProtocol {
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    var textArray = ["2", "3", "4", "5"]
    var clickToUpdate = ""
    var rowSelected = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate(
            [tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
             tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
             tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
             tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)]
        )
        
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
        setupNavigation()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else { fatalError("Cannot Downcasting") }
        cell.label.text = textArray[indexPath.row]
        cell.button.setTitle("Delete", for: .normal)
        cell.button.addTarget(self, action: #selector(deleteCell), for: .touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        textArray.count
    }
    
    func setupNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToPush))
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowSelected = indexPath.row
        clickToUpdate = textArray[indexPath.row]
        clickToPush()
    }
    
    @objc func deleteCell(sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        guard let indexPath = tableView.indexPathForRow(at: point) else { return }
        
        textArray.remove(at: indexPath.row)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc func addToPush() {
        clickToUpdate = ""
        let secondVC = SecondViewController()
        secondVC.delegate = self
        secondVC.view.backgroundColor = .white
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
    func clickToPush() {
        let secondVC = SecondViewController()
        secondVC.delegate = self
        secondVC.view.backgroundColor = .white
        secondVC.textField.text = clickToUpdate
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
    func updateText(didGet text: String) {
        if clickToUpdate.isEmpty {
            textArray.append(text)
        } else {
            textArray[rowSelected] = text
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}



