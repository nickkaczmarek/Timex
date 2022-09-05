//
//  ContentView.swift
//  Timex
//
//  Created by Nick Kaczmarek on 7/20/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var webViewModel = WebViewModel()

    @State private var webView: NSWKWebView?

    var body: some View {
        webView
            .frame(minWidth: 400,
                   idealWidth: 1000,
                   maxWidth: .infinity,
                   minHeight: 500,
                   idealHeight: 800,
                   maxHeight: .infinity,
                   alignment: .center)
            .onAppear {
                webView = NSWKWebView(viewModel: webViewModel)
            }
            .toolbar {
                ToolbarItem {
                    HStack {
                        Text(URL(string: webViewModel.link)!.host ?? "")
                            .fontWeight(.bold)
                        Spacer()
                        Button {
                            webView?.goHome()
                        } label: {
                            Image(systemName: "house")
                        }
                        .keyboardShortcut("h", modifiers: [.command, .shift])

                        Button {
                            webView?.stopLoading()
                        } label: {
                            Image(systemName: "xmark")
                        }
                        .keyboardShortcut(".")

                        Button {
                            webView?.goBack()
                        } label: {
                            Image(systemName: "arrow.backward")
                        }
                        .keyboardShortcut(KeyEquivalent.leftArrow)

                        Button {
                            webView?.reload()
                        } label: {
                            Image(systemName: "arrow.clockwise")
                        }
                        .keyboardShortcut("r")

                        Button {
                            webView?.goForward()
                        } label: {
                            Image(systemName: "arrow.forward")
                        }
                        .keyboardShortcut(KeyEquivalent.rightArrow)
                    }
                }
            }
    }
}
