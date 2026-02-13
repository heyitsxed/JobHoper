//
//  StringeExtension.swift
//  JobHoper
//
//  Created by Cedrick on 2/13/26.
//

import SwiftUI

extension String {
    var htmlPlaintToText: String {
        let body = self
            .replacingOccurrences(of: "\n", with: "<br>")
            .replacingOccurrences(of: "<span class=\"wysiwyg-underline\">", with: "<u>")
            .replacingOccurrences(of: "</span>", with: "</u>")
        
        guard let data = body.data(using: .utf8) else { return self }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        let attributed = try? NSAttributedString(data: data, options: options, documentAttributes: nil)
        return attributed?.string ?? self
    }
}
