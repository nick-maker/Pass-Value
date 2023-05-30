//
//  File.swift
//  Deep Dive Part 2
//
//  Created by Nick Liu on 2023/5/30.
//

import UIKit

class Cell: UITableViewCell {
    
    static let reuseIdentifier = "\(Cell.self)"
    
    var label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var button: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemRed, for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [label, button].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        [label, button].forEach { contentView.addSubview($0)}
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
