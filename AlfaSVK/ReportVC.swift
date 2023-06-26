//
//  ReportVC.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 02.06.2023.
//

import UIKit

protocol ReportVCProtocol: AnyObject { }

final class ReportVC: UIViewController, ReportVCProtocol {
    
    //MARK: - Property
    private var textView = UITextView()
    private var copyButton = UIButton()
    private var titleLabel = UILabel()
    
    var presenter: ReportPresenterProtocol!
    
    private var copyButtonConstraint: NSLayoutConstraint!
    
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
        
        copyButtonConstraint.constant = -keyboardHeight - 20
        view.layoutIfNeeded()
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        copyButtonConstraint.constant = -60
        view.layoutIfNeeded()
    }
    
    @objc private func copyText() {
        UIPasteboard.general.string = textView.text
        dismissKeyboard()
    }
    
    //MARK: - Configuration
    private func addSubviews() {
        view.addSubview(textView)
        view.addSubview(copyButton)
        view.addSubview(titleLabel)
    }
    
    private func prepareView() {
        view.backgroundColor = .systemBackground
                
        textView.translatesAutoresizingMaskIntoConstraints = false
        copyButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = "Отчет"
        titleLabel.textColor = .label
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        textView.text = presenter.returnReportText(cardOfDay: presenter.cardOfDay)
        textView.backgroundColor = .systemBackground
        textView.layer.borderColor = UIColor.label.cgColor
        textView.sizeToFit()
        textView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0)
        textView.font = .boldSystemFont(ofSize: 16)
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 0.2
        
        copyButton.setTitle("Cкопировать отчет", for: .normal)
        copyButton.backgroundColor = .systemBlue
        copyButton.layer.cornerRadius = 10
        copyButton.isEnabled = true
        copyButton.addTarget(self, action: #selector(copyText), for: .touchUpInside)
        copyButton.backgroundColor = .systemBlue
        copyButton.titleLabel?.textColor = .label
    }
    
    private func addConstraints() {
        copyButtonConstraint = copyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: textView.topAnchor, constant: -20),
            
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            textView.bottomAnchor.constraint(equalTo: copyButton.topAnchor, constant: -20),
            
            copyButton.heightAnchor.constraint(equalToConstant: 30),
            copyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            copyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            copyButtonConstraint
        ])
    }
}
