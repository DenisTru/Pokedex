//
//  Pokemon+CoreDataClass.swift
//  Pokedex
//
//  Created by Denis Truong on 11/17/21.
//
//

import Foundation
import CoreData



@objc(CDPokemon)
public class CDPokemon: NSManagedObject {
    
    enum CodingKeys: String, CodingKey {
        case id
        case pokemonID
        case isFavorite
        case name
        case imageURL = "imageUrl"
        case type
        case description
        case attack
        case defense
        case height
        case weight
    }
    
    enum DecoderConfigurationError: Error {
        case missingManagedObjectContext
    }
    
    required public convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        self.init(context: context)
        
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int32.self, forKey: .id)
        self.pokemonID = try container.decode(UUID.self, forKey: .pokemonID)
        self.isFavorite = try container.decode(Bool.self, forKey: .isFavorite)
        self.name = try container.decode(String.self, forKey: .name)
        self.imageURL = try container.decode(String.self, forKey: .imageURL)
        self.type = try container.decode(String.self, forKey: .type)
        self.descript = try container.decode(String.self, forKey: .description)
        self.attack = try container.decode(Int32.self, forKey: .attack)
        self.defense = try container.decode(Int32.self, forKey: .defense)
        self.height = try container.decode(Int32.self, forKey: .height)
        self.weight = try container.decode(Int32.self, forKey: .weight)
        
        
    }
}
