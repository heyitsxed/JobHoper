//
//  ImageView.swift
//  JobHoper
//
//  Created by Cedrick on 3/1/26.
//

import SwiftUI
import PhotosUI

struct ImageView: View {
    @ObservedObject var viewModel: ProfileViewModel

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image(uiImage: viewModel.selectedImage ?? UIImage())
                .resizable()
                .scaledToFill()
                .frame(width: 90, height: 90)
                .clipShape(Circle())
            
            PhotosPicker(selection: $viewModel.selectedItem, matching: .images) {
                Image(systemName: "camera.fill")
                    .padding(8)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Circle())
            }
            
        }.onAppear {
            viewModel.selectedImage = viewModel.loadSavedImage()
        }
    }
}


