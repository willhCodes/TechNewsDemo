//
//  WebView.swift
//  Tech News
//
//  Created by willhcodes on 6/27/23.
//

import SwiftUI
import WebKit

struct DetailView: View {
    let url: String?
    
    var body: some View {
        WebView(url: url)
            .ignoresSafeArea(.all)
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(url: "http://www.bing.com")
    }
}
