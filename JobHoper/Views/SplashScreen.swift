//
//  SplashScreen.swift
//  JobHoper
//
//  Created by Cedrick on 2/20/26.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack {
            Color(Color.white)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 10) {
                Text("Job Hopper")
                    .font(.custom("AvenirNext-Bold", size: 36))
                    .foregroundColor(.blue)

                DotsLoader()
            }
            .frame(width: 220)
            
        }
    }
}

#Preview {
    SplashScreen()
}

