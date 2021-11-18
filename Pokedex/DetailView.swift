//
//  DetailView.swift
//  Pokedex
//
//  Created by Denis Truong on 11/16/21.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    var pokemon: CDPokemon
    
    @State private var scale: CGFloat = 0
    
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Text(pokemon.unwrappedName.capitalized)
                    .font(.largeTitle)
                Text(pokemon.unwrappedType.capitalized)
                    .italic()
                    .foregroundColor(pokemon.typeColor)
                PokemonImage(image: KFImage(URL(string: pokemon.unwrappedImageURL)))
                    .padding(.bottom, -100)
                    .zIndex(1)
                
                ZStack{
                    Rectangle()
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: geo.size.width, height: geo.size.height)
                        .foregroundColor(pokemon.typeColor)
                    VStack{
                        if pokemon.isFavorite {
                            Label(
                                "Favorite", systemImage: "star.fill"
                            )
                                .foregroundColor(pokemon.typeColor)
                                .padding(5)
                                .background(Capsule())
                                .foregroundColor(.white)
                        }
                        //remove all new lines with empty space
                        Text(pokemon.unwrappedDescript.replacingOccurrences(of: "\n", with: ""))
                            .foregroundColor(.white)
                            .padding()
                        StatsViewGroup(pokemon: pokemon)
                    }
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
//
//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(pokemon: PokemonViewModel().MOCK_POKEMON)
//    }
//}
