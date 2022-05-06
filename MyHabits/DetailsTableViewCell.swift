//
//  DetailsTableViewCell.swift
//  MyHabits
//
//  Created by Mac Home on 06.05.2022.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {

    lazy var baseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        return view
    }()
    
    lazy var labelDate: UILabel = {
        let label  = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imageChecken: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .white
        image.tintColor = .black
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
        [labelDate, imageChecken].forEach{baseView.addSubview($0)}
        NSLayoutConstraint.activate([
            labelDate.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 10),
            labelDate.trailingAnchor.constraint(equalTo: imageChecken.leadingAnchor, constant: -25),
            labelDate.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 16),
            labelDate.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            imageChecken.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 15),
            imageChecken.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -20),
            imageChecken.heightAnchor.constraint(equalToConstant: 20),
            imageChecken.widthAnchor.constraint(equalToConstant: 20)
        ])
    }

    func settingValues(_ date: String, _ isTracking: Bool){
        labelDate.text = date
        if isTracking {imageChecken.image = UIImage(systemName: "checkmark")}
    }

}
