//
//  ProfileViewModel.swift
//  JobHoper
//
//  Created by Cedrick on 3/1/26.
//

import Combine
import _PhotosUI_SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var selectedItem: PhotosPickerItem? {
        didSet {
            loadImage(image: selectedItem)
        }
    }
    
    @Published var selectedImage: UIImage?
    
    init() {
        selectedImage = loadSavedImage()
    }
    
    func loadImage(image: PhotosPickerItem?) {
        guard let image = image else { return }
        
        Task {
            if let data = try? await image.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                await MainActor.run {
                    self.selectedImage = uiImage
                    self.saveImage(uiImage)
                }
            }
        }
    }
    
    func saveImage(_ image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return }
        let fileName = getDocumentDirectory()
            .appendingPathComponent("filename.jpg")
        
        try? data.write(to: fileName)
    }
    
    func loadSavedImage() -> UIImage? {
        let fileName = getDocumentDirectory()
            .appendingPathComponent("filename.jpg")
        
        if let data = try? Data(contentsOf: fileName) {
            return UIImage(data: data)
        }
        
        return nil
    }
    
    func getDocumentDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
