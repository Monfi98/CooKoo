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
        VStack(spacing: 10){
            HStack {
                Image("liveIcon")
                    .resizable()
                    .frame(width: 65, height: 65)
                    .padding(.leading, 5)
                    .aspectRatio(contentMode: .fit)
                    .shadow(color: Color.black.opacity(0.12), radius: 6, x: 0, y: 2)
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Coo-Koo")
                        .font(.headline)
                        .minimumScaleFactor(0.8)
                        .foregroundColor(Color("AccentColor"))
                    Text(state.duration)
                        .font(Font.system(size: 40, weight: .semibold))
                        .minimumScaleFactor(0.8)
                        .font(.largeTitle.monospacedDigit())
                        .contentTransition(.numericText())
                        .foregroundColor(Color("CooKooBlack"))
                }
                .padding(.trailing, 10)
            }
            
            HStack(alignment: .center) {
                WidgetProgressBarView(
                    progress: state.progress,
                    duration: state.duration
                )
            }
            .frame(height: 30)
        }
        .id(state)
        .transition(.opacity)
        .padding()
        .background(Color("Background").opacity(0.8))
        .foregroundColor(Color("Background"))

    }
}

// MARK: - 중간 사이즈 Dynamic Island
@DynamicIslandExpandedContentBuilder
private func expandedContent(state: TimerAttributes.ContentState) -> DynamicIslandExpandedContent<some View> {
    DynamicIslandExpandedRegion(.leading) {
        Image("smallcookoo")
            .resizable()
            .frame(width: 65, height: 60)
            .padding(.leading, 5)
            .aspectRatio(contentMode: .fit)
            .shadow(color: Color.black.opacity(0.12), radius: 6, x: 0, y: 2)
    }
    DynamicIslandExpandedRegion(.trailing) {
        VStack(alignment: .trailing) {
            Text("Coo-Koo")
                .font(.caption)
                .minimumScaleFactor(0.5)
                .foregroundColor(Color("AccentColor"))
            Text(state.duration)
                .font(Font.system(size: 40, weight: .semibold))
                .minimumScaleFactor(0.5)
                .font(.largeTitle.monospacedDigit())
                .contentTransition(.numericText())
                .foregroundColor(Color("CooKooWhite"))
        }
        .padding(.trailing, 5)
        .id(state)
        .transition(.identity)
    }
    DynamicIslandExpandedRegion(.bottom) {
        HStack(alignment: .center) {
            WidgetProgressBarView(
                progress: state.progress,
                duration: state.duration
            )
        }
        .id(state)
        .transition(.identity)
        .frame(height: 50)
    }
}

// MARK: - LiveActivity
struct CooKooWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TimerAttributes.self) { context in
            LiveActivityContent(state: context.state)
                .activityBackgroundTint(Color("CooKooWhite"))
                .activitySystemActionForegroundColor(Color("AccentColor"))
            
        } dynamicIsland: { context in
            // MARK: - compact 사이즈
            DynamicIsland {
                expandedContent(state: context.state)
            } compactLeading: {
                Image(systemName: "timer")
                    .transition(.identity)
                    .foregroundColor(Color("AccentColor"))
                    .padding(8)
            } compactTrailing: {
                Text(context.state.duration)
                    .minimumScaleFactor(0.8)
                    .contentTransition(.numericText())
                    .monospacedDigit()
                    .foregroundColor(Color("AccentColor"))
                    .padding(8)
            } minimal: {
                Image(systemName: "timer")
                    .foregroundColor(Color("AccentColor"))
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
    TimerAttributes.ContentState(duration: "22:02:41", progress: 0.80)
}


#Preview("Expand", as: .dynamicIsland(.expanded), using: TimerAttributes.preview) {
    CooKooWidgetLiveActivity()
}
contentStates: {
    TimerAttributes.ContentState(duration: "22:02:41", progress: 0.80)
}


#Preview("Compact", as: .dynamicIsland(.compact), using: TimerAttributes.preview) {
    CooKooWidgetLiveActivity()
}
contentStates: {
    TimerAttributes.ContentState(duration: "22:02:41", progress: 0.80)
}

#Preview("Minimal", as: .dynamicIsland(.minimal), using: TimerAttributes.preview) {
    CooKooWidgetLiveActivity()
}
contentStates: {
    TimerAttributes.ContentState(duration: "22:02:41", progress: 0.80)
}
