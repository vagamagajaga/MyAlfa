//
//  ViewController.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 04.05.2023.
//

import UIKit

protocol StartVCProtocol: AnyObject {
    
}

final class StartVC: UIViewController, StartVCProtocol {
    
    //MARK: - Properties
    private var label = UIImageView()
    private var startButton = UIButton(type: .system)
    
    var presenter: StartPresenterProtocol!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        addConstraints()
        prepareSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 2.0) {
            self.label.alpha = 1.0
        }
    }
    
    //MARK: - Methods
    @objc private func buttonPressed() {
        presenter.tapOnGo()
    }
    
    //MARK: - Configuration
    private func addSubviews() {
        view.addSubview(label)
        view.addSubview(startButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -80),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 80),
            
            startButton.heightAnchor.constraint(equalToConstant: 50),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)
        ])
    }
    
    private func prepareSubviews() {
        view.backgroundColor = .systemBackground
        
        label.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        label.image = UIImage(named: "Cherry_for_AlfaSVK")
        label.alpha = 0.1
        
        startButton.layer.cornerRadius = 10
        startButton.backgroundColor = .systemRed
        startButton.setTitle("Go", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        startButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
}
