//
//  ViewController.swift
//  Deep Dive Part 2
//
//  Created by Nick Liu on 2023/5/30.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
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
        cell.selectionStyle = .none
        cell.onDelete = {
            self.deleteCell(at: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        textArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowSelected = indexPath.row
        clickToUpdate = textArray[indexPath.row]
        clickToPush()
    }
    
    func setupNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToPush))
    }
    
    @objc func addToPush() {
        let secondVC = SecondViewController()
        secondVC.view.backgroundColor = .white
        secondVC.updateText = { [weak self] newText in
            guard let self = self else { return }
            self.textArray.append(newText)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
    func clickToPush() {
        let secondVC = SecondViewController()
        secondVC.view.backgroundColor = .white
        secondVC.updateText = { [weak self] newText in
            guard let self = self else { return }
            self.textArray[rowSelected] = newText
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        secondVC.textField.text = clickToUpdate
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
    func deleteCell(at indexPath: IndexPath) {
        textArray.remove(at: indexPath.row)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

