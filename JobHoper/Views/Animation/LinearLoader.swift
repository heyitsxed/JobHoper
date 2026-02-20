//
//  LinearLoader.swift
//  JobHoper
//
//  Created by Cedrick on 2/20/26.
//

import SwiftUI

struct LinearLoader: View {
    @State private var progress: Double = 0.0

    var body: some View {
        VStack {
            ProgressView(value: progress)
                .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
                        if progress < 1 {
                            progress += 0.01
                        } else {
                            timer.invalidate()
                        }
                    }
                }
        }
    }
}
