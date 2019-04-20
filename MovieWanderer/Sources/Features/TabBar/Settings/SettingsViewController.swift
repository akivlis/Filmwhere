//
//  SettingsViewController.swift
//  MovieWanderer
//
//  Created by Silvia Kuzmova on 11/02/2018.
//  Copyright © 2018 Silvia Kuzmova. All rights reserved.
//

import UIKit
import SafariServices

class SettingsViewController: UIViewController {
    
    private lazy var tableView = UITableView()
    private let viewModel = SettingsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupObservables()
    }
}

// MARK: UITableViewDataSource

extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.reuseIdentifier, for: indexPath) as! SettingTableViewCell
        let row = viewModel.getRowFor(index: indexPath.row)
        cell.set(row.title, iconName: row.iconName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SettingsFooterView.reuseIdentifier) as! SettingsFooterView
        return footerView
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .lightGray
        return header
    }
    
}

// MARK: UITableViewDelegate

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 70
    }
}


// MARK: - Private

private extension SettingsViewController {
    
    private func setupViews(){
        title = "Settings"
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationItem.largeTitleDisplayMode = .automatic
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = UIView()
        tableView.sectionHeaderHeight = 30
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .lightGray
        tableView.register(SettingTableViewCell.self)
        tableView.register(headerFooter: SettingsFooterView.self)

        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupObservables() {
        viewModel.bind(cellTapped: tableView.rx.itemSelected.asObservable())
        
        viewModel.openURL$
            .subscribe(onNext: { [weak self] url in
                self?.open(url)
            })
            .disposed(by: viewModel.bag)

    }
    
    func open(_ url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
}
