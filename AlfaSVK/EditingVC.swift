//
//  EditingVC.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 04.05.2023.
//

import UIKit

final class EditingVC: UIViewController {
    
    //MARK: - Properties
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: MyTableViewCell.cellId)
        tableView.allowsSelection = false
        return tableView
    }()
    
    private var addButton = UIButton()
    private var textField = UITextField()
    private var datePicker = UIDatePicker()
    private var sumLabel = UILabel()
    private var reportButton = UIButton()
    
    private var store = Store()
    lazy var chosenCardOfDay = CardOfDay()
    
    private var addButtonBottomConstraint: NSLayoutConstraint!
    
    private var reusedCell = "reusedCell"
    
    private lazy var dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yy"
            return formatter
        }()
    
    private lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        tableView.dataSource = self
        
        addSubviews()
        prepareViews()
        addConstraints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - Methods
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardHeight = keyboardSize.cgRectValue.height
        
        addButtonBottomConstraint.constant = -keyboardHeight - 20
        view.layoutIfNeeded()
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        addButtonBottomConstraint.constant = -60
        view.layoutIfNeeded()
    }
    
    @objc private func addDay() {
        chosenCardOfDay.date = datePicker.date
        store.addDay(day: self.chosenCardOfDay)
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        chosenCardOfDay.comment = textField.text
    }
    
    @objc private func moveToReport() {
        let vc = ReportVC()
        vc.cardOfDay = chosenCardOfDay
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func returnSum() -> String {
        let text = "Заработано: " + (numberFormatter.string(from: chosenCardOfDay.summaryOfDay() as NSNumber) ?? "0")
        return text
    }
    
    //MARK: - Configuration
    private func addSubviews() {
        view.addSubview(textField)
        view.addSubview(datePicker)
        view.addSubview(addButton)
        view.addSubview(tableView)
        view.addSubview(sumLabel)
        view.addSubview(reportButton)
    }
    
    private func prepareViews() {
        title = "Выдано продуктов"
        view.backgroundColor = .white
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        sumLabel.translatesAutoresizingMaskIntoConstraints = false
        reportButton.translatesAutoresizingMaskIntoConstraints = false
        
        sumLabel.text = returnSum()
        sumLabel.textAlignment = .center
        
        reportButton.backgroundColor = .systemBlue
        reportButton.layer.cornerRadius = 10
        reportButton.setTitle("Отчет", for: .normal)
        reportButton.isEnabled = true
        reportButton.titleLabel?.textColor = .white
        reportButton.addTarget(self, action: #selector(moveToReport), for: .touchUpInside)
        
        if let text = chosenCardOfDay.comment {
            textField.text = text
        } else {
            textField.placeholder = "Доп. комментарии"
        }
        
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        datePicker.datePickerMode = .date
        datePicker.date = chosenCardOfDay.date ?? Date()
        datePicker.preferredDatePickerStyle = .wheels
        
        addButton.backgroundColor = .systemBlue
        addButton.layer.cornerRadius = 10
        addButton.setTitle("Изменить", for: .normal)
        addButton.isEnabled = true
        addButton.titleLabel?.textColor = .white
        addButton.addTarget(self, action: #selector(addDay), for: .touchUpInside)
    }
    
    private func addConstraints() {
        addButtonBottomConstraint = addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)
        
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            datePicker.heightAnchor.constraint(equalToConstant: 100),
            
            sumLabel.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            sumLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            reportButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            reportButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            reportButton.heightAnchor.constraint(equalTo: sumLabel.heightAnchor),
            reportButton.widthAnchor.constraint(equalToConstant: 75),
            
            textField.topAnchor.constraint(equalTo: sumLabel.bottomAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -20),

            addButton.heightAnchor.constraint(equalToConstant: 30),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            addButtonBottomConstraint
        ])
    }
}

//MARK: - Extensions
extension EditingVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension EditingVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chosenCardOfDay.arrayOfProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.cellId, for: indexPath) as? MyTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(product: chosenCardOfDay.arrayOfProducts[indexPath.row])
        cell.delegate = self
    
        return cell
    }
}

extension EditingVC: MyTableViewCellDelegate {
    func fillCardOfDay(product: CardOfDay.Product) {
        let productIndex = chosenCardOfDay.arrayOfProducts.firstIndex(where: { $0.name == product.name })
        if let index = productIndex {
            chosenCardOfDay.arrayOfProducts[index] = product
        }
        sumLabel.text = returnSum()
    }
}
