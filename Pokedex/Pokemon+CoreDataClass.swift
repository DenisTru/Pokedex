//
//  Pokemon+CoreDataClass.swift
//  Pokedex
//
//  Created by Denis Truong on 11/17/21.
//
//

import Foundation
import CoreData
import SwiftUI


@objc(CDPokemon)
public class CDPokemon: NSManagedObject, Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageURL = "imageUrl"
        case type
        case descript = "description"
        case attack
        case defense
        case height
        case weight
    }

    enum DecoderConfigurationError: Error {
        case missingManagedObjectContext
        case missingEntity
    }
    
    required public convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "CDPokemon", in: context) else {
         throw DecoderConfigurationError.missingEntity
        }
        self.init(entity: entity, insertInto: context)
        
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
//          self.pokemonID = UUID()
        self.attack = try container.decode(Int32.self, forKey: .attack)
        self.defense = try container.decode(Int32.self, forKey: .defense)
        self.id = try container.decode(Int32.self, forKey: .id)
        self.isFavorite = false
        self.name = try container.decode(String.self, forKey: .name)
        self.imageURL = try container.decode(String.self, forKey: .imageURL)
        self.type = try container.decode(String.self, forKey: .type)
        self.descript = try container.decode(String.self, forKey: .descript)
        self.height = try container.decode(Int32.self, forKey: .height)
        self.weight = try container.decode(Int32.self, forKey: .weight)
        self.color = UIColor.encode(UIColor(typeColor))()
     
        
        print(attack)
    }
}

