//
//  PokemonDetailsVC.swift
//  Pokedex3
//
//  Created by COMP on 14/03/17.
//  Copyright © 2017 Bhart. All rights reserved.
//

import UIKit

class PokemonDetailsVC: UIViewController {

    @IBOutlet weak var pokNameLbl: UILabel!
    @IBOutlet weak var pokMainImageLbl: UIImageView!
    
    @IBOutlet weak var discLbl: UILabel!
    
    @IBOutlet weak var typeLbl: UILabel!
    
    @IBOutlet weak var nextEvoLbl: UILabel!
    @IBOutlet weak var nextEvoImgLbl: UIImageView!
    @IBOutlet weak var currentEvoImgLbl: UIImageView!
    @IBOutlet weak var pokIdLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var defenceLbl: UILabel!
    
    @IBOutlet weak var speedLbl: UILabel!
    var pokemon : Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokMainImageLbl.image = UIImage(named: "\(pokemon.pokemonId)")
        pokNameLbl.text = pokemon.name.capitalized
        currentEvoImgLbl.image = UIImage(named: "\(pokemon.pokemonId)")
        
        pokemon.getDataFromApi {
            print("Did arrive here")
            self.attackLbl.text = self.pokemon.attack
            self.defenceLbl.text = self.pokemon.defence
            self.weightLbl.text = self.pokemon.weight
            self.discLbl.text = self.pokemon.disc
            self.typeLbl.text = self.pokemon.type
            self.nextEvoLbl.text = self.pokemon.nxtEvo
            self.nextEvoImgLbl.image = UIImage(named: self.pokemon.nextEvoImg)
           
            
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
