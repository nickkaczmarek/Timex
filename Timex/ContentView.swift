//
//  ContentView.swift
//  Timex
//
//  Created by Nick Kaczmarek on 7/20/21.
//

import SwiftUI

struct ContentView: View {
    private let timexUrl = "https://timex.apps.wwt.com"

    var body: some View {
        SafariWebView(mesgURL: timexUrl)
            .frame(minWidth: 400,
                   idealWidth: 1000,
                   maxWidth: .infinity,
                   minHeight: 500,
                   idealHeight: 800,
                   maxHeight: .infinity,
                   alignment: .center)
    }
}

struct SafariWebView: View {
    @ObservedObject var model: WebViewModel

    init(mesgURL: String) {
        //Assign the url to the model and initialise the model
        self.model = WebViewModel(link: mesgURL)
    }
    
    var body: some View {
        //Create the WebView with the model
        NSWKWebView(viewModel: model)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
