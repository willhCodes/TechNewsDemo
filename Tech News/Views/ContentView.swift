//
//  ContentView.swift
//  Tech News
//
//  Created by willhcodes on 6/27/23.
//

import SwiftUI


struct ContentView: View {
    
    @ObservedObject var networkManager = NetworkManager() // Subscribing to observable NetworkManager
    
    var body: some View {
        
        NavigationView {
            List(networkManager.hitposts) { post in
                NavigationLink(destination: DetailView(url: post.url)) {
                    
                    HStack{
                        Text("\(post.num_comments)")
                        Text(post.title)
                    }
                }
                
            }
            
            .navigationBarTitle ("Tech News")
        }
        .onAppear {
            networkManager.fetch()
            // triggers upon load
        }
        
    }
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

