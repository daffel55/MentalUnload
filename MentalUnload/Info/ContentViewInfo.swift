//
//  ContentViewInfo.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 26.08.24.
//

import SwiftUI

struct ContentViewInfo: View {
    @State var showInfoStuff = false
    @State var showInfoCheckLists = false
    @State var showInfoSnapButton = false
    @State var showInfoMemorySupport = false
    @State var showInfoTags = false
    var body: some View {
        ZStack {
            NavigationStack {
                VStack{
                    Spacer()
                    Text("Vieles von dem, was du täglich im Kopf jonglieren musst und nicht vergessen solltest, kannst du hier abladen.")
                        .font(.title2).padding().background(Color.black).foregroundStyle(.white)
                    
                    List {
                        Section {
                            Text("Store Stuff").onTapGesture {
                                showInfoStuff = true
                            }
                            Text("Check Lists").onTapGesture {
                                showInfoCheckLists = true
                            }
                            Text("Automate Tasks").onTapGesture {
                                showInfoSnapButton = true
                            }
                            Text("Memory Support").onTapGesture {
                                showInfoMemorySupport = true
                            }
                            
                            
                        } header: {
                            Text("Die einzelnen Programmteile:")
                        }
                        
                        Section {
                            Text("Tags").onTapGesture {
                                showInfoTags = true
                            }
                        } header: {
                            Text("Kategorien")
                        }
                        Section {
                            Text("Imprint and Legal Stuff")
                        } header: {
                            Text("General Information")
                        }
                    footer: {
                        Text("Drücke auf die Bezeichnung, um weitere Informationen zu erhalten")
                    }
                    }
                    
                    
                    
                    .listRowBackground(Color.ocean)
                        .listRowSpacing(6)
                        .padding()
                        .navigationTitle("About Mental Unload")
                }
                
            }
        }.navigationDestination(isPresented: $showInfoStuff, destination: {
            InfoStuff()
        })
        .navigationDestination(isPresented: $showInfoCheckLists, destination: {
            InfoCheckLists()
        })
        .navigationDestination(isPresented: $showInfoSnapButton, destination: {
            InfoSnapButton()
        })
        .navigationDestination(isPresented: $showInfoMemorySupport, destination: {
            InfoMemorySupport()
        })
        .navigationDestination(isPresented: $showInfoTags, destination: {
            InfoTag()
        })
    }
}

#Preview {
    ContentViewInfo()
}
