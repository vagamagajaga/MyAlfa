//
//  ReportVC.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 16.05.2023.
//

import UIKit

final class ReportVC: UIViewController {
    
    //MARK: - Property
    private var textView = UITextView()
    private var copyButton = UIButton()
    
    var cardOfDay = CardOfDay()
    
    private var copyButtonConstraint: NSLayoutConstraint!
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        return formatter
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        prepareView()
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
        
        copyButtonConstraint.constant = -keyboardHeight - 20
        view.layoutIfNeeded()
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        copyButtonConstraint.constant = -60
        view.layoutIfNeeded()
    }
    
    @objc private func copyText() {
        let text = textView.text
        UIPasteboard.general.string = text
    }
    
    private func dateToString(date: Date) -> String {
        let date = dateFormatter.string(from: date)
        return date
    }
    
    private func returnReportText() -> String {
        let products = cardOfDay.arrayOfProducts
        let date = dateToString(date: cardOfDay.date ?? Date())
        
        let text = """
        Отчет за \(date)
        
        DC \(products[0].count)/всего
        
        СС \(products[1].count)/всего
        
        СС2 \(products[2].count)/всего
        
        ZPC \(products[5].count)/всего
        
        RKO \(products[7].count)/всего
        
        PIL \(products[8].count)/всего
        
        Автокредит \(products[9].count)/всего
        
        КРОССЫ
        
        ДК \(products[4].count)
        КК \(products[5].count)/одобрено/\(products[0].count)
        
        НС
        БС \(products[10].count)
        
        MirPay \(cardOfDay.sumOfCards())/андроиды/\(products[6].count)
        """
        return text
    }
    
    //MARK: - Configuration
    private func addSubviews() {
        view.addSubview(textView)
        view.addSubview(copyButton)
    }
    
    private func prepareView() {
        title = "Отчет"
        view.backgroundColor = .white
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        copyButton.translatesAutoresizingMaskIntoConstraints = false
        
        textView.text = returnReportText()
        textView.font = .boldSystemFont(ofSize: 16)
        textView.layer.cornerRadius = 10
        textView.backgroundColor = .white
        textView.layer.borderWidth = 0.2
        
        copyButton.setTitle("Cкопировать отчет", for: .normal)
        copyButton.backgroundColor = .systemBlue
        copyButton.layer.cornerRadius = 10
        copyButton.titleLabel?.textColor = .white
        copyButton.isEnabled = true
        copyButton.addTarget(self, action: #selector(copyText), for: .touchUpInside)
    }
    
    private func addConstraints() {
        copyButtonConstraint = copyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)
        
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 180),
            textView.bottomAnchor.constraint(equalTo: copyButton.topAnchor, constant: -20),
            
            copyButton.heightAnchor.constraint(equalToConstant: 30),
            copyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            copyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            copyButtonConstraint
        ])
    }
}
