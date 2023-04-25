//
//  SearchPassengerView.swift
//  HSL.V2
//
//  Created by iosdev on 17.4.2023.
//

import SwiftUI

struct SearchPassengerView: View {
    // The `showSearchScreen` property is a binding that indicates whether the search screen should be shown or hidden.
    @Binding var showSearchScreen: Bool
    
    @StateObject private var viewModel = PassengerViewModel()
    
    
    
    @State private var isDragging = false
    
    @State var busNum: String = ""
    
    @State private var currentHeight: CGFloat = 200
    
    let minHeight: CGFloat = 100
    let maxHeight: CGFloat = 700
    
    var body: some View {
        ZStack(alignment: .bottom){
            if showSearchScreen {
                // Show the search screen if showSearchScreen is true
                mainView
                    .transition(.move(edge: .bottom))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut)
        
    }
    
    var mainView: some View {
        VStack {
            ZStack{
                Capsule()
                    .frame(width: 40, height: 6)
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.00001))
            .gesture(dragGesture) // apply the gesture to the main view
            
            ZStack {
                VStack {
                    searchBus(searchText: $viewModel.searchText)
                        .padding(.bottom, 50)
//                    Form {
//                        List {
//                            Text("To A")
//                            Text("To B")
//                        }
//                    }
                }
                .frame(height: currentHeight)
                .frame(maxWidth: .infinity)
            }
            .animation(isDragging ? nil : .easeInOut(duration: 0.45))
        }
    }
    // The `prevDragTranslation` property is used to keep track of the previous drag translation.
    @State private var prevDragTranslation = CGSize.zero
    
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged { val in
                if !isDragging {
                    isDragging = true
                }
                let dragAmount = val.translation.height - prevDragTranslation.height
                if currentHeight > maxHeight || currentHeight < minHeight {
                    currentHeight -= dragAmount / 6
                } else {
                    currentHeight -= dragAmount
                }
                prevDragTranslation = val.translation
            }
            .onEnded { val in
                prevDragTranslation = .zero
                isDragging = false
                if currentHeight > maxHeight {
                    currentHeight = maxHeight
                }else if currentHeight < minHeight{
                    currentHeight = minHeight
                }
            }
    }
}
    

struct SearchPassangerView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPassengerView(showSearchScreen: .constant(true))
        // PassengerView()
    }
}
