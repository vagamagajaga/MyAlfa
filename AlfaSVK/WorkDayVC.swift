//
//  WorkDayVC.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 02.06.2023.
//

import UIKit

protocol WorkDayVCProtocol: AnyObject {
}

final class WorkDayVC: UIViewController, WorkDayVCProtocol {
    
    //MARK: - Properties
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: MyTableViewCell.cellId)
        tableView.allowsSelection = false
        return tableView
    }()
    
    private var sumLabel = UILabel()
    private var areaField = UITextField()
    private var datePicker = UIDatePicker()
    private var addButton = UIButton(type: .system)
    private var reportButton = UIButton(type: .system)
    
    var presenter: WorkDayPresenterProtocol!
    
    private var addButtonBottomConstraint: NSLayoutConstraint!
    
    private var reusedCell = "reusedCell"

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        prepareViews()
        addConstraints()
        
        areaField.delegate = self
        tableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        self.hideKeyboardWhenTappedAround()
    }
    
    //MARK: - Init
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
        presenter.chosenDay.date = datePicker.date
        presenter.doWeChooseCard ? presenter.store.meetings[presenter.numberOfDay] = presenter.chosenDay : presenter.store.addDay(day: presenter.chosenDay)
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        presenter.chosenDay.comment = textField.text
    }
    
    @objc private func moveToReport() {
        presenter.chosenDay.date = datePicker.date
        presenter.showReport()
    }
    
    //MARK: - Configuration
    private func addSubviews() {
        view.addSubview(datePicker)
        view.addSubview(addButton)
        view.addSubview(tableView)
        view.addSubview(sumLabel)
        view.addSubview(reportButton)
        view.addSubview(areaField)
    }
    
    private func prepareViews() {
        title = "Карточка дня"
        view.backgroundColor = .systemBackground
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        sumLabel.translatesAutoresizingMaskIntoConstraints = false
        reportButton.translatesAutoresizingMaskIntoConstraints = false
        areaField.translatesAutoresizingMaskIntoConstraints = false
        
        sumLabel.text = presenter.returnSum(cardOfDay: presenter.chosenDay)
        sumLabel.textAlignment = .center
        
        reportButton.backgroundColor = .systemBlue
        reportButton.layer.cornerRadius = 10
        reportButton.setTitle("Отчет", for: .normal)
        reportButton.setTitleColor(.white, for: .normal)
        reportButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        reportButton.addTarget(self, action: #selector(moveToReport), for: .touchUpInside)
        
        if let text = presenter.chosenDay.comment {
            areaField.text = text
        } else {
            areaField.placeholder = "Укажи район"
        }
        
        datePicker.date = presenter.chosenDay.date
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        addButton.layer.cornerRadius = 10
        addButton.backgroundColor = .systemBlue
        addButton.setTitleColor(.white, for: .normal)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        addButton.addTarget(self, action: #selector(addDay), for: .touchUpInside)
        addButton.setTitle(presenter.doWeChooseCard ? "Изменить" : "Сохранить", for: .normal)
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
            
            areaField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            areaField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            areaField.topAnchor.constraint(equalTo: sumLabel.bottomAnchor, constant: 20),
            
            tableView.topAnchor.constraint(equalTo: areaField.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -20),

            addButton.heightAnchor.constraint(equalToConstant: 40),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            addButtonBottomConstraint
        ])
    }
}
    
//MARK: - Extensions
extension WorkDayVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.chosenDay.arrayOfProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as? MyTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(product: presenter.chosenDay.arrayOfProducts[indexPath.row])
        cell.delegate = self
    
        return cell
    }
}

extension WorkDayVC: MyTableViewCellDelegate {
    func fillCardOfDay(product: BusinessDay.Product) {
        let productIndex = presenter.chosenDay.arrayOfProducts.firstIndex(where: { $0.name == product.name })
        if let index = productIndex {
            presenter.chosenDay.arrayOfProducts[index] = product
        }
        
        sumLabel.text = presenter.returnSum(cardOfDay: presenter.chosenDay)
    }
}

extension WorkDayVC: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        presenter.chosenDay.comment = textField.text
    }
}
