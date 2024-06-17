//
//  ContentView.swift
//  CooKoo
//
//  Created by Minjung Lee on 6/16/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedKeyword : Keyword = .cook
    
    // MARK: 텍스트에 보여지는 시간
    @State private var hours: Int = 0
    @State private var minutes: Int = 0
    @State private var seconds: Int = 0
    
    // MARK: 키패드로부터 작성되는 시간
    @State private var inputHours: String = ""
    @State private var inputMinutes: String = ""
    @State private var inputSeconds: String = ""
    @State private var inputValue: String = ""
    
    // MARK: 키패드를 사용해 수정 시 현재 활성화된 부분이 시/분/초 중 어디인지
    @State private var activeField: TimeField = .none
    
    
    //
    //    @State var startTime = Date()
    //
    @State var interval = TimeInterval()
    //
    @State var totalTime: TimeInterval = 0
    //
    //     ===== total Time =======
    @State var duration: TimeInterval = 2 * 60
    //
    
    //    @State var progress = 1.0
    //
    //    @State var isTimerRunning = false
    //
    //    @State var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    //
    //    @State var activity: Activity<TimerAttributes>?
    
    
    enum TimeField {
        case hours
        case minutes
        case seconds
        case none
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                Text("CooKoo")
                
                
                // MARK: - 키워드 선택
                HStack{
                    Text("Keyword")
                    Spacer()
                }
                HStack{
                    Button(action: {
                        selectedKeyword = .cook
                    }, label: {
                        Text("cook")
                            .padding()
                            .background(selectedKeyword == .cook ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    })
                    Button(action: {
                        selectedKeyword = .study
                    }, label: {
                        Text("study")
                            .padding()
                            .background(selectedKeyword == .study ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    })
                    Button(action: {
                        selectedKeyword = .exercise
                    }, label: {
                        Text("exercise")
                            .padding()
                            .background(selectedKeyword == .exercise ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    })
                    Button(action: {
                        selectedKeyword = .laundry
                    }, label: {
                        Text("laundry")
                            .padding()
                            .background(selectedKeyword == .laundry ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    })
                }
                
                // MARK: - Timer 부분
                HStack{
                    Text("Timer")
                    Spacer()
                }
                
                
                VStack{
                    HStack {
                        TimeFieldView(field: .hours, value: hours, activeField: $activeField)
                        Text(":")
                            .padding()
                        TimeFieldView(field: .minutes, value: minutes, activeField: $activeField)
                        Text(":")
                            .padding()
                        TimeFieldView(field: .seconds, value: seconds, activeField: $activeField)
                        TimeFieldView(field: .none, value: 0, activeField: $activeField)
                            .hidden()
                    }
                    
                    
                    
                    // MARK: - +1분
                    HStack {
                        PlusNumberButton(number: "+1h", action: { self.addHours(1)})
                        PlusNumberButton(number: "+10m", action: { self.addMinutes(10)})
                        PlusNumberButton(number: "+10s", action: { self.addSeconds(10)})
                        
                    }
                    
                    VStack(spacing: 10) {
                        HStack {
                            NumberButton(number: "1", action: { self.appendInput("1") })
                            NumberButton(number: "2", action: { self.appendInput("2") })
                            NumberButton(number: "3", action: { self.appendInput("3") })
                        }
                        
                        HStack {
                            NumberButton(number: "4", action: { self.appendInput("4") })
                            NumberButton(number: "5", action: { self.appendInput("5") })
                            NumberButton(number: "6", action: { self.appendInput("6") })
                        }
                        
                        HStack {
                            NumberButton(number: "7", action: { self.appendInput("7") })
                            NumberButton(number: "8", action: { self.appendInput("8") })
                            NumberButton(number: "9", action: { self.appendInput("9") })
                        }
                        
                        HStack {
                            Button(action: {
                                resetAll()
                            }) {
                                Text("reset")
                                    .padding()
                                    .frame(width: 80, height: 50)
                                    .background(Color.backgroundColor)
                                    .foregroundColor(.black)
                            }
                            .padding()
                            NumberButton(number: "0", action: { self.appendInput("0") })
                            Button(action: {
                                eraseInput()
                            }) {
                                Image(systemName: "delete.backward")
                                    .font(.system(size: 16)) // 아이콘 크기 조정
                                    .padding()
                                    .frame(width: 80, height: 50)
                                    .background(Color.backgroundColor)
                                    .foregroundColor(.black)
                            }
                            .padding()
                        }
                    }
                    
                    
                    let totalTime = (hours * 3600) + (minutes * 60) + seconds
                    
                    // MARK: - timerstart button
                    NavigationLink(
                        destination: TimerStartView(viewModel: TimerStartViewModel(selectedKeyword: selectedKeyword, totalTime: totalTime)),
                        label: {
                            Text("Start")
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    )
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.backgroundColor)
        }
    }
    
    // MARK: - 각 숫자모양 키패드 누를 때 호출되는 함수
    private func appendInput(_ digit: String) {
        //        누르자마자 숫자 지우기
        //        두 번 입력했으면 none으로 바꾸기
        switch activeField {
        case .hours:
            inputValue += digit
            
            if let intValue = Int(inputValue), intValue > 99 {
                inputValue = String(inputValue.suffix(2))
            }
            inputHours = inputValue
            updateHours()
            normalizeTime()
            
        case .minutes:
            inputValue = inputMinutes + digit
            if let value = Int(inputValue), value <= 59 {
                minutes = value
                inputMinutes = inputValue
            }
        case .seconds:
            inputValue = inputSeconds + digit
            if let value = Int(inputValue), value <= 59 {
                seconds = value
                inputSeconds = inputValue
            }
        case .none:
            print("none")
        }
    }
    
    // MARK: - 초 분 시를 reset 하는 함수
    private func eraseInput() {
        switch activeField {
        case .hours:
            hours = 0
            inputHours = ""
        case .minutes:
            minutes = 0
            inputMinutes = ""
        case .seconds:
            seconds = 0
            inputSeconds = ""
        case .none:
            print("dd")
        }
        inputValue = ""
    }
    
    private func resetAll() {
        hours = 0
        minutes = 0
        seconds = 0
        inputHours = ""
        inputMinutes = ""
        inputSeconds = ""
        inputValue = ""
    }
    
    // MARK: - 초 분 시를 받아서 hours, minutes, seconds에 더하는 함수
    private func addSeconds(_ secondsToAdd: Int) {
        seconds += secondsToAdd
        normalizeTime()
    }
    
    private func addMinutes(_ minutesToAdd: Int) {
        minutes += minutesToAdd
        normalizeTime()
    }
    
    private func addHours(_ hoursToAdd: Int) {
        hours += hoursToAdd
        normalizeTime()
    }
    
    // MARK: - 더해진 후 hour, min, sec를 text에 반영하는 함수
    private func updateSeconds() {
        if let inputSecondsInt = Int(inputSeconds) {
            seconds = inputSecondsInt
        } else {
            seconds = 0
        }
        normalizeTime()
    }
    
    private func updateMinutes() {
        if let inputMinutesInt = Int(inputMinutes) {
            minutes = inputMinutesInt
        } else {
            minutes = 0
        }
        normalizeTime()
    }
    
    private func updateHours() {
        if let inputHoursInt = Int(inputHours) {
            hours = inputHoursInt
        } else {
            hours = 0
        }
        normalizeTime()
    }
    
    private func updateTimes() {
        updateHours()
        updateMinutes()
        updateSeconds()
    }
    
    // MARK: - 초랑 분 60 넘었을 때 올림 해주는 함수
    private func normalizeTime() {
        if seconds >= 60 {
            seconds -= 60
            minutes += 1
        }
        if minutes >= 60 {
            minutes -= 60
            hours += 1
        }
        seconds = max(0, min(seconds, 59))
        minutes = max(0, min(minutes, 59))
        
    }
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

