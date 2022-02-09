//
//  Theme.swift
//  iOS-App-Dev-Tutorials-Scrumdinger
//
//  Created by Larry Xia on 2022/2/3.
//

import SwiftUI
//CaseIterable:可以使用.allCases访问所有case
enum Theme: String,  CaseIterable, Identifiable {
    case bubblegum
    case buttercup
    case indigo
    case lavender
    case magenta
    case navy
    case orange
    case oxblood
    case periwinkle
    case poppy
    case purple
    case seafoam
    case sky
    case tan
    case teal
    case yellow
    var accentColor: Color {
        switch self {
        case .bubblegum, .buttercup, .lavender, .orange, .periwinkle, .poppy, .seafoam, .sky, .tan, .teal, .yellow: return .black
        case .indigo, .magenta, .navy, .oxblood, .purple: return .white
        }
    }
    var mainColor: Color {
        //因为是string类型的枚举，所以rawValue是对应的字符串
        Color(rawValue)
    }
    var name: String {
        rawValue.capitalized
    }
    var id: String{
        name
    }
}
