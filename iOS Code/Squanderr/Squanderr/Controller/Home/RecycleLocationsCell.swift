//
//  RecycleLocationsCell.swift
//  Squanderr
//
//  Created by Rajat Nagavkar on 11/22/22.
//

import UIKit

class RecycleLocationCell: UITableViewCell {
    
    
    var info: SearchResult? {
        didSet{
            guard let name = info?.name else {return}
            recycleCompany.text = name
        }
    }
    
    var recycleCompany: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Hello"
        lbl.font = .systemFont(ofSize: 16)
        lbl.textColor = .black
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(recycleCompany)
        NSLayoutConstraint.activate([recycleCompany.topAnchor.constraint(equalTo: topAnchor, constant: 5),
                                     recycleCompany.leftAnchor.constraint(equalTo: leftAnchor, constant: 5)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
