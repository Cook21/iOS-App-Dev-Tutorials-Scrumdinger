//
//  ScrumsView.swift
//  iOS-App-Dev-Tutorials-Scrumdinger
//
//  Created by Larry Xia on 2022/2/7.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    @State private var isPresentingNewScrumView = false
    @State private var newScrumData = DailyScrum.TemporaryData()
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: ()->Void
    var body: some View {
        NavigationView {
            List {
                ForEach($scrums) { $scrum in
                    NavigationLink(destination: DetailView(scrum: $scrum)) {
                        CardView(scrum: scrum)
                        
                    }.listRowBackground(scrum.theme.mainColor)
                }
                .onDelete { indices in
                    scrums.remove(atOffsets: indices)
                }
            }
            .navigationTitle("Daily Scrums")
            .toolbar {
                Button(action: {isPresentingNewScrumView=true}) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $isPresentingNewScrumView) {
                NavigationView {
                    DetailEditView(data: $newScrumData)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Dismiss") {
                                    newScrumData = DailyScrum.TemporaryData()
                                    isPresentingNewScrumView = false
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Add") {
                                    let newScrum = DailyScrum(data: newScrumData)
                                    scrums.append(newScrum)
                                    newScrumData = DailyScrum.TemporaryData()
                                    isPresentingNewScrumView = false
                                }
                            }
                        }
                }
            }
            .onChange(of: scenePhase) { phase in
                if phase == .inactive { saveAction() }
            }
        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        ScrumsView(scrums: .constant(DailyScrum.sampleScrums),saveAction: {})
    }
}
