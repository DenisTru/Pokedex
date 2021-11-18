//
//  StatView.swift
//  Pokedex
//
//  Created by Denis Truong on 11/16/21.
//

import SwiftUI

struct StatView: View {
    var pokemon: CDPokemon
    var statName: String
    var statColor: Color
    var statValue: Int
    
    
    var body: some View {
        HStack{
            Text(statName)
            //Using .monospaced ensures consistent text
                .font(.system(.body, design: .monospaced))
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(.gray)
                    .frame(width: 150, height: 20)
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(statColor)
                //ternary statement
                //Returns: if stat value is less than 100, take frame width and multiply that by stat value/100, otherwise Cover the width of the bar
                    .frame(width: statValue <= 100 ? 150
                           * (CGFloat(statValue) / 100): 150, height: 20)
            }
            Text("\(statValue)")
                .font(.system(.body, design: .monospaced))
        }
    }
}
//
//struct StatView_Previews: PreviewProvider {
//    static var previews: some View {
//        StatView(pokemon: PokemonViewModel().MOCK_POKEMON, statName: "Atk", statColor: .blue, statValue: 70)
//    }
//}
