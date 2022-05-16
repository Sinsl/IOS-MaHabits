//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Mac Home on 06.05.2022.
//

import UIKit

protocol HabitDetailsViewControllerDelegate: class {
    func update(text: String)
}

class HabitDetailsViewController: UIViewController, HabitDetailsViewControllerDelegate {
    
    private var changeDetail: String? = nil {
        didSet {
            if changeDetail != nil {
                closeController()
            }
        }
    }
    
    weak var delegateHabits: HabitsViewController?
    var habit: Habit? = nil
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DetailsTableViewCell.self, forCellReuseIdentifier: DetailsTableViewCell.identifier)
        return tableView
    }()
    
    
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        return view
    }()
    
    private lazy var textHeader: UILabel = {
        let label  = UILabel()
        label.text = "Активность"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray2
        label.text = label.text?.uppercased()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .init(identifier: "ru_RU")
        formatter.dateStyle = .medium
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()
    
    private let datesRevers: [Date] = HabitsStore.shared.dates.reversed()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = habit?.name
        view.backgroundColor = .systemGray6
        navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.tintColor = AppColor(color: .purple)
        let edit = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(openEdit))
        navigationItem.rightBarButtonItem = edit
        setLayout()
    }
    
    @objc func openEdit() {
        let habitViewController = HabitViewController()
        let habitNavContr = UINavigationController (rootViewController: habitViewController)
        habitViewController.title = "Править"
        habitViewController.habit = self.habit
        habitViewController.delegateDetail = self
        present(habitNavContr, animated: true, completion: nil)
    }
    
    func update(text: String) {
        changeDetail = text
    }
    
    func closeController() {
        changeDetail = nil
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setLayout() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        headerView.addSubview(textHeader)
        
        NSLayoutConstraint.activate([
            textHeader.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 22),
            textHeader.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            textHeader.trailingAnchor.constraint(equalTo: headerView.trailingAnchor,constant: -16)
        ])
    }
}

extension HabitDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.identifier, for: indexPath) as! DetailsTableViewCell
        let date = datesRevers[indexPath.row]
        let textDate = dateFormatter.string(from: date)
        let isTracking = HabitsStore.shared.habit(habit!, isTrackedIn: date)
        cell.settingValues(textDate, isTracking)
        return cell
    }
}
extension HabitDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
