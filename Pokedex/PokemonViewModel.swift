//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by Denis Truong on 11/16/21.
//

import Foundation
import SwiftUI


class PokemonViewModel: ObservableObject {
    
    @Published var pokemon = [Pokemon]()
    
    init(){
        
//        Task {
//            pokemon = try await getPokemon()
//        }
        
    }
    
    func getPokemon() async throws -> [Pokemon] {
        guard let url = URL(string: "https://pokedex-bb36f.firebaseio.com/pokemon.json")
        else {throw FetchError.badURL}
        
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {throw FetchError.badResponse}
        guard let data = data.removeNullsFrom(string: "null,") else {throw FetchError.badData}
        
        let maybePokemonData = try JSONDecoder().decode([Pokemon].self, from: data)
        return maybePokemonData
    }
    
    
    let MOCK_POKEMON = Pokemon(id: 0, name: "Kakuna", imageURL: "https://firebasestorage.googleapis.com/v0/b/pokedex-bb36f.appspot.com/o/pokemon_images%2FF4B3A60B-7DA9-4572-AE0B-EA929F80CE5A?alt=media&token=9e61759c-4ba6-4d73-9784-6fad5a973618", type: "Flying", description: "Protective of sprawling territorial area", attack: 60, defense: 55, height: 6, weight: 100)
    
}
