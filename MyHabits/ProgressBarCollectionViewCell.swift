//
//  ProgressBarCollectionViewCell.swift
//  MyHabits
//
//  Created by Mac Home on 06.05.2022.
//

import UIKit

class ProgressBarCollectionViewCell: UICollectionViewCell {
    
    private lazy var baseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        return view
    }()
    
    private let labelSlogan: UILabel = {
        let label  = UILabel()
        label.text = "Все получится!"
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelProgress: UILabel = {
        let label  = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.progressTintColor = AppColor(color: .purple)
        view.progressViewStyle = .bar
        view.trackTintColor = .systemGray2
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        
        [labelSlogan, labelProgress, progressView].forEach{baseView.addSubview($0)}
        NSLayoutConstraint.activate([
            labelSlogan.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 10),
            labelSlogan.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 12)
        ])
        
        NSLayoutConstraint.activate([
            labelProgress.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 10),
            labelProgress.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 12),
            progressView.topAnchor.constraint(equalTo: labelSlogan.bottomAnchor, constant: 8),
            progressView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -12),
            progressView.heightAnchor.constraint(equalToConstant: 7)
        ])
        
    }
    
    func setupCell(_ valueProgress: Float){
        labelProgress.text = "\(Int(valueProgress * 100))%"
        progressView.setProgress(valueProgress, animated: true)
    }
}

