//
//  CardView.swift
//  iOS-App-Dev-Tutorials-Scrumdinger
//
//  Created by Larry Xia on 2022/2/4.
//

import SwiftUI

struct CardView: View {
    let scrum: DailyScrum
    var body: some View {
        VStack(alignment: .leading) {
            Text(scrum.title).font(.headline).accessibilityAddTraits(.isHeader)
            Spacer()
            HStack {
                Label("\(scrum.attendees.count)", systemImage: "person.3")
                    .accessibilityLabel("\(scrum.attendees.count) attendees")
                Spacer()
                Label("\(scrum.lengthInMinutes)", systemImage: "clock")
                    .labelStyle(.trailingIcon)//为了跟左边label的对称，图标在文字右边
                    .accessibilityLabel("\(scrum.lengthInMinutes) minute meeting")
                    
            }.font(.caption)
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var scrum = DailyScrum.sampleScrums[0]
    static var previews: some View {
        CardView(scrum: scrum)
        //调整为在ListView内部的样子
            .background(scrum.theme.mainColor)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
