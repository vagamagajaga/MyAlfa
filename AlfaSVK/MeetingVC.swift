//
//  MeetingVCC.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 29.05.2023.
//

import UIKit

protocol MeetingVCProtocol: AnyObject {
    var tableView: UITableView { get set }
    //но какие функции сюда реально стоит добавить, ведь основные задачи выполняет таблица и ее делегаты?
    //kosyak Вот сюда добавить метод updateData и в него reloadData()
    //делать гет сет для тейбл вью прям ну хуйня идея полная) хоть и рабочая но зачем нам тогда ваще мвп)
}

final class MeetingVC: UIViewController, MeetingVCProtocol {
    
    //MARK: - Properties
    private let reusedCell = "reusedCell"

    var tableView = UITableView()
    private var addButton = UIButton()
    private var emptyTextLabel = UILabel()
    
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
        presenter.updateBooksByDate()
    }
    
    //MARK: - Methods
    @objc private func addButtonPressed() {
        let vc = ModuleBuilder.createCardOfDayVC(cardOfDay: CardOfDay(date: Date()), numberOfDay: 0, doWeChooseCard: false)
        //kosyak либо не досмотрел видосы до конца либо поленился добавлять, но это должно быть в роутере все)
        navigationController?.pushViewController(vc, animated: true)
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
        return presenter.store.meetings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: reusedCell)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: reusedCell)
        
        guard let cell = cell else {
            return UITableViewCell(style: .default, reuseIdentifier: reusedCell)
        }
        
        cell.textLabel?.text = presenter.store.meetings[indexPath.row].summaryOfDay().intToStringWithSeparator()
        cell.detailTextLabel?.text = presenter.store.meetings[indexPath.row].date.dateToString() + " " + (presenter.store.meetings[indexPath.row].comment ?? "")
        cell.detailTextLabel?.textColor = .gray
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

extension MeetingVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cardOfChosenDay = presenter.store.meetings[indexPath.row]
        let vc = ModuleBuilder.createCardOfDayVC(cardOfDay: cardOfChosenDay,
                                                 numberOfDay: indexPath.row,
                                                 doWeChooseCard: true)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipeRead = UIContextualAction(style: .normal, title: "Удалить") { [weak self] action, view, success in
            guard let self else { return }
            tableView.performBatchUpdates {
                //kosyak Обращаться так конечно работает и прикольно но , правильнее было бы создать метод в презентере, который бы обращался у себя в стор и удалял день
                //аналогично строчка 121 вот там уже можно создать геттер для стор митингов как вариант
                self.presenter.store.removeDay(indexPath: indexPath)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
        
        swipeRead.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [swipeRead])
    }
}
