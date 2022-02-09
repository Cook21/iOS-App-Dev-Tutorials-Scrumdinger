//
//  DetailEditView.swift
//  iOS-App-Dev-Tutorials-Scrumdinger
//
//  Created by Larry Xia on 2022/2/7.
//

import SwiftUI

struct DetailEditView: View {
    //被视图观察和修改的局部变量标记State
    @Binding var data: DailyScrum.TemporaryData
    @State private var newAttendeeName = ""
    var body: some View {
        Form {
            Section(header: Text("Meeting Info")) {
                TextField("Title", text: $data.title)
                HStack {
                    Slider(value: $data.lengthInMinutes, in: 5...30, step: 1) {
                        Text("Length")
                    }
                    .accessibilityValue("\(Int(data.lengthInMinutes)) minutes")
                    Spacer()
                    Text("\(Int(data.lengthInMinutes)) minutes")
                        .accessibilityHidden(true)
                }
                ThemePicker(selection: $data.theme)
            }
            Section(header: Text("Attendees")) {
                ForEach(data.attendees) { attendee in
                    Text(attendee.name)
                }
                .onDelete { indices in
                    data.attendees.remove(atOffsets: indices)
                }
                HStack {
                    TextField("New Attendee", text: $newAttendeeName)
                    Button(action: {
                        withAnimation {
                            let attendee = DailyScrum.Attendee(name: newAttendeeName)
                            data.attendees.append(attendee)
                            newAttendeeName = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add attendee")
                    }
                    .disabled(newAttendeeName.isEmpty)
                }
            }
        }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView(data:  .constant(DailyScrum.sampleScrums[0].temporaryDataTemplate))
    }
}
