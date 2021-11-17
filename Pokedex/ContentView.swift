//
//  ContentView.swift
//  Pokedex
//
//  Created by Denis Truong on 11/16/21.
//

import SwiftUI
import Kingfisher
import CoreData

struct ContentView: View {
    @StateObject var pokemonVM = PokemonViewModel()
    @State private var searchText = ""
    
    
    var filteredPokemon: [Pokemon] {
        if searchText == "" {return pokemonVM.pokemon}
        return pokemonVM.pokemon.filter{$0.name.lowercased().contains(searchText.lowercased())}
    }
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: CDPokemon.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \CDPokemon.name, ascending: true)]) var results: FetchedResults<CDPokemon>
    
    
    var body: some View {
        NavigationView{
            List {
                ForEach(filteredPokemon) { pokemon in
                    NavigationLink(destination: DetailView(pokemon: pokemon)){
                
                        //use opt+CMD and an '[' to move block of code up a line!
                        HStack{
                            VStack(alignment: .leading, spacing: 5){
                                HStack {
 
                                    Text(pokemon.name.capitalized)
                                        .font(.title)
                                    if pokemon.isFavorite {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                    }
                                }
                                
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
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(action: { addFavorite(pokemon: pokemon)}) {
                            Image(systemName: "star")
                        }
                        .tint(.yellow)
                    }
                }
                
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if self.moc.hasChanges {
                            try? self.moc.save()
                        }
                        
                        
                        do{
                            results.forEach{ pokemon in
                                moc.delete(pokemon)
                            }
                            try moc.save()
                        }catch{
                            print(error.localizedDescription)
                        }
                        
                        
                        pokemonVM.pokemon.removeAll()
                    }){
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationTitle(results.isEmpty ? "Fetched JSON": "Fetched CoreData")
            .searchable(text: $searchText)
            .task {
                if results.isEmpty {
                    do{
                        pokemonVM.pokemon = try await pokemonVM.getPokemon()
                        pokemonVM.saveData(context: moc)
                    } catch {
                        print("Error", error)
                    }
                } else {
                    results.forEach{ poke in
                        pokemonVM.pokemon.append(Pokemon(isFavorite: poke.isFavorite ,id: Int(poke.id), name: poke.unwrappedName, imageURL: poke.unwrappedImageURL, type: poke.wrappedType, description: poke.unwrappedDescript, attack: Int(poke.attack), defense: Int(poke.defense), height: Int(poke.height), weight: Int(poke.weight)))
                    }
                    
                }
 
            }
        }
        
        //no longer need to load data into a @State object, we moved it in the VM
        //        .onAppear {
        //            Task{
        //                pokemon = try! await PokemonVM.getPokemon()
        //            }
        
    }
    
    func addFavorite(pokemon: Pokemon) {
        if let index = pokemonVM.pokemon.firstIndex(where: { $0.id == pokemon.id } ) {
            pokemonVM.pokemon[index].isFavorite.toggle()
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
