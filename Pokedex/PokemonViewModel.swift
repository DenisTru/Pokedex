//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by Denis Truong on 11/16/21.
//

import Foundation
import SwiftUI
import CoreData

class PokemonViewModel: ObservableObject {
    
    @Published var pokemon = [Pokemon]()
    
    
    
    //save JSON to CoreData
    func saveData(context: NSManagedObjectContext) {
        pokemon.forEach{ (data) in
            let colorTypeTransformable = UIColor(data.typeColor).encode()
            let entity = CDPokemon(context: context)
            entity.attack = Int32(data.attack)
            entity.color = colorTypeTransformable
            entity.defense = Int32(data.defense)
            entity.descript = data.description
            entity.height = Int32(data.height)
            entity.id = Int32(data.id)
            entity.imageURL = data.imageURL
            entity.isFavorite = data.isFavorite
            entity.name = data.name
            entity.pokemonID = data.pokemonID
            entity.type = data.type
            entity.weight = Int32(data.weight)
        }
        do{
            try context.save()
            print("Success")
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    
    init(){
        
//        Task {
//            pokemon = try await getPokemon()
//        }
        
    }
    
    func getPokemon(moc: NSManagedObjectContext) async throws {
        guard let url = URL(string: "https://pokedex-bb36f.firebaseio.com/pokemon.json")
        else {throw FetchError.badURL}
        
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {throw FetchError.badResponse}
        guard let data = data.removeNullsFrom(string: "null,") else {throw FetchError.badData}
        
        let decoder = JSONDecoder()
        decoder.userInfo[CodingUserInfoKey.managedObjectContext] = moc
        
        if( try? decoder.decode([CDPokemon].self, from: data)) != nil {
            print("decoded ?")
            if moc.hasChanges {
                try? moc.save()
            }
        }
 
        return
    }
    
    
    let MOCK_POKEMON = Pokemon(id: 0, name: "Kakuna", imageURL: "https://firebasestorage.googleapis.com/v0/b/pokedex-bb36f.appspot.com/o/pokemon_images%2FF4B3A60B-7DA9-4572-AE0B-EA929F80CE5A?alt=media&token=9e61759c-4ba6-4d73-9784-6fad5a973618", type: "Flying", description: "Protective of sprawling territorial area", attack: 60, defense: 55, height: 6, weight: 100)
    
}
