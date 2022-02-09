//
//  ThemePicker.swift
//  iOS-App-Dev-Tutorials-Scrumdinger
//
//  Created by Larry Xia on 2022/2/7.
//

import SwiftUI

struct ThemePicker: View {
    //从父视图传引用的时候必须标记Binding
    @Binding var selection: Theme
    var body: some View {
        Picker("Theme", selection: $selection) {
            ForEach(Theme.allCases) { theme in
                ThemeView(theme: theme)
                    .tag(theme) //selection==theme的时候picker会选中该项
            }
        }
    }
}

struct ThemePicker_Previews: PreviewProvider {
    static var previews: some View {
        ThemePicker(selection: .constant(.periwinkle))
    }
}
