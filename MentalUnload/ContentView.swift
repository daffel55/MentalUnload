//
//  ContentView.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 26.07.24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    //@EnvironmentObject var router: Router
    
    @State var showStuffView = false
    @State var showCheckLists = false
    @State var showSnapButton = false
    @State var showMemorySupport = false
    @State var showTagView = false
    @State var showInfoView = false
    
    var body: some View {
        NavigationStack {
        ZStack {
 
            Color.background.ignoresSafeArea()
            Image("loadhere").resizable().aspectRatio(contentMode: .fit).offset(x: 0, y: -120)
            VStack {
                HStack {
                    Text("Mental Unload").font(.system(size: 50)).bold().foregroundStyle(.white).padding().padding(.trailing,0)
                    Image(systemName: "info.circle").font(.title).foregroundStyle(.white).padding(.leading,0)
                        .onTapGesture {
                            showInfoView = true
                        }
                }.frame(maxWidth: .infinity).background(Color.background)
                Spacer()
                VStack(alignment: .leading, spacing: 15) {
                    
                    Button {
                        showStuffView = true
                    } label: {
                        HStack {
                            Image(systemName: "archivebox")
                            Text("Store Stuff")
                            Spacer()
                            Image(systemName: "arrow.right")
                        }
                    }.padding(.top, 20)
                    //                        Divider()
                    Button {
                        showCheckLists = true
                    } label: {
                        HStack {
                            Image(systemName: "checkmark.square")
                            Text("Check Lists")
                            Spacer()
                            Image(systemName: "arrow.right")
                        }
                    }
                    
                    Button {
                        showSnapButton = true
                    } label: {
                        HStack {
                            Image(systemName: "repeat.circle")
                            Text("Automate Tasks")
                            Spacer()
                            Image(systemName: "arrow.right")
                        }
                    }
                    Button  {
                        showMemorySupport = true
                    } label: {
                        HStack {
                            Image(systemName: "square.and.pencil")
                            Text("Support Your Memory")
                            Spacer()
                            Image(systemName: "arrow.right")
                        }
                    }
                    Divider()
                    Button {
                        showTagView = true
                    } label: {
                        HStack {
                            Image(systemName: "tag")
                            Text("Tags")
                            Spacer()
                            Image(systemName: "arrow.right")
                        }.foregroundStyle(.black.opacity(0.6))
                    }
                }
                .font(UIDevice.isIPad ? .largeTitle : .title)
                .foregroundColor(.black)
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
                .frame(maxWidth: 500)
                .background(Rectangle().fill(Color.navigationBackground).shadow(radius: 10))
            }
        }
        .navigationDestination(isPresented: $showTagView, destination: {
            ContentViewTags()
        })
        .navigationDestination(isPresented: $showStuffView, destination: {
            ContentViewStuff()
        })
        .navigationDestination(isPresented: $showCheckLists, destination: {
            ContentViewCheckList()
        })
        .navigationDestination(isPresented: $showSnapButton, destination: {
            ContentViewSnapButton()
        })
        .navigationDestination(isPresented: $showMemorySupport, destination: {
            ContentViewMemorySupport()
        })
        .navigationDestination(isPresented: $showInfoView, destination: {
            ContentViewInfo()
        })

    }
            
            
        
        
    }
    
    
    
    func textWithArrow(text: String) -> String {
        "\(text) \(Image(systemName: "arrow.right"))"
    }
    
    
}



