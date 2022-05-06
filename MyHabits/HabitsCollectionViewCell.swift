//
//  HabitsCollectionViewCell.swift
//  MyHabits
//
//  Created by Mac Home on 06.05.2022.
//

import UIKit

class HabitsCollectionViewCell: UICollectionViewCell {
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        return view
    }()

    var buttonCheck: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .white
        button.backgroundColor = .white
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let labelNameHabit: UILabel = {
        let label  = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    private let labelTextTime: UILabel = {
        let label  = UILabel()
        label.text = "Каждый день в 7:30"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelCounter: UILabel = {
        let label  = UILabel()
        label.text = "Счетчик: 4"
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        contentView.addSubview(baseView)
        
        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: contentView.topAnchor),
            baseView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            baseView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            baseView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        [buttonCheck, labelNameHabit, labelTextTime, labelCounter].forEach{baseView.addSubview($0)}
        NSLayoutConstraint.activate([
            buttonCheck.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 46),
            buttonCheck.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -25),
            buttonCheck.widthAnchor.constraint(equalToConstant: 40),
            buttonCheck.heightAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            labelNameHabit.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 20),
            labelNameHabit.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 20),
//            labelNameHabit.trailingAnchor.constraint(equalTo: checkedView.leadingAnchor, constant: -40)
            labelNameHabit.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -100)
        ])
        NSLayoutConstraint.activate([
            labelTextTime.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 20),
            labelTextTime.topAnchor.constraint(equalTo: labelNameHabit.bottomAnchor, constant: 8),
//            labelTextTime.trailingAnchor.constraint(equalTo: checkedView.leadingAnchor, constant: -40)
            labelTextTime.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -100)
        ])
        NSLayoutConstraint.activate([
            labelCounter.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 20),
            labelCounter.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: -20),
            labelCounter.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -40)
        ])
    }
    
    func setupCell(_ title: String, _ time: String, _ counter: String, _ color: UIColor, _ checked: Bool){
            labelNameHabit.text = title
            labelNameHabit.textColor = color
            labelTextTime.text = time
            labelCounter.text = counter
        buttonCheck.layer.borderColor = color.cgColor
        if checked {
            buttonCheck.layer.borderColor = color.cgColor
            buttonCheck.backgroundColor = color
        } else {
            buttonCheck.layer.borderColor = color.cgColor
            buttonCheck.backgroundColor = .white
        }
    }
    
    
}
