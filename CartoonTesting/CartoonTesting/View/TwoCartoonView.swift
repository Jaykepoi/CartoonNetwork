//
//  TwoCartoonView.swift
//  CartoonTest
//
//  Created by Mikhail Kim on 15.04.2022.
//

import Foundation
import UIKit

class TwoCartoonView: UIViewController {
    
    var id = 0
    
    @IBOutlet weak var Na: UILabel!
    @IBOutlet weak var St: UILabel!
    @IBOutlet weak var Loc: UILabel!
    @IBOutlet weak var Sp: UILabel!
    @IBOutlet weak var Ep: UILabel!
    @IBOutlet weak var Ge: UILabel!
    @IBOutlet var characterImage: CharacterImage! {
          didSet {
              characterImage.layer.cornerRadius = characterImage.frame.width / 2
          }
      }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        getHuman()
    }
    private func getHuman(){
        ApiData.shared.getDetailHuman(id: id, responce: {[weak self] characters, error in
            if error == nil {
                guard let character = characters else {return}
                self?.refresh(character: character)
            } else {
                print(error!.localizedDescription)
            }
        })
    }
    func refresh(character: apiCharacter){
        characterImage.apiImage(from: character.image)
        Na.text = "\(character.name)"
        Sp.text = "Species: \(character.species)"
        Ge.text = "Gender: \(character.gender)"
        St.text = "Status: \(character.status)"
        Loc.text = "Last location: \(character.location.name)"
        Ep.text = "Episode count: \(character.episode.count)"
    }

}
