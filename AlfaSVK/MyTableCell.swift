//
//  MyTableViewCell.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 08.05.2023.
//

import UIKit

import UIKit

protocol MyTableViewCellDelegate: AnyObject {
    func fillCardOfDay(product: CardOfDay.Product)
}

final class MyTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    private var nameLabel = UILabel()
    private var numberLabel = UILabel()
    private var counterView = UIStepper()
    private var product: CardOfDay.Product?
    
    weak var delegate: MyTableViewCellDelegate?
    
    static let cellId = "MyTableViewCell"
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                        
        addSubview()
        prepareView()
        addConstraint()
    }
    
    //MARK: - ШТше
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration
    private func addSubview() {
        contentView.addSubview(numberLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(counterView)
    }
    
    private func prepareView() {
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        counterView.translatesAutoresizingMaskIntoConstraints = false

        counterView.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
        counterView.isEnabled = true
        counterView.isUserInteractionEnabled = true
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            numberLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            counterView.trailingAnchor.constraint(equalTo: trailingAnchor),
            counterView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    //MARK: - Methods
    @objc private func stepperValueChanged(sender: UIStepper) {
        numberLabel.text = String(Int(sender.value))
        product?.count = Int(sender.value)
        guard let product else { return }
        delegate?.fillCardOfDay(product: product)
    }
    
    func configure(product: CardOfDay.Product) {
        nameLabel.text = product.name
        numberLabel.text = String(product.count)
        counterView.value = Double(product.count)
        self.product = product
    }
}
