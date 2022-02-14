//
//  MeetingFooterView.swift
//  iOS-App-Dev-Tutorials-Scrumdinger
//
//  Created by Larry Xia on 2022/2/10.
//

import SwiftUI

struct MeetingFooterView: View {
    let speakers: [ScrumTimer.Speaker]
    //暴露出的回调函数
    var skipAction: ()->Void
    private var currentSpeakerNumber: Int? {
        guard let temp = speakers.firstIndex(where: { !$0.isCompleted }) else { return nil}
        return temp + 1
    }
    private var isLastSpeaker: Bool {
        return speakers.dropLast().allSatisfy { $0.isCompleted }
    }
    private var speakerText: String {
        guard let speakerNumber = self.currentSpeakerNumber else { return "No more speakers" }
        return "Speaker \(speakerNumber) of \(speakers.count)"
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
        MeetingFooterView(speakers: DailyScrum.sampleScrums[0].attendees.toSpeakers(), skipAction: {})
            .previewLayout(.sizeThatFits)
            
    }
}
