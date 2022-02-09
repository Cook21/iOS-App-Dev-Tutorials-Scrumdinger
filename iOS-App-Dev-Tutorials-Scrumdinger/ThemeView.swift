//
//  ThemeView.swift
//  iOS-App-Dev-Tutorials-Scrumdinger
//
//  Created by Larry Xia on 2022/2/7.
//

import SwiftUI

struct ThemeView: View {
    let theme: Theme
    var body: some View {
        //顺序从后到前
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(theme.mainColor)
            Label(theme.name, systemImage: "paintpalette")
                .padding(4)
        }
        .foregroundColor(theme.accentColor)
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView(theme: .buttercup)
    }
}
