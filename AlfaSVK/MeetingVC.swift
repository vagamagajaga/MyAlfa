//
//  SecondVC.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 04.05.2023.
//

import UIKit

final class MeetingVC: UIViewController {
    
    //MARK: - Properties
    private let reusedCell = "reusedCell"

    private var tableView = UITableView()
    private var addButton = UIButton()
    private var emptyTextLabel = UILabel()
    
    private var store = Store()
    
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
        
        tableView.dataSource = self
        tableView.delegate = self
        
        addSubviews()
        addConstraints()
        prepareSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateBooksByDate()
    }
    
    //MARK: - Methods
    @objc private func addButtonPressed() {
        let vc = CardOfDayVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func updateBooksByDate() {
        if store.meetings.count > 1 {
            store.meetings.sort { $0.date < $1.date }
        }
        tableView.reloadData()
    }
    
    //MARK: - Configuration
    private func addSubviews() {
        view.addSubview(tableView)
        tableView.addSubview(emptyTextLabel)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            emptyTextLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            emptyTextLabel.centerYAnchor.constraint(equalTo: tableView.centerYAnchor, constant: -140),
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func dateToString(date: Date) -> String {
        let date = dateFormatter.string(from: date)
        return date
    }
    
    private func prepareSubviews() {
        title = "Рабочие дни"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.largeTitleDisplayMode = .always
        
        navigationItem.hidesBackButton = true
        
        emptyTextLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        emptyTextLabel.text = "Список пуст"
        emptyTextLabel.font = .boldSystemFont(ofSize: 24)
        emptyTextLabel.textColor = .lightGray
        emptyTextLabel.isHidden = true
        
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.tintColor = .systemBlue
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
    }
}

//MARK: - Extensions
extension MeetingVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.meetings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: reusedCell)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: reusedCell)
        
        guard let cell = cell else {
            return UITableViewCell(style: .default, reuseIdentifier: reusedCell)
        }
        
        cell.textLabel?.text = numberFormatter.string(from: store.meetings[indexPath.row].summaryOfDay() as NSNumber)
        cell.detailTextLabel?.text = dateToString(date: store.meetings[indexPath.row].date) + " " + (store.meetings[indexPath.row].comment ?? "") 
        cell.detailTextLabel?.textColor = .gray
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

extension MeetingVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = CardOfDayVC(numberOfDay: indexPath.row, doWeChooseCard: true)
        vc.cardOfDay = store.meetings[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipeRead = UIContextualAction(style: .normal, title: "Удалить") { [weak self] action, view, success in
            guard let self else { return }
            tableView.performBatchUpdates {
                self.store.removeDay(indexPath: indexPath)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
        
        swipeRead.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [swipeRead])
    }
}
