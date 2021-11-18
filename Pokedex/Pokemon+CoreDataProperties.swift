//
//  Pokemon+CoreDataProperties.swift
//  Pokedex
//
//  Created by Denis Truong on 11/17/21.
//
//

import Foundation
import CoreData
import UIKit
import SwiftUI

extension CDPokemon {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPokemon> {
        return NSFetchRequest<CDPokemon>(entityName: "Pokemon")
    }

    @NSManaged public var attack: Int32
    @NSManaged public var color: Data?
    public var unwrappedColor: Data {
        
        color ?? Data.init()
    }
    @NSManaged public var defense: Int32
    @NSManaged public var descript: String?
    public var unwrappedDescript: String {
        descript ?? "N/A"
    }
    @NSManaged public var height: Int32
    @NSManaged public var id: Int32
    @NSManaged public var imageURL: String?
    public var unwrappedImageURL: String {
        imageURL ?? "No Image"
    }
    @NSManaged public var isFavorite: Bool
    @NSManaged public var name: String?
    public var unwrappedName: String {
        name ?? "No Name"
    }
    @NSManaged public var pokemonID: UUID?
    public var unwrappedUUID: UUID {
        pokemonID ?? UUID()
    }
    @NSManaged public var type: String?
    public var unwrappedType: String {
        type ?? "???"
    }
    @NSManaged public var weight: Int32
    
    var typeColor: Color {
            switch type {
            case "fire":
                return Color(.systemRed)
            case "poison":
                return Color(.systemGreen)
            case "water":
                return Color(.systemTeal)
            case "electric":
                return Color(.systemYellow)
            case "psychic":
                return Color(.systemPurple)
            case "normal":
                return Color(.systemOrange)
            case "ground":
                return Color(.systemBrown)
            case "flying":
                return Color(.systemBlue)
            case "fairy":
                return Color(.systemPink)
            default:
                return Color(.systemIndigo)
            }
        }
}

extension CDPokemon : Identifiable {

}
