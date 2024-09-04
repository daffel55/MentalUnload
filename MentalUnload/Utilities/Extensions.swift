//
//  Extensions.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 27.07.24.
//



import SwiftUI

struct OptionalSearchable: ViewModifier{
    let isSearchable: Bool
    @Binding var searchString: String
    let text: String
    func body(content: Content) -> some View {
        switch isSearchable{
        case true:
            content
                .searchable(text: $searchString, prompt: text)
        case false:
            content
        }
    }
}

extension UIDevice {
    static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isIPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
}

struct ScreenMessurement {
    static var isLandscape : Bool {
        UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight
    }
    static var isIPad : Bool {
        UIDevice.current.localizedModel == "iPad"
    }
    
    static var isIPadInLandscape : Bool {
        self.isIPad && self.isLandscape
    }
}

struct FrameForIPad : ViewModifier {
    var active : Bool
    
    @ViewBuilder func body(content: Content) -> some View {
        if active {
            content.frame(width: 800)
        } else {
            content
        }
    }
}

extension View {
    func frameForIPad(active: Bool) -> some View {
        modifier(FrameForIPad(active: active))
    }
}
