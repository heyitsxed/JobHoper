//
//  DotsLoader.swift
//  JobHoper
//
//  Created by Cedrick on 2/20/26.
//

import SwiftUI


struct DotsLoader: View {
    @State private var scale: [Bool] = [false, false, false]

    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<3) { i in
                Circle()
                    .fill(Color.blue)
                    .frame(width: 12, height: 12)
                    .scaleEffect(scale[i] ? 0.5 : 1.0)
                    .animation(
                        Animation.easeInOut(duration: 0.6)
                            .repeatForever()
                            .delay(0.2 * Double(i)),
                        value: scale[i]
                    )
            }
        }
        .onAppear {
            for i in 0..<3 { scale[i] = true }
        }
    }
}
