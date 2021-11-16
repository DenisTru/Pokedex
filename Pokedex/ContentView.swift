//
//  ContentView.swift
//  Pokedex
//
//  Created by Denis Truong on 11/16/21.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @StateObject var pokemonVM = PokemonViewModel()
    var body: some View {
        NavigationView{
            List(pokemonVM.pokemon) { pokemon in
                NavigationLink(destination: DetailView(pokemon: pokemon)){
                    
                    //use opt+CMD and an '[' to move block of code up a line!
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
            }
            .navigationTitle("Pokemon")
        }

//no longer need to load data into a @State object, we moved it in the VM
//        .onAppear {
//            Task{
//                pokemon = try! await PokemonVM.getPokemon()
//            }
        
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
