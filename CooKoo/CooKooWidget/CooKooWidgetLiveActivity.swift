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
            // MARK: - 동그란 원
//            Button {
//                //TODO: End the activity
//            } label: {
//                Label("Stop", systemImage: "stop.circle")
//                    .font(.body.bold())
//                    .foregroundColor(Color("CooKooBlack"))
//            }
//            .foregroundColor(Color.backgroundColor)
//            //.background(Material.thinMaterial)
//            .background(Color("Background"))
//            .clipShape(Capsule())
//            .padding(.horizontal)
//            .padding(.vertical, 8)
//            .transition(.identity)
            
            Image("cookoo")
                .resizable()
                .frame(width: 100, height: 90)
                .padding(.leading, 10)
                .shadow(color: Color.black.opacity(0.12), radius: 6, x: 0, y: 2)
            
            Spacer()
            VStack {
                Text("CooKoo")
                    .font(.headline)
                    .minimumScaleFactor(0.8)
                    .contentTransition(.numericText())
                    .foregroundColor(Color("AccentColor"))
                Text(state.duration)
                    .font(Font.system(size: 45, weight: .bold))
                    .minimumScaleFactor(0.8)
                    .contentTransition(.numericText())
            }
            .padding(.trailing, 20)
            
            
            //            HStack(alignment: .center, spacing: 16) {
            //                WidgetCircleTimerView(
            //                    progress: state.progress,
            //                    duration: state.duration
            //                )
            //
            //                Text(state.duration)
            //                    .foregroundStyle(Color.primaryColor)
            //                    .font(.largeTitle.monospacedDigit())
            //                    .minimumScaleFactor(0.8)
            //                    .contentTransition(.numericText())
            //                .animation(.spring(response: 0.2), value: state.progress)
            //            }
            
        }
        .id(state)
        .transition(.identity)
        .padding()
        .background(Color("Background").opacity(0.5))
        .foregroundColor(Color("AccentColor"))
    }
}

// MARK: - 중간 사이즈 Dynamic Island
@DynamicIslandExpandedContentBuilder
private func expandedContent(state: TimerAttributes.ContentState) -> DynamicIslandExpandedContent<some View> {
    DynamicIslandExpandedRegion(.leading) {
        Image(systemName: "timer.circle.fill")
            .resizable()
            .frame(width: 80.0, height: 80.0)
            .foregroundColor(Color("AccentColor"))
            .padding(.vertical, 20)
            .padding(.leading, 20)
    }
    DynamicIslandExpandedRegion(.trailing) {
        VStack {
                Text("CooKoo")
                    .font(.headline)
                    .minimumScaleFactor(0.8)
                    .contentTransition(.numericText())
                    .foregroundColor(Color("AccentColor"))
                    .padding(.bottom, 0.5)

            Text(state.duration)
                .font(Font.system(size: 45, weight: .bold))
                .minimumScaleFactor(0.8)
                .contentTransition(.numericText())
        }
        .id(state)
        .transition(.identity)
        .padding(.vertical, 20)
        .padding(.trailing, 20)
    }
}

// MARK: - LiveActivity
struct CooKooWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TimerAttributes.self) { context in
            LiveActivityContent(state: context.state)
                .activityBackgroundTint(Color("AccentColor"))
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
