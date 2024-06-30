//
//  TabBar.swift
//  Movies App
//
//  Created by Batuhan Berk Ertekin on 30.06.2024.
//

import SwiftUI

struct TabBar: View {
    var body: some View {

        TabView{
            HomeView().tabItem {
                
               Label("Home",systemImage: "house.fill")
                
            }
            
            TvView().tabItem {
                
                Label("Search",systemImage: "magnifyingglass")
                
            }
            
            PopularView().tabItem {
                
               Label("Movies",systemImage: "movieclapper")
                
            }
            
        }
    }
}

#Preview {
    TabBar()
}
