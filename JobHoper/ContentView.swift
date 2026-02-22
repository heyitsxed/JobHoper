//
//  ContentView.swift
//  JobHoper
//
//  Created by Cedrick on 2/12/26.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowHomePage: Bool = false
    
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    
    private let splashScreenDurationn: Double = 2.5
    
    var body: some View {
        ZStack {
            Group {
                if isLoggedIn {
                    HomePageView()
                } else {
                    LoginView()
                }
            }
            .animation(.easeOut, value: isLoggedIn)
            
            if !isShowHomePage {
                SplashScreen()
                    .transition(.opacity)
                    .zIndex(1)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + splashScreenDurationn) {
                withAnimation { self.isShowHomePage = true }
            }
        }
    }
}

#Preview {
    ContentView()
}
