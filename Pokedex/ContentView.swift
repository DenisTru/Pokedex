//
//  ContentView.swift
//  Pokedex
//
//  Created by Denis Truong on 11/16/21.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    var pokemonModel = PokemonViewModel()
    @State private var pokemon = [Pokemon]()
    var body: some View {
        NavigationView{
            List(pokemon) { pokemon in
                HStack{
                    VStack(alignment: .leading, spacing: 5){
                        Text(pokemon.name.capitalized)
                            .font(.title)
                            
                        HStack {
                            Text(pokemon.type.capitalized)
                                .italic()
                            Circle()
                                .foregroundColor(pokemon.typeColor)
                                .frame(width: 10, height: 10)
                        }
                        Text(pokemon.description)
                            .font(.caption)
                            .lineLimit(2)
                    }
                    Spacer()
                    KFImage(URL(string: pokemon.imageURL))
                        .interpolation(.none)
                        .resizable()
                        .frame(width:100, height: 100)
                }
            }
            .navigationTitle("Pokemon")
        }
        
        .onAppear {
            Task{
                pokemon = try! await pokemonModel.getPokemon()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//practice with AsyncImage
//AsyncImage(url: URL(string: pokemon.imageURL)) { phase in
//    switch phase {
//    case .empty:
//        ProgressView()
//    case.success(let image):
//        image.resizable()
//            .interpolation(.none)
//            .scaledToFit()
//            .frame(width: 100, height: 100)
//    case .failure:
//        Image(systemName: "plus")
//    @unknown default:
//        EmptyView()
//    }
//}
