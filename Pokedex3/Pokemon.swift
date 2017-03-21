//
//  Pokemon.swift
//  Pokedex3
//
//  Created by COMP on 10/03/17.
//  Copyright © 2017 Bhart. All rights reserved.
//

import Foundation
import Alamofire
class Pokemon{
    var _name: String!
    var _pokemonId: String!
    var _mainImg: String!
    var _disc: String!
    var _type: String!
    var _weight: String!
    var _attack: String!
    var _defence: String!
    var _nxtEvo: String!
    var _nextEvoImg: String!
    var _pokeUrl: String!
   
    var nextEvoImg:String{
        if _nextEvoImg == nil{
            return ""
        }
        return _nextEvoImg
    }
    var nxtEvo:String{
        if _nxtEvo == nil{
            return ""
        }
        return _nxtEvo
    }
    var defence:String{
        if _defence == nil{
            return ""
        }
        return _defence
    }
    var attack:String{
        if _attack == nil{
            return ""
        }
        return _attack
    }
    var weight:String{
        if _weight == nil{
            return ""
        }
        return _weight
    }
    var type:String{
        if _type == nil{
            return ""
        }
        return _type
    }
    var disc:String{
        if _disc == nil{
            return ""
        }
        return _disc
    }
    var name:String{
        return _name
    }
    
    var pokemonId:String{
        return _pokemonId
    }
    
    init(name: String, pokemonId: String) {
        _name = name
        _pokemonId = pokemonId
        _pokeUrl = "\(Api_Url)\(pokemonId)"
        
    }
    
    func getDataFromApi(completed: @escaping DownloadCompleted){
        Alamofire.request(_pokeUrl).responseJSON { (response) in
            let result = response.result.value
            if let dict = result as? Dictionary<String, Any>{
                if let att = dict["attack"] as? Int{
                    self._attack = "\(att)"
                    print(self.attack)
                    
                }
                if let weght = dict["weight"] as? String{
                    self._weight = weght
                    print(self.weight)
                }
                if let def = dict["defense"] as? Int{
                    self._defence = "\(def)"
                }
                if let typ = dict["types"] as? [Dictionary<String,Any>]{
                    if let typee = typ[0]["name"] as?String{
                        self._type = typee.capitalized
                    }
                }
                if let evo = dict["evolutions"] as? [ Dictionary<String,Any>]{
                    if let nxtEvo = evo[0]["to"] as? String{
                        self._nxtEvo = nxtEvo.capitalized
                    }
                    if let nextEvoIm = evo[0]["resource_uri"] as? String{
                        let ur = nextEvoIm.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                        let newUr = ur.replacingOccurrences(of: "/", with: "")
                        self._nextEvoImg = newUr
                    }
                }
                if let des = dict["descriptions"] as? [Dictionary<String, Any>]{
                    if let des_url = des[0]["resource_uri"] as? String{
                        let newApiUrl = "\(Base_Url)\(des_url)"
                        Alamofire.request(newApiUrl).responseJSON (completionHandler:{ (response) in
                            if let jso = response.result.value as? Dictionary<String, Any>{
                                if let desc = jso["description"] as? String{
                                    self._disc = desc
                                    print(self.disc)
                                }
                            }
                            
                            
                            
                         completed()
                        })
                        
                    }
                }
                
            }
            completed()
        }
        
    }
}


















