//
//  TimerStartViewModel.swift
//  CooKoo
//
//  Created by Minjung Lee on 6/16/24.
//

import SwiftUI
import Combine

class TimerStartViewModel: ObservableObject {
    @Published var state: State
    @Published var timeString: String
    private var timer: AnyCancellable?
    private var totalTime: Int
    
    struct State {
        var selectedKeyword: Keyword
    }
    
    enum Action {
//        case didPlusButtonTap
    }
    
    init(selectedKeyword: Keyword, totalTime: Int) {
        self.state = State(selectedKeyword: selectedKeyword)
        self.totalTime = totalTime
        self.timeString = TimerStartViewModel.formatTime(seconds: totalTime)
        startTimer()
    }
    
    func action(_ action: Action) {
//        switch action {
//        case .didPlusButtonTap:
//            self.state.isSheetPresented.toggle()
//        }
    }
    
    private func startTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect().sink { [weak self] _ in
            guard let self = self else { return }
            if self.totalTime > 0 {
                self.totalTime -= 1
                self.timeString = TimerStartViewModel.formatTime(seconds: self.totalTime)
            } else {
                self.timer?.cancel()
            }
        }
    }
    
    private static func formatTime(seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    deinit {
        timer?.cancel()
    }
}
