//
//  ContentView.swift
//  FirstLessonOtus
//
//  Created by Влад Калаев on 16.01.2021.
//

import SwiftUI

struct ContentView: View {
    
    // Appearance
    init() {
        UITabBar.appearance().barTintColor = UIColor.lightGray
    }
    
    @State private var tabSelection = 1
    @State private var cellSelector = 0

    var body: some View {
        
        TabView(selection: $tabSelection) {
            
            HomeScreen(tabSelection: $tabSelection).tabItem {
                Image(systemName: "paperplane.circle.fill")
                Text("Home")
            }.tag(0)
            ListScreen(tabSelection: $tabSelection, selectionCell: $cellSelector).tabItem {
                Image(systemName: "list.bullet.rectangle")
                Text("List")
            }.tag(1)
            ModalScreen(tabSelection: $tabSelection).tabItem {
                Image(systemName: "bolt.horizontal.fill")
                Text("Modal")
            }.tag(2)
        }

    }
    
}

// Screens

struct HomeScreen: View {
    
    @Binding var tabSelection: Int

    var body: some View {
        Button(action: {
            self.tabSelection = 1
        }) {
            Text("show list watch")
        }
        
    }
    
}

struct ModalScreen: View {
    
    @Binding var tabSelection: Int
    @State var showModal: Bool = false

    var body: some View {
        Button(action: {
            showModal = true
        }) {
            Text("Sell bitcoin")
        }.sheet(isPresented: $showModal) {
            Text("💰").font(Font.system(size: 150))
            Text("HODL").font(Font.system(size: 80))
        }
    }
    
}

struct ListScreen: View {
    
    @Binding var tabSelection: Int
    @Binding var selectionCell: Int

    var objectsViewModel = ObjectsListViewModel()
    
    var body: some View {
        
        NavigationView {
            
            List(objectsViewModel.objects) { obj in
                NavigationLink(destination: ObjectsDetailScreen(objectsName: obj.name)) {
                    cell(object: obj)
                }
            }
            
        }
        
    }
    
    func cell(object: Objects) -> some View {
        Text(object.name)
    }
    
}

// Details Screens

struct ObjectsDetailScreen: View {
    
    let objectsName: String
    
    var body: some View {
        Text(objectsName)
            .font(Font.system(size: 150))
    }
}

struct ObjectsListViewModel {
    
    var objects = [Objects(name: "⌚️"),
                   Objects(name: "💻"),
                   Objects(name: "⏰"),
                   Objects(name: "📟"),
                   Objects(name: "🔌"),
                   Objects(name: "🛢"),
                   Objects(name: "💎"),
                   Objects(name: "💣"),]

}

struct Objects: Identifiable {
    let id = UUID().uuidString
    let name: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
