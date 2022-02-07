//
//  ScrumsView.swift
//  iOS-App-Dev-Tutorials-Scrumdinger
//
//  Created by Larry Xia on 2022/2/7.
//

import SwiftUI

struct ScrumsView: View {
    let scrums: [DailyScrum]
    var body: some View {
        NavigationView {
            List {
                ForEach(scrums) { scrum in
                    NavigationLink(destination: DetailView(scrum: scrum)) {
                        CardView(scrum: scrum)
                        
                    }.listRowBackground(scrum.theme.mainColor)
                }
            }.navigationTitle("Daily Scrums")
                .toolbar {
                    Button(action: {}) {
                        Image(systemName: "plus")
                    }
                }
        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        ScrumsView(scrums: DailyScrum.sampleData)
    }
}
