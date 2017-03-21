//
//  ViewController.swift
//  Pokedex3
//
//  Created by COMP on 10/03/17.
//  Copyright © 2017 Bhart. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout, UISearchBarDelegate{

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    var pokemon = [Pokemon]()
     var filteredPokemon = [Pokemon]()
     var inSearchMode = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done

        parseCSV()
    }
    func parseCSV(){
          let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                let pokeId = row["id"]!
                let name = row["identifier"]!
                let poke = Pokemon(name: name, pokemonId: pokeId)
                pokemon.append(poke)
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var poke: Pokemon!
        
        if inSearchMode {
            poke = filteredPokemon[indexPath.row]
        } else {
            poke = pokemon[indexPath.row]
        }
        
        performSegue(withIdentifier: "pokemonDetailVC", sender: poke)
       
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokemonCell", for: indexPath) as? PokeCollectionViewCell{
            
            let poke : Pokemon!
            
            if inSearchMode {
                poke = filteredPokemon[indexPath.row]
            } else {
                poke = pokemon[indexPath.row]
            }
            
            
            cell.configureCell( pokemon: poke)
            return cell
        }else{
            return UICollectionViewCell()
        }
        
       
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPokemon.count
        }
        
        return pokemon.count
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pokemonDetailVC" {
            if let detailsVC = segue.destination as? PokemonDetailsVC{
                if let poke = sender as? Pokemon{
                    detailsVC.pokemon = poke
                }
            }
        }
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
         view.endEditing(true)
    }
  
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            collectionView.reloadData()
        } else {
            inSearchMode = true
            let lower = searchBar.text!.lowercased()
            
            filteredPokemon = pokemon.filter({$0.name.range(of: lower) != nil})
            collectionView.reloadData()
        }
    }

}

