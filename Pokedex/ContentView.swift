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
    
    //need to fix, does not show pokemon ascending right away, we need UI to react and sort right away
    
    var filteredPokemon: [CDPokemon] {
        if searchText == "" {return results.sorted{ $0.unwrappedName < $1.unwrappedName} }
       return
        results.filter{$0.unwrappedName.lowercased().contains(searchText.lowercased())}
    
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

                                    Text(pokemon.unwrappedName.capitalized)
                                        .font(.title)
                                    if pokemon.isFavorite {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                    }
                                }

                                HStack {
                                    Text(pokemon.unwrappedType.capitalized)
                                        .italic()
                                    Circle()
                                        .foregroundColor(pokemon.typeColor)
                                        .frame(width: 10, height: 10)
                                }
                                Text(pokemon.unwrappedDescript)
                                    .font(.caption)
                                    .lineLimit(2)
                            }
                            Spacer()
                            KFImage(URL(string: pokemon.unwrappedImageURL))
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
                        //since we are not directly interacting with CoreData and we are displaying data off the @published array
                        //we have to delete the stored data and repopulate with noew values from @published array --workaround--
                        //unable to directly work with coredata because CDPokemon and Pokemon conflict, so we are appending @published with CDPokemon Values
                        
//                            results.forEach{ pokemon in
//                                moc.delete(pokemon)
//                            }
//                            pokemonVM.saveData(context: moc)
                         
                        
                        
                        if self.moc.hasChanges {
                            try? self.moc.save()
                        } else{
                            print("nothing to save")
                        }
                    }){
                        Text("Save Changes")
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        do{
                            results.forEach{ pokemon in
                                moc.delete(pokemon)
                            }
//                            pokemonVM.pokemon.removeAll()
                            try moc.save()
                        }catch{
                            print(error.localizedDescription)
                        }
                        
                    }) {
                        Text("Delete Persistent Data")
                    }
                }
            }
            .navigationTitle(results.isEmpty ? "Fetched JSON": "Fetched CoreData")
            .searchable(text: $searchText)
            .task {
                print(results)
                //if core data empty than load JSON() & save to context
    //else load results table ``````````!@@@@@@!@!@
                if results.isEmpty {
                    do{
                     try await pokemonVM.getPokemon(moc: moc)
                        
                    } catch {
                        print("Error", error)
                    }
                } else {
                    
                    }
                    
                
                
            }
        }
        
        //no longer need to load data into a @State object, we moved it in the VM
        //        .onAppear {
        //            Task{
        //                pokemon = try! await PokemonVM.getPokemon()
        //            }
        
    }
    
    func addFavorite(pokemon: CDPokemon) {
        if let index = results.firstIndex(where: { $0.id == pokemon.id } ) {
            results[index].isFavorite.toggle()
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
