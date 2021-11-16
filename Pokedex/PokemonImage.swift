//
//  PokemonImage.swift
//  Pokedex
//
//  Created by Denis Truong on 11/16/21.
//

import SwiftUI
import Kingfisher

struct PokemonImage: View {
    var image: KFImage
    
    var body: some View {
      image
            .resizable()
            .scaledToFill()
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 5))
            .background(Circle().foregroundColor(.white))
            .shadow(radius: 8)
    }
}

struct PokemonImage_Previews: PreviewProvider {
    static var previews: some View {
        PokemonImage(image: KFImage(URL(string: PokemonViewModel().MOCK_POKEMON.imageURL)))
    }
}
