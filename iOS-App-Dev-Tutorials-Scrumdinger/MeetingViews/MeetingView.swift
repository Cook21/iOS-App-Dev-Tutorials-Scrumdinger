//
//  ContentView.swift
//  iOS-App-Dev-Tutorials-Scrumdinger
//
//  Created by Larry Xia on 2022/1/26.
//

import SwiftUI
import AVFoundation

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    @StateObject var scrumTimer = ScrumTimer()
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false
    private var player: AVPlayer { AVPlayer.sharedDingPlayer }
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.theme.mainColor)
            VStack {
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed, secondsRemaining: scrumTimer.secondsRemaining, theme: scrum.theme)
                MeetingTimerView(currentSpeaker: scrumTimer.activeSpeaker, currentIndex: scrumTimer.speakerIndex, totalCount: scrumTimer.speakers.count, theme: scrum.theme, isRecording: isRecording)
                MeetingFooterView(scrumTimer: scrumTimer, skipAction: scrumTimer.skipSpeaker)
                
            }
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        .navigationBarTitleDisplayMode(.inline)
        //每次打开meetingview都重置计时器
        .onAppear {
            scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
            scrumTimer.speakerChangedAction = {
                player.seek(to: .zero)
                player.play()
            }
            scrumTimer.startScrum()
            isRecording = true
            speechRecognizer.reset()
            speechRecognizer.transcribe()
        }
        //退出后释放资源
        .onDisappear {
            //不太对，改掉了
            scrumTimer.stopScrum()
            isRecording = false
            speechRecognizer.stopTranscribing()
            let newHistory = History(attendees: scrum.attendees, lengthInMinutes: scrumTimer.secondsElapsed / 60,transcript: speechRecognizer.transcript)
            scrum.history.insert(newHistory, at: 0)
            
        }
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MeetingView(scrum: .constant(DailyScrum.sampleScrums[0]))
        }
    }
}
