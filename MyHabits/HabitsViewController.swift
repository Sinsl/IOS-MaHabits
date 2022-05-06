//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Mac Home on 06.05.2022.
//

import UIKit

protocol HabitsViewControllerDelegate: class {
    func update(text: String)
}

class HabitsViewController: UIViewController, HabitsViewControllerDelegate {
    
    var changeHabits: String? = nil {
        didSet {
            if changeHabits != nil {
                self.reloadCollection()
            }
        }
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        view.dataSource = self
        view.delegate = self
        view.register(HabitsCollectionViewCell.self, forCellWithReuseIdentifier: "HabitsCollectionViewCell")
        view.register(ProgressBarCollectionViewCell.self, forCellWithReuseIdentifier: "ProgressBarCollectionViewCell")
        return view
    }()
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Сегодня"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemGray6
        let info = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(openInfo))
        navigationItem.rightBarButtonItem = info
        setLayout()
        
        
    }
    
    @objc func openInfo() {
//        let habitViewController = HabitViewController()
//        let habitNavContr = UINavigationController (rootViewController: habitViewController)
//        habitViewController.title = "Создать"
//        habitViewController.delegateHabits = self
//        present(habitNavContr, animated: true, completion: nil)
    }
    
    func setLayout() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
    
    public func reloadCollection() {
        self.collectionView.reloadData()
        changeHabits = nil
    }
    
    @objc func buttonPress(sender:UIButton) {
        if !HabitsStore.shared.habits[sender.tag].isAlreadyTakenToday {
        sender.backgroundColor = HabitsStore.shared.habits[sender.tag].color
        HabitsStore.shared.track(HabitsStore.shared.habits[sender.tag])
        collectionView.reloadData()
        }
    }
    
    func update(text: String) {
        changeHabits = text
    }
}

extension HabitsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {return 1}
        if section == 1 {return HabitsStore.shared.habits.count}
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProgressBarCollectionViewCell", for: indexPath) as! ProgressBarCollectionViewCell
            let todayProgress =  HabitsStore.shared.todayProgress
            cell.setupCell(todayProgress)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HabitsCollectionViewCell", for: indexPath) as! HabitsCollectionViewCell
            let title: String = HabitsStore.shared.habits[indexPath.item].name
            let time: String = HabitsStore.shared.habits[indexPath.item].dateString
            let counter: String = "Счетчик: \(String(HabitsStore.shared.habits[indexPath.item].trackDates.count))"
            let color: UIColor = HabitsStore.shared.habits[indexPath.item].color
            let checked = HabitsStore.shared.habits[indexPath.item].isAlreadyTakenToday
            cell.setupCell(title, time, counter, color, checked)
            cell.buttonCheck.tag = indexPath.item
            cell.buttonCheck.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1{
//            let habitDetailsViewController = HabitDetailsViewController()
//            habitDetailsViewController.habit = HabitsStore.shared.habits[indexPath.item]
//            self.navigationController?.pushViewController(habitDetailsViewController, animated: false)
        }
    }
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    private var sideInset: CGFloat {return 16}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - sideInset * 2) / 1
        if indexPath.section == 0 {
            return CGSize(width: width, height: 60)
        } else {
            return CGSize(width: width, height: 130)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {sideInset}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
    }
}
