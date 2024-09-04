////
////  Router.swift
////  MentalUnload
////
////  Created by Dagmar Feldt on 25.08.24.
////
//
//import SwiftUI
//
//
//final class Router: ObservableObject {
//    
//    public enum Destination: Codable, Hashable {
//        case stuff
//        case checklist
//        case snapbutton
//        case memorysupport
//    }
//    
//    var navPath = NavigationPath()
//    
//    func navigate(to destination: Destination) {
//        
//        navPath.append(destination)
//    }
//    
//    func navigateBack() {
//        navPath.removeLast()
//    }
//    
//    func navigateToRoot() {
//        navPath.removeLast(navPath.count)
//    }
//}
