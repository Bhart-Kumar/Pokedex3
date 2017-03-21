//
//  PokeCollectionViewCell.swift
//  Pokedex3
//
//  Created by COMP on 10/03/17.
//  Copyright © 2017 Bhart. All rights reserved.
//

import UIKit

class PokeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pokeCellLabel: UILabel!
    @IBOutlet weak var pokeImage: UIImageView!
    
    var pokemon:Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
        
    }
    
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        
        pokeCellLabel.text = self.pokemon.name.capitalized
        pokeImage.image = UIImage(named: "\(self.pokemon.pokemonId)")
        
    }
    
}
