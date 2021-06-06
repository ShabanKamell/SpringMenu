//
// Created by Shaban on 04/06/2021.
// Copyright (c) 2021 sha. All rights reserved.
//

import SwiftUI

public struct SpringItemView: View {
    @Binding var expand: Bool
    public var item: SpringItem
    var direction: SpringItemDirection
    let settings: SpringMenuSettings

    public var body: some View {
        ZStack {
            ZStack {
                item.icon
                        .font(.system(size: 32, weight: .medium, design: .rounded))
                        .foregroundColor(Color.black)
                        .padding()
                        .opacity(expand ? 0.85 : 0)
                        .scaleEffect(expand ? 1 : 0)
                        .rotationEffect(expand ? .degrees(-43) : .degrees(0))
                        .animation(Animation.easeOut(duration: 0.15))
            }
                    .frame(width: 82, height: 82)
                    .background(item.isPlaceholder && expand ? .clear : item.background)
                    .cornerRadius(expand ? 41 : 8)
                    .scaleEffect(expand ? 1 : 0.5)
                    .opacity(itemOpacity())
                    .offset(x: expand ? direction.offsets.x : 0, y: expand ? direction.offsets.y : 0)
                    .rotationEffect(expand ? .degrees(43) : .degrees(0))
                    .animation(anim())
        }
                .offset(x: direction.containerOffset.x, y: direction.containerOffset.y)
    }

    private func itemOpacity() -> Double {
        guard !item.isPlaceholder else {
            return expand ? 0 : 1
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
        let item = SpringItem(icon: Image(systemName: ""))
        let settings = SpringMenuSettings.Builder()
                .icon(Image(systemName: "plus"))
                .build()
        SpringItemView(expand: .constant(true), item: item, direction: .top, settings: settings)
    }
}






