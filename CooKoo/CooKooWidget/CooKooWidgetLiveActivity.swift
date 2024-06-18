//
//  CooKooWidgetLiveActivity.swift
//  CooKooWidget
//
//  Created by Minjung Lee on 6/17/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

// MARK: - Views
struct LiveActivityContent: View {
    let state: TimerAttributes.ContentState

    var body: some View {
        HStack {
            Button {
                //TODO: End the activity
            } label: {
                Label("Stop", systemImage: "stop.circle")
                    .font(.body.bold())
            }
            .foregroundColor(Color.backgroundColor)
            //.background(Material.thinMaterial)
            .background(Color.primaryColor)
            .clipShape(Capsule())
            .padding(.horizontal)
            .padding(.vertical, 8)
            .transition(.identity)

            Spacer()

            HStack(alignment: .center, spacing: 16) {
                WidgetCircleTimerView(
                    progress: state.progress,
                    duration: state.duration
                )

                Text(state.duration)
                    .foregroundStyle(Color.primaryColor)
                    .font(.largeTitle.monospacedDigit())
                    .minimumScaleFactor(0.8)
                    .contentTransition(.numericText())
                .animation(.spring(response: 0.2), value: state.progress)
            }

        }
        .id(state)
        .transition(.identity)
        .padding()
        .foregroundColor(Color.primaryColor)
    }
}

// MARK: - 중간 사이즈 Dynamic Island
@DynamicIslandExpandedContentBuilder
private func expandedContent(state: TimerAttributes.ContentState) -> DynamicIslandExpandedContent<some View> {
    DynamicIslandExpandedRegion(.leading) {
        Image(systemName: "timer.circle.fill")
            .resizable()
            .frame(width: 44.0, height: 44.0)
            .foregroundColor(Color.primaryColor)
    }
    DynamicIslandExpandedRegion(.center) {
        VStack {
            Text(state.duration)
                .font(.title)
                .minimumScaleFactor(0.8)
                .contentTransition(.numericText())
            Spacer()
            Button {
                //TODO: End the activity
            } label: {
                Label("Stop", systemImage: "stop.circle")
                    .font(.body.bold())
            }
            .foregroundColor(Color.backgroundColor)
            //.background(Material.thinMaterial)
            .background(Color.primaryColor)
            .clipShape(Capsule())
            .padding(.horizontal)
            .padding(.vertical, 8)
            .lineLimit(1)
        }
        .id(state)
        .transition(.identity)
    }
}

// MARK: - LiveActivity
struct CooKooWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TimerAttributes.self) { context in
            LiveActivityContent(state: context.state)
                .activityBackgroundTint(Color("AccentColor").opacity(0.25))
                .activitySystemActionForegroundColor(Color.primaryColor)

        } dynamicIsland: { context in
            // MARK: - compact 사이즈
            DynamicIsland {
                expandedContent(state: context.state)
            } compactLeading: {
                Image(systemName: "timer")
                    .transition(.identity)
                    .foregroundColor(Color.primaryColor)
                    .padding(8)
            } compactTrailing: {
                Text(context.state.duration)
                    .minimumScaleFactor(0.8)
                    .contentTransition(.numericText())
                    .monospacedDigit()
                    .foregroundColor(Color.primaryColor)
                    .padding(8)
            } minimal: {
                Image(systemName: "timer")
                    .foregroundColor(Color.primaryColor)
            }
        }
    }
}

extension TimerAttributes {
    fileprivate static var preview: TimerAttributes {
        TimerAttributes(name: "CooKoo")
    }
}
//
//extension TimerWidgetAttributes.ContentState {
//    fileprivate static var smiley: TimerWidgetAttributes.ContentState {
//        TimerWidgetAttributes.ContentState(emoji: "😀")
//     }
//
//     fileprivate static var starEyes: TimerWidgetAttributes.ContentState {
//         TimerWidgetAttributes.ContentState(emoji: "🤩")
//     }
//}

#Preview("Notification", as: .content, using: TimerAttributes.preview) {
   CooKooWidgetLiveActivity()
}
contentStates: {
    TimerAttributes.ContentState(duration: "2:41", progress: 0.80)
}


#Preview("Expand", as: .dynamicIsland(.expanded), using: TimerAttributes.preview) {
    CooKooWidgetLiveActivity()
}
contentStates: {
    TimerAttributes.ContentState(duration: "2:41", progress: 0.80)
}


#Preview("Compact", as: .dynamicIsland(.compact), using: TimerAttributes.preview) {
    CooKooWidgetLiveActivity()
}
contentStates: {
    TimerAttributes.ContentState(duration: "2:41", progress: 0.80)
}

#Preview("Minimal", as: .dynamicIsland(.minimal), using: TimerAttributes.preview) {
    CooKooWidgetLiveActivity()
}
contentStates: {
    TimerAttributes.ContentState(duration: "2:41", progress: 0.80)
}
