//
//  CooKooWidgetLiveActivity.swift
//  CooKooWidget
//
//  Created by Minjung Lee on 6/17/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct CooKooWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct CooKooWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: CooKooWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension CooKooWidgetAttributes {
    fileprivate static var preview: CooKooWidgetAttributes {
        CooKooWidgetAttributes(name: "World")
    }
}

extension CooKooWidgetAttributes.ContentState {
    fileprivate static var smiley: CooKooWidgetAttributes.ContentState {
        CooKooWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: CooKooWidgetAttributes.ContentState {
         CooKooWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: CooKooWidgetAttributes.preview) {
   CooKooWidgetLiveActivity()
} contentStates: {
    CooKooWidgetAttributes.ContentState.smiley
    CooKooWidgetAttributes.ContentState.starEyes
}
