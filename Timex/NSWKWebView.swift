//
//  NSWKWebView.swift
//  Timex
//
//  Created by Nick Kaczmarek on 7/20/21.
//

import Foundation
import WebKit
import SwiftUI

class WebViewModel: ObservableObject {
    @Published var link: String
    @Published var didFinishLoading: Bool = false
    @Published var pageTitle: String
    
    init (link: String) {
        self.link = link
        self.pageTitle = ""
    }
}

struct NSWKWebView: NSViewRepresentable {
    public typealias NSViewType = WKWebView
    
    @ObservedObject var viewModel: WebViewModel

        private let webView: WKWebView = WKWebView()
        public func makeNSView(context: Context) -> WKWebView {
            webView.navigationDelegate = context.coordinator
            webView.uiDelegate = context.coordinator as? WKUIDelegate
            webView.load(URLRequest(url: URL(string: viewModel.link)!))
            return webView
        }

        public func updateNSView(_ nsView: WKWebView, context: Context) { }

        public func makeCoordinator() -> Coordinator {
            return Coordinator(viewModel)
        }
        
        class Coordinator: NSObject, WKNavigationDelegate {
            private var viewModel: WebViewModel

            init(_ viewModel: WebViewModel) {
               //Initialise the WebViewModel
               self.viewModel = viewModel
            }
            
            public func webView(_: WKWebView, didFail: WKNavigation!, withError: Error) { }

            public func webView(_: WKWebView, didFailProvisionalNavigation: WKNavigation!, withError: Error) { }

            //After the webpage is loaded, assign the data in WebViewModel class
            public func webView(_ web: WKWebView, didFinish: WKNavigation!) {
                self.viewModel.pageTitle = web.title!
                self.viewModel.link = web.url?.absoluteString ?? ""
                self.viewModel.didFinishLoading = true
            }

            public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            }

            public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
                decisionHandler(.allow)
            }

        }

}
