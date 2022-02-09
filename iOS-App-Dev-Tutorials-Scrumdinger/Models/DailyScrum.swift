//
//  DailyScrum.swift
//  iOS-App-Dev-Tutorials-Scrumdinger
//
//  Created by Larry Xia on 2022/2/4.
//

import Foundation
struct DailyScrum: Identifiable {
    var title: String
    var attendees: [Attendee]
    var lengthInMinutes: Int
    var theme: Theme
    let id: UUID
    init(id: UUID = UUID(), title: String, attendees: [String], lengthInMinutes: Int, theme: Theme) {
        self.id = id
        self.title = title
        self.attendees = attendees.map{Attendee(name: $0)}
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
    }
}
extension DailyScrum {
    struct Attendee: Identifiable {
        let id: UUID
        var name: String
        
        init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
    struct TemporaryData {
        var title: String = ""
        var attendees: [Attendee] = []
        var lengthInMinutes: Double = 5
        var theme: Theme = .seafoam
    }
    var temporaryDataTemplate: TemporaryData {
        TemporaryData(title: title, attendees: attendees, lengthInMinutes: Double(lengthInMinutes), theme: theme)
    }
    mutating func updateFrom(temporaryData: TemporaryData){
        self.title = temporaryData.title
        self.attendees = temporaryData.attendees
        self.lengthInMinutes = Int(temporaryData.lengthInMinutes)
        self.theme = temporaryData.theme
    }
}
extension DailyScrum {
    static let sampleScrums: [DailyScrum] =
    [
        DailyScrum(title: "Design", attendees: ["Cathy", "Daisy", "Simon", "Jonathan"], lengthInMinutes: 10, theme: .yellow),
        DailyScrum(title: "App Dev", attendees: ["Katie", "Gray", "Euna", "Luis", "Darla"], lengthInMinutes: 5, theme: .orange),
        DailyScrum(title: "Web Dev", attendees: ["Chella", "Chris", "Christina", "Eden", "Karla", "Lindsey", "Aga", "Chad", "Jenn", "Sarah"], lengthInMinutes: 5, theme: .poppy)
    ]
}
