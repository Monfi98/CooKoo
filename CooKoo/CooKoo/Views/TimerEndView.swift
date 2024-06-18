//
//  TimerEndView.swift
//  CooKoo
//
//  Created by Minjung Lee on 6/16/24.
//

import SwiftUI

struct TimerEndView: View {

    var body: some View {
        VStack {
            Text("Timer Ended!")
                .font(.title)
                .padding()

            Button(action: {
                restartTimer()
            }) {
                Text("Restart Timer")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            Button(action: {
                resetTimer()
            }) {
                Text("Reset")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .navigationTitle("Timer End")
        .padding()
    }
    
    func restartTimer() {
        print("restartTiemr")
    }
    
    func resetTimer() {
        print("resetTimer")
    }
}

struct TimerEndView_Previews: PreviewProvider {
    static var previews: some View {
        TimerEndView()
    }
}
