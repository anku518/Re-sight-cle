//
//  StatsTableViewCell.swift
//  Squanderr
//
//  Created by Rajat Nagavkar on 12/12/22.
//

import UIKit

class StatsTableViewCell: UITableViewCell {
    
    var stats: RecycleInfo? {
        didSet {
            guard let company = stats?.company else {return}
            recycleCompany.text = company
            
            guard let item = stats?.recycledItem else {return}
            ItemDetailLabel.text = item
            
            guard let date = stats?.date else {return}
            dateLabel.text = date
        }
    }
    
    
    var recycleCompany: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Hello1"
        lbl.font = .boldSystemFont(ofSize: 18)
        lbl.textColor = .black
        return lbl
    }()
    
    var ItemLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Item:"
        lbl.font = .systemFont(ofSize: 16)
        lbl.textColor = .black
        return lbl
    }()
    
    var ItemDetailLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Plastic"
        lbl.font = .systemFont(ofSize: 16)
        lbl.textColor = .black
        return lbl
    }()
    
    var dateLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "12-22-2022"
        lbl.font = .systemFont(ofSize: 16)
        lbl.textColor = .black
        return lbl
    }()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(recycleCompany)
        NSLayoutConstraint.activate([recycleCompany.topAnchor.constraint(equalTo: topAnchor, constant: 5),
                                     recycleCompany.leftAnchor.constraint(equalTo: leftAnchor, constant: 5)])
        
        addSubview(ItemLabel)
        NSLayoutConstraint.activate([ItemLabel.topAnchor.constraint(equalTo: recycleCompany.bottomAnchor, constant: 5),ItemLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5)])
        
        addSubview(ItemDetailLabel)
        NSLayoutConstraint.activate([ItemDetailLabel.topAnchor.constraint(equalTo: recycleCompany.bottomAnchor, constant: 5),
                                     ItemDetailLabel.leftAnchor.constraint(equalTo: ItemLabel.rightAnchor, constant: 3)])
        addSubview(dateLabel)
        NSLayoutConstraint.activate([dateLabel.topAnchor.constraint(equalTo: recycleCompany.bottomAnchor, constant: 5),
                                     dateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
