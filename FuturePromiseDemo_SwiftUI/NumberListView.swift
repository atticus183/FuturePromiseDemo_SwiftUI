//
//  ContentView.swift
//  FuturePromiseDemo_SwiftUI
//
//  Created by Josh R on 6/4/21.
//

import SwiftUI

struct NumberListView: View {
    @StateObject var numberListViewModel = NumberListViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(numberListViewModel.numbers, id: \.self) { number in
                        VStack(alignment: .leading, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                            Text("\(number)")
                                .foregroundColor(Color.blue)
                            Text(numberListViewModel.spellOut(number: number))
                                .font(.subheadline)
                                .foregroundColor(Color.gray)
                        })
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("Numbers")

                if numberListViewModel.isDownloading {
                    ProgressView("Downloading")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NumberListView()
    }
}
