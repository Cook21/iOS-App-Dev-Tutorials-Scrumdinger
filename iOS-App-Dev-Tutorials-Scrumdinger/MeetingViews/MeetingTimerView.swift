//
//  MeetingTimerView.swift
//  iOS-App-Dev-Tutorials-Scrumdinger
//
//  Created by Larry Xia on 2022/2/20.
//

import SwiftUI

struct MeetingTimerView: View {
    var currentSpeaker: String
    var currentIndex: Int
    var totalCount: Int
    let theme: Theme
    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 24)
            .overlay {
                VStack{
                    Text(currentSpeaker)
                        .font(.title)
                    Text("is speaking")
                }
                .accessibilityElement(children: .combine)
                .foregroundStyle(theme.accentColor)
            }
            .overlay{
                ForEach(0...currentIndex, id:\.self) {
                    SpeakerArc(currentIndex: $0, totalCount: totalCount)
                        .rotation(Angle(degrees: -90))
                    //原本是封闭图形，现在改成沿着path的一段圆弧
                        .stroke(theme.mainColor, lineWidth: 12)
                }
            }
            .padding(.horizontal)
        
    }
}

struct MeetingTimerView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingTimerView(currentSpeaker: "Bill", currentIndex: 1, totalCount: 4, theme: .yellow)
    }
}
