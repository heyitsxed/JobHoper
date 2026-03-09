//
//  ThemeToggleView.swift
//  JobHoper
//
//  Created by Cedrick on 3/9/26.
//

import SwiftUI

struct SwipeToggleView: View {
    
    @Binding var isDarkMode: Bool
    @State private var offset: CGFloat = 0
    
    let width: CGFloat = 220
    let height: CGFloat = 60
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            
            Capsule()
                .fill(isDarkMode ? Color.black : Color.yellow)
                .frame(width: width, height: height)
            
            Text(isDarkMode ? "Dark Mode" : "Light Mode")
                .foregroundColor(isDarkMode ? .white : .black)
                .bold()
                .frame(maxWidth: .infinity)
            
            Circle()
                .fill(Color.white)
                .frame(width: height - 10, height: height - 10)
                .offset(x: offset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            
                            if value.translation.width > 0 && !isDarkMode {
                                offset = min(value.translation.width, width - height)
                            }
                            
                            if value.translation.width < 0 && isDarkMode {
                                offset = max(width - height + value.translation.width, 0)
                            }
                        }
                        .onEnded { value in
                            
                            withAnimation(.spring()) {
                                
                                if value.translation.width > 50 {
                                    isDarkMode = true
                                    offset = width - height
                                } else if value.translation.width < -50 {
                                    isDarkMode = false
                                    offset = 0
                                } else {
                                    offset = isDarkMode ? width - height : 0
                                }
                            }
                        }
                )
        }
        .frame(width: width, height: height)
        .padding()
        .onAppear {
            offset = isDarkMode ? width - height : 0
        }
    }
}
