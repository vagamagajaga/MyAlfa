//
//  CardOfDayVC.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 02.06.2023.
//

import UIKit

protocol CardOfDayVCProtocol: AnyObject {
    var cardOfDay: CardOfDay { get set }
}

final class CardOfDayVC: UIViewController, CardOfDayVCProtocol {
    
    //MARK: - Properties
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: MyTableViewCell.cellId)
        tableView.allowsSelection = false
        return tableView
    }()
    
    private var addButton = UIButton()
    private var datePicker = UIDatePicker()
    private var sumLabel = UILabel()
    private var reportButton = UIButton()
    private var areaField = UITextField()
    
    var presenter: CardOfDayPresenterProtocol!
    //kosyak Это не похоже на юай а мохоже на модель, значит этому тут не место
    lazy var cardOfDay: CardOfDay = CardOfDay(date: Date())
    
    private var addButtonBottomConstraint: NSLayoutConstraint!
    
    private var reusedCell = "reusedCell"
    //kosyak и этому тут не место
    private var doWeChooseCard: Bool = false
    private var numberOfDay: Int = 0
    
    //MARK: - Lifecycle
    //kosyak да и эти данные должен презентер передавать сюда
    init(numberOfDay: Int = 0, doWeChooseCard: Bool = false) {
        self.numberOfDay = numberOfDay
        self.doWeChooseCard = doWeChooseCard
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //kosyak вообще запуск контроллера как правило начинается с обращения в презентер, оттуда ты можешь получить свои нужны инит данные для 42-43 строчки
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
        cardOfDay.date = datePicker.date
        doWeChooseCard ? presenter.store.meetings[numberOfDay] = cardOfDay : presenter.store.addDay(day: self.cardOfDay)
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        cardOfDay.comment = textField.text
    }
    
    @objc private func moveToReport() {
        cardOfDay.date = datePicker.date
        let vc = ModuleBuilder.createReportVC(carDofDay: cardOfDay)
        navigationController?.pushViewController(vc, animated: true)
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
        
        sumLabel.text = presenter.returnSum(cardOfDay: cardOfDay)
        sumLabel.textAlignment = .center
        
        reportButton.backgroundColor = .systemBlue
        reportButton.layer.cornerRadius = 10
        reportButton.setTitle("Отчет", for: .normal)
        reportButton.isEnabled = true
        reportButton.titleLabel?.textColor = .white
        reportButton.addTarget(self, action: #selector(moveToReport), for: .touchUpInside)
        
        if let text = cardOfDay.comment {
            areaField.text = text
        } else {
            areaField.placeholder = "Укажи район"
        }
        
        datePicker.date = cardOfDay.date
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        addButton.backgroundColor = .systemBlue
        addButton.layer.cornerRadius = 10
        addButton.setTitle(doWeChooseCard ? "Изменить" : "Сохранить", for: .normal)
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
            
            areaField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            areaField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            areaField.topAnchor.constraint(equalTo: sumLabel.bottomAnchor, constant: 20),
            
            tableView.topAnchor.constraint(equalTo: areaField.bottomAnchor, constant: 20),
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
extension CardOfDayVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cardOfDay.arrayOfProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as? MyTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(product: cardOfDay.arrayOfProducts[indexPath.row])
        cell.delegate = self
    
        return cell
    }
}

extension CardOfDayVC: MyTableViewCellDelegate {
    func fillCardOfDay(product: CardOfDay.Product) {
        let productIndex = cardOfDay.arrayOfProducts.firstIndex(where: { $0.name == product.name })
        if let index = productIndex {
            cardOfDay.arrayOfProducts[index] = product
        }
        
        //kosyak Вот тут более менее вызываешь правильно, но кард оф дей должен в презентере храниться
        sumLabel.text = presenter.returnSum(cardOfDay: cardOfDay)
    }
}

extension CardOfDayVC: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        cardOfDay.comment = textField.text
    }
}
