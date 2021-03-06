//
// Created by Shaban on 04/06/2021.
// Copyright (c) 2021 sha. All rights reserved.
//

import SwiftUI

public struct SpringItemView: View {
    @Binding var isExpanded: Bool
    public var item: SpringItem
    var direction: SpringItemDirection
    let settings: SpringMenuSettings

    public var body: some View {
        ZStack {
            ZStack {
                item.icon
                        .font(.system(size: 32, weight: .medium, design: .rounded))
                        .foregroundColor(item.foregroundColor)
                        .opacity(isExpanded ? 1 : 0)
                        .scaleEffect(isExpanded ? 1 : 0)
                        .rotationEffect(isExpanded ? .degrees(-43) : .degrees(0))
                        .animation(Animation.easeOut(duration: 0.15))
            }
                    .frame(width: 82, height: 82)
                    .background(backgroundColor())
                    .cornerRadius(isExpanded ? 41 : 8)
                    .scaleEffect(isExpanded ? 1 : 0.5)
                    .opacity(itemOpacity())
                    .offset(x: isExpanded ? direction.offsets.x : 0, y: isExpanded ? direction.offsets.y : 0)
                    .rotationEffect(isExpanded ? .degrees(43) : .degrees(0))
                    .animation(anim())
        }
                .offset(x: direction.containerOffset.x, y: direction.containerOffset.y)
                .onTapGesture(perform: onTap)
    }

    private func onTap() {
        if settings.collapseOnItemTapped {
            isExpanded.toggle()
        }
        item.onTap?()
    }

    private func backgroundColor() -> Color? {
        isExpanded ?
                item.backgroundColor :
                settings.iconBackgroundColor.collapsed
    }

    private func itemOpacity() -> Double {
        guard !item.isPlaceholder else {
            return isExpanded ? 0 : 1
        }
        return 1
    }

    private func anim() -> Animation? {
        guard !item.isPlaceholder else {
            return settings.hasPlaceholderItemsAnimation ?
                    .easeOut(duration: 0.25).delay(0.05) :
                    nil
        }
        return  .easeOut(duration: 0.25).delay(0.05)
    }
}

struct Spring_Previews: PreviewProvider {
    static var previews: some View {
        let item = SpringItem.Builder()
                .icon(Image(systemName: "folder"))
                .foregroundColor(.blue)
                .build()
        let settings = SpringMenuSettings.Builder()
                .icon(.plus,
                        backgroundColor: SpringIconColor(collapsed: .white, expanded: .clear),
                        foreGroundColor: SpringIconColor(collapsed: .black, expanded: .white))
                .build()
        SpringItemView(isExpanded: .constant(true), item: item, direction: .top, settings: settings)
    }
}