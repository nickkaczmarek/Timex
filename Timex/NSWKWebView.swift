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
    let homeUrl = "https://timex.apps.wwt.com"

    @Published var link: String

    init() {
        self.link = homeUrl
    }

    func refresh(with handler: @escaping () -> ()) {
        handler()
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
        webView.allowsMagnification = true
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }

    public func updateNSView(_ nsView: WKWebView, context: Context) {}

    public func reload() {
        webView.reload()
    }

    public func goBack() {
        guard webView.canGoBack else { return }
        webView.goBack()
    }

    public func goForward() {
        guard webView.canGoForward else { return }
        webView.goForward()
    }

    public func goHome() {
        webView.load(URLRequest(url: URL(string: viewModel.homeUrl)!))
    }

    public func stopLoading() {
        webView.stopLoading()
    }

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
            self.viewModel.link = web.url?.absoluteString ?? ""
        }

        public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        }

        public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            decisionHandler(.allow)
        }

    }

}
