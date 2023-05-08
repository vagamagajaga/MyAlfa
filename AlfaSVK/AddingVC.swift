//
//  AddingVC.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 04.05.2023.
//

import UIKit

final class AddingVC: UIViewController {
    
    //MARK: - Properties
    private var tableView = UITableView()
    private var addButton = UIButton()
    private var textField = UITextField()
    private var datePicker = UIDatePicker()
    
    private var store = Store()
    
    private var addButtonBottomConstraint: NSLayoutConstraint!
    
    private var reusedCell = "reusedCell"
    
    private lazy var dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yy"
            return formatter
        }()
    
    private var typeOfProducts = ["DC", "CC", "CC2", "CrossDC", "CrossCC", "BC", "MirPay", "RKO", "PIL", "CarLoan"]
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
                
        addSubviews()
        prepareViews()
        addConstraints()
        
        textField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
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
    
    @objc func addDay() {
        guard let comment = textField.text,
              !comment.isEmpty,
              comment != " " else {
            return
        }
        let rowDate = datePicker.date
//        let date = dateFormatter.string(from: rowDate)
        
        store.addDay(day: Day(date: rowDate, comment: comment))
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text,
           !text.isEmpty,
           text != " " {
            addButton.backgroundColor = .systemBlue
        }
    }
    
    @objc private func textFieldIsEmpty(_ textField: UITextField) {
        if let text = textField.text,
           text.isEmpty || text == " " {
            addButton.backgroundColor = .lightGray
        }
    }
    
    private func makeButtonActive() {
        addButton.backgroundColor = .systemBlue
    }
    
    private func dateToString(date: Date) -> String {
        let date = dateFormatter.string(from: date)
        return date
    }
    
    //MARK: - Configuration
    private func addSubviews() {
        view.addSubview(textField)
        view.addSubview(datePicker)
        view.addSubview(addButton)
        view.addSubview(tableView)
    }
    
    private func prepareViews() {
        title = "Выдано продуктов"
        view.backgroundColor = .white
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        textField.placeholder = "Доп. комментарии"
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.addTarget(self, action: #selector(textFieldIsEmpty(_:)), for: .editingChanged)
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        addButton.backgroundColor = .lightGray
        addButton.layer.cornerRadius = 10
        addButton.setTitle("Сохранить", for: .normal)
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
            
            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: addButton.topAnchor),
            
            textField.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            
            addButton.heightAnchor.constraint(equalToConstant: 30),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            addButtonBottomConstraint
        ])
    }
}
    
//MARK: - Extensions
extension AddingVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension AddingVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        typeOfProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: reusedCell)
        cell = UITableViewCell(style: .default, reuseIdentifier: reusedCell)
        
        guard let cell = cell else {
            return UITableViewCell(style: .default, reuseIdentifier: reusedCell)
        }
        
        cell.textLabel?.text = typeOfProducts[indexPath.row]
        cell.accessoryView
        
        return cell
    }
}

extension AddingVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated:  true)
    }
}
