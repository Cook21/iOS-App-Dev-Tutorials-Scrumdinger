//
//  MeetingFooterView.swift
//  iOS-App-Dev-Tutorials-Scrumdinger
//
//  Created by Larry Xia on 2022/2/10.
//

import SwiftUI

struct MeetingFooterView: View {
    @ObservedObject var scrumTimer: ScrumTimer
    var speakers: [ScrumTimer.Speaker] {
        return scrumTimer.speakers
    }
    //暴露出的回调函数
    var skipAction: ()->Void
    private var currentSpeakerNumber: Int {
        return scrumTimer.speakerIndex + 1
    }
    private var isLastSpeaker: Bool {
        return scrumTimer.speakerIndex == speakers.count - 1
    }
    private var speakerText: String {
        return "Speaker \(currentSpeakerNumber) of \(speakers.count)"
    }
    var body: some View {
        HStack {
            if !isLastSpeaker {
                Text(speakerText)
                Spacer()
                Button(action: skipAction) {
                    Image(systemName: "forward.fill")
                }.accessibilityLabel("Next speaker")
            }else{
                Text("Last Speaker")
            }
        }.padding([.bottom, .horizontal])
    }
}

struct MeetingFooterView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingFooterView(scrumTimer: ScrumTimer(lengthInMinutes: 5, attendees:  DailyScrum.sampleScrums[0].attendees), skipAction: {})
            .previewLayout(.sizeThatFits)
            
    }
}
