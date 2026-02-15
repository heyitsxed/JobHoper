//
//  SheetDescription.swift
//  JobHoper
//
//  Created by Cedrick on 2/15/26.
//

import SwiftUI

struct SheetDescription: View {
    var company: Company?
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                Text(company?.description.htmlPlaintToText ?? "")
                    .font(.system(size: 16,weight: .regular))
            }
        }
    }
}
