//
//  SearchTableViewCell.swift
//  Squanderr
//
//  Created by Rajat Nagavkar on 9/22/22.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    var searchContentLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "H"
        lbl.font = .systemFont(ofSize: 16)
        return lbl
    }()
    
    var searchImageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.image = #imageLiteral(resourceName: "location")
        return img
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(searchImageView)
        NSLayoutConstraint.activate([searchImageView.topAnchor.constraint(equalTo: topAnchor,constant: 5),
                                     searchImageView.leftAnchor.constraint(equalTo: leftAnchor,constant: 30)
                                     ])
        
        
        addSubview(searchContentLabel)
        NSLayoutConstraint.activate([searchContentLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
                                     searchContentLabel.leftAnchor.constraint(equalTo: searchImageView.rightAnchor,constant: 10)])
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

