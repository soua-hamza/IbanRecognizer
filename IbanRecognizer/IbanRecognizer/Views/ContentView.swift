//
//  ContentView.swift
//  IbanRecognizer
//
//  Created by soua hamza on 13/11/2024.
//

import SwiftUI

struct TabViewContent: View {
    var text: String
    var body: some View {
        Text(text)
    }
}

struct ContentView: View {
    var body: some View {
        TabView {
            TabViewContent(text: L10n.accountViewText)
                .tabItem {
                    Image(systemName:"wallet.pass")
                    Text(L10n.tabViewItem1)
                }

            TransactionContentView()
                .tabItem {
                    Image(systemName:"rectangle.portrait.and.arrow.right.fill")
                    Text(L10n.tabViewItem2)
                }

            TabViewContent(text: L10n.helpViewText)
                .tabItem {
                    Image(systemName:"questionmark.circle")
                    Text(L10n.tabViewItem3)
                }
            TabViewContent(text: L10n.moreViewText)
                .tabItem {
                    Image(systemName:"ellipsis")
                    Text(L10n.tabViewItem4)
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
