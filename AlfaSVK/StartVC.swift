//
//  ViewController.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 04.05.2023.
//

import UIKit

final class StartVC: UIViewController {
    
    //MARK: - Properties
    private var label = UIImageView()
    private var startButton = UIButton()
    
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
        let vc = MeetingVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Configuration
    private func addSubviews() {
        view.addSubview(label)
        view.addSubview(startButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -140),
            
            startButton.heightAnchor.constraint(equalToConstant: 50),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)
        ])
    }
    
    private func prepareSubviews() {
        view.backgroundColor = .white
        
        label.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        label.image = UIImage(named: "Apict")
        label.alpha = 0.0
        
        startButton.layer.cornerRadius = 10
        startButton.setTitle("Go", for: .normal)
        startButton.backgroundColor = .systemRed
        startButton.titleLabel?.textColor = .white
        startButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
}

