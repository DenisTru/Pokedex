//
//  StatsViewGroup.swift
//  Pokedex
//
//  Created by Denis Truong on 11/16/21.
//

import SwiftUI

struct StatsViewGroup: View {
    var pokemon: CDPokemon
    
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: 300, height: 300)
                .foregroundColor(.white)
                .opacity(0.6)
                .cornerRadius(20)
            VStack(alignment: .leading, spacing: 30) {
                StatView(pokemon: pokemon, statName: "Atk", statColor: .blue, statValue: Int(pokemon.attack))
                StatView(pokemon: pokemon, statName: "Def", statColor: .red, statValue: Int(pokemon.defense))
                StatView(pokemon: pokemon, statName: "Hgt", statColor: .teal, statValue: Int(pokemon.height))
                StatView(pokemon: pokemon, statName: "Wgt", statColor: .cyan, statValue: Int(pokemon.weight))
            }
        }
    }
}

//struct StatsViewGroup_Previews: PreviewProvider {
//    static var previews: some View {
//        @Environment(\.managedObjectContext) var moc
//        StatsViewGroup(pokemon: CDPokemon(entity: CDPokemon.entity(), insertInto: moc))
//        StatsViewGroup(pokemon: PokemonViewModel().MOCK_POKEMON)
//    }
//}
