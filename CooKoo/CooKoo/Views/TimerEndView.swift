//
//  TimerEndView.swift
//  CooKoo
//
//  Created by Minjung Lee on 6/16/24.
//

import SwiftUI

struct TimerEndView: View {
    @StateObject var viewModel = TimerEndViewModel()

    var body: some View {
        VStack {
            Text("Timer Ended!")
                .font(.title)
                .padding()

            Button(action: {
                viewModel.restartTimer()
            }) {
                Text("Restart Timer")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            Button(action: {
                viewModel.resetTimer()
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
}

struct TimerEndView_Previews: PreviewProvider {
    static var previews: some View {
        TimerEndView()
    }
}
