//
//  FaqTableViewCell.swift
//  Squanderr
//
//  Created by Rajat Nagavkar on 11/23/22.
//

import UIKit

class FaqTableViewCell: UITableViewCell {
    
    var faqView: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .white
        vw.layer.cornerRadius = 20
        return vw
    }()
    
    var faqQuestion: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Questions"
        lbl.numberOfLines = 0
        lbl.textColor = .black
        lbl.font = .boldSystemFont(ofSize: 18)
        return lbl
    }()
    
    var answerlabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequa"
        lbl.font = .systemFont(ofSize: 16)
        lbl.textColor = .black
        lbl.numberOfLines = 0
        return lbl
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(faqView)
        NSLayoutConstraint.activate([faqView.topAnchor.constraint(equalTo: topAnchor,constant: 7),
                                     faqView.leftAnchor.constraint(equalTo: leftAnchor),
                                     faqView.rightAnchor.constraint(equalTo: rightAnchor),
                                     faqView.bottomAnchor.constraint(equalTo: bottomAnchor)])
        addSubview(faqQuestion)
        NSLayoutConstraint.activate([faqQuestion.topAnchor.constraint(equalTo: faqView.topAnchor, constant: 5),
                                     faqQuestion.leftAnchor.constraint(equalTo: faqView.leftAnchor, constant: 10),
                                     faqQuestion.rightAnchor.constraint(equalTo: faqView.rightAnchor,constant: -5)])
        
        addSubview(answerlabel)
        NSLayoutConstraint.activate([answerlabel.topAnchor.constraint(equalTo: faqQuestion.bottomAnchor,constant: 5),
                                     answerlabel.leftAnchor.constraint(equalTo: faqView.leftAnchor, constant: 10),
                                     answerlabel.rightAnchor.constraint(equalTo: faqView.rightAnchor, constant: -5)])
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
