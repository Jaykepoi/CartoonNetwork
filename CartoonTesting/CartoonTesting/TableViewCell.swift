//
//  TableViewCell.swift
//  CartoonTest
//
//  Created by Mikhail Kim on 15.04.2022.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var characterImage: CharacterImage! {
        didSet {
            characterImage.contentMode = .scaleAspectFit
            characterImage.clipsToBounds = true
            characterImage.layer.cornerRadius = characterImage.frame.height / 2
            characterImage.backgroundColor = .white
        }
    }
    @IBOutlet weak var oneLabel: UILabel!
    
    func configure(with character: Result) {
        oneLabel.text = character.name
        characterImage.apiImage(from: character.image)
    }

}
