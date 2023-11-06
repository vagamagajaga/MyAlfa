//
//  MeetingVCC.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 29.05.2023.
//

import UIKit
import SnapKit

protocol MeetingVCProtocol: AnyObject {
    func updateData()
}

final class MeetingVC: UIViewController, MeetingVCProtocol {
    
    //MARK: - Properties
    private let reusedCell = "reusedCell"

    private var tableView = UITableView()
    private var addButton = UIButton()
    
    var presenter: MeetingPresenterProtocol!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        addSubviews()
        addConstraints()
        prepareSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.updateDaysByDate()
    }
    
    //MARK: - Methods
    @objc private func addButtonPressed() {
        presenter.addNewDay( monthNumber: presenter.monthNumber, numberOfDay: 0, doWeChooseCard: false)
    }
    
    func updateData() {
        tableView.reloadData()
    }
    
    //MARK: - Configuration
    private func addSubviews() {
        view.addSubview(tableView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            addButton.widthAnchor.constraint(equalToConstant: 30),
            addButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func prepareSubviews() {
        title = "Рабочие дни"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.largeTitleDisplayMode = .always
                
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.tintColor = .systemBlue
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
    }
}

//MARK: - Extensions
extension MeetingVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.store.months[presenter.monthNumber].days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: reusedCell)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: reusedCell)
        
        guard let cell = cell else {
            return UITableViewCell(style: .default, reuseIdentifier: reusedCell)
        }
        
        cell.textLabel?.text = presenter.summaryOfDayInString(indexPath: indexPath)
        cell.detailTextLabel?.text = presenter.detailOfDay(indexPath: indexPath)
        cell.detailTextLabel?.textColor = .gray
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension MeetingVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cardOfChosenDay = presenter.store.months[presenter.monthNumber].days[indexPath.row]
        presenter.chooseDayFromList(cardOfDay: cardOfChosenDay,  monthNumber: presenter.monthNumber, numberOfDay: indexPath.row, doWeChooseCard: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipeRead = UIContextualAction(style: .normal, title: "Удалить") { [weak self] action, view, success in
            guard let self else { return }
            tableView.performBatchUpdates {
                self.presenter.removeDayFromStore(indexPath: indexPath)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
        swipeRead.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [swipeRead])
    }
}
