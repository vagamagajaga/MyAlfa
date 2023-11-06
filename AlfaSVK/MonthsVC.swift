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
    
    var presenter: MonthsPresenterProtocol!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.createMonth()

        tableView.dataSource = self
        tableView.delegate = self

        addSubviews()
        addConstraints()
        prepareSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateData()
    }
    
    //MARK: - Methods
    func updateData() {
        tableView.reloadData()
    }
    
    //MARK: - Configuration
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func addConstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.bottom.trailing.top.equalToSuperview()
        }
    }
    
    private func prepareSubviews() {
        title = "Месяцы"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.largeTitleDisplayMode = .always
        
        navigationItem.hidesBackButton = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
}

//MARK: - Extensions
extension MonthsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.store.months.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: reusedCell)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: reusedCell)
        
        guard let cell = cell else {
            return UITableViewCell(style: .default, reuseIdentifier: reusedCell)
        }
        cell.detailTextLabel?.text = presenter.detailOfMonth(indexPath: indexPath)
        cell.textLabel?.text = presenter.summaryOfMonth(indexPath: indexPath)

        cell.detailTextLabel?.textColor = .gray
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension MonthsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        presenter.showChosenMonth(indexPath: indexPath.row)
    }
}
