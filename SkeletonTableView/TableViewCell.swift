//
//  TableViewCell.swift
//  SkeletonTableView
//
//  Created by Aleksei Tsyss on 7/9/21.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupViews()
        setupLayers()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayers() {
        [
            SkeletonLayer(frame: CGRect(x: 24, y: 40, width: 64, height: 24), cornerRadius: 12),
            SkeletonLayer(frame: CGRect(x: 112, y: 20, width: 48, height: 16)),
            SkeletonLayer(frame: CGRect(x: 112, y: 52, width: 160, height: 8)),
            SkeletonLayer(frame: CGRect(x: 112, y: 76, width: 88, height: 8))
        ].forEach {
            contentView.layer.addSublayer($0)
            $0.startAnimating()
        }
    }
    
    private func setupViews() {
        // StackView 1
        let sv1 = UIStackView()
        sv1.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(sv1)
        
        let bottom = sv1.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        bottom.priority = UILayoutPriority(999)
        
        NSLayoutConstraint.activate([
            sv1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            sv1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            sv1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            bottom
        ])
        
        sv1.axis = .horizontal
        sv1.spacing = 24
        sv1.alignment = .center
        
        // View 1
        let v1 = SkeletonView()
        v1.translatesAutoresizingMaskIntoConstraints = false
        v1.layer.cornerRadius = 12
        v1.clipsToBounds = true
        v1.backgroundColor = .lightGray
        
        sv1.addArrangedSubview(v1)

        NSLayoutConstraint.activate([
            v1.widthAnchor.constraint(equalToConstant: 64),
            v1.heightAnchor.constraint(equalToConstant: 24),
        ])
        
        // StackView 2
        let sv2 = UIStackView()
        sv1.addArrangedSubview(sv2)
        sv2.axis = .vertical
        sv2.spacing = 16
        sv2.alignment = .leading
        
        // View 2
        let v2 = SkeletonView()
        v2.backgroundColor = .lightGray
        
        NSLayoutConstraint.activate([
            v2.widthAnchor.constraint(equalToConstant: 48),
            v2.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        sv2.addArrangedSubview(v2)
        
        // View 3
        let v3 = SkeletonView()
        v3.backgroundColor = .lightGray
        
        NSLayoutConstraint.activate([
            v3.widthAnchor.constraint(equalToConstant: 160),
            v3.heightAnchor.constraint(equalToConstant: 8)
        ])
        
        sv2.addArrangedSubview(v3)
        
        // View 4
        let v4 = SkeletonView()
        v4.backgroundColor = .lightGray
        
        NSLayoutConstraint.activate([
            v4.widthAnchor.constraint(equalToConstant: 88),
            v4.heightAnchor.constraint(equalToConstant: 8)
        ])
        
        sv2.addArrangedSubview(v4)
        
        layoutIfNeeded()

        [v1, v2, v3, v4].forEach { $0.startAnimating() }
    }
}
