//
//  TrailingIconLabelStyle.swift
//  iOS-App-Dev-Tutorials-Scrumdinger
//
//  Created by Larry Xia on 2022/2/5.
//

import SwiftUI
//给自带的LabelStyle添加一种样式
struct TrailingIconLabelStyle: LabelStyle {
    //函数overwrite
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}
extension LabelStyle where Self == TrailingIconLabelStyle {
    //便于用.labelStyle(.trailingIcon)的形式访问
    static var trailingIcon: Self { Self() }
}
