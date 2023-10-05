//
//  MonthsVC.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 31.07.2023.
//

import UIKit
import SnapKit

protocol MonthsVCProtocol: AnyObject {
    func updateData()
}

final class MonthsVC: UIViewController, MonthsVCProtocol {

    //MARK: - Properties
    private let reusedCell = "reusedCell"

    private var tableView = UITableView()
    private var addButton = UIButton()
    
    var presenter: MonthsPresenterProtocol!
    
    //MARK: - Private Constants
    private enum UIConstants {
        static let addButtonSize: CGFloat = 30
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        addSubviews()
        addConstraints()
        prepareSubviews()
    }
    
    func updateData() {
        
    }
    
    //MARK: - Methods
    @objc private func addButtonPressed() {
        presenter.addNewMonth(numberOfMonth: 0, doWeChooseMonth: false)
    }
    
    //MARK: - Configuration
    private func addSubviews() {
        view.addSubview(tableView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
    }
    
    private func addConstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.bottom.trailing.top.equalToSuperview()
        }
        addButton.snp.makeConstraints { make in
            make.height.width.equalTo(UIConstants.addButtonSize)
        }
    }
    
    private func prepareSubviews() {
        title = "Рабочие дни"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.largeTitleDisplayMode = .always
        
        navigationItem.hidesBackButton = true
        
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.tintColor = .systemBlue
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
    }
}

//MARK: - Extensions
extension MonthsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.store.meetings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: reusedCell, for: indexPath)
        return cell
    }
}

extension MonthsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipeRead = UIContextualAction(style: .normal, title: "Удалить") { [weak self] action, view, success in
            guard let self else { return }
            tableView.performBatchUpdates {
                self.presenter.removeMonthFromStore(indexPath: indexPath)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
        swipeRead.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [swipeRead])
    }
}
