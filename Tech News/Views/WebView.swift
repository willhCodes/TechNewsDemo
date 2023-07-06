//
//  WebView.swift
//  Tech News
//
//  Created by willhcodes on 6/27/23.
//

import SwiftUI
import WebKit
import Foundation

struct WebView: UIViewRepresentable {
    
    let url: String?

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        
        if let safeURL = url {
            if let url = URL(string: safeURL) {
                let request = URLRequest(url: url)
                uiView.load(request)
            }
        }
    }
}
