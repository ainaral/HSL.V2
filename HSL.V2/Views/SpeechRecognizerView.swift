//
//  MicView.swift
//  HSL.V2
//
//  Created by iosdev on 30.3.2023.
//

import SwiftUI

struct SpeechRecognizerView: View {
    let lightBlue = Color.blue.opacity(0.7)
    let moreLightBlue = Color.blue.opacity(0.4)
    let darkBlue = Color(red: 0.0, green: 0.0, blue: 0.5)
    
    // @State private var transcribedText: String = ""

    var body: some View {
        VStack {
            Text("Click on the mic icon and start talking.")
                .font(.system(size: 25))
                .foregroundColor(darkBlue)
                .multilineTextAlignment(.center)
            
            Text("Hint:\n \"Notify me when bus 510 is 1 stop away\"")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.top, 20)
            
            ZStack {
                Circle()
                    .fill(.blue)
                    .frame(width: 160, height: 160)
                Circle()
                    .stroke(lightBlue, lineWidth: 20)
                    .frame(width:180, height: 180)
                Circle()
                    .stroke(moreLightBlue, lineWidth: 20)
                    .frame(width:220, height: 220)
                
                Button(action: {
                    // code to start speech recognition
                }) {
                    Image(systemName: "mic")
                        .font(.system(size: 80))
                        .foregroundColor(darkBlue)
                }
                VStack {
                    Spacer()
                    Rectangle()
                        .fill(moreLightBlue)
                        .frame(width: 300, height: 120)
                        .cornerRadius(15)
                        .overlay(
                            VStack {
                                Text("Your text will appear here...")
                                    .foregroundColor(.black)
                                Spacer()
                                HStack {
                                    Button(action: {
                                        // code to handle "Edit" button tapped
                                    }) {
                                        Text("Edit")
                                            .foregroundColor(.black)
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: 10)
                                    .padding()
                                    .background(lightBlue)
                                    .cornerRadius(30)
                                    
                                    Button(action: {
                                        // code to handle "Save" button tapped
                                    }) {
                                        Text("Save")
                                            .foregroundColor(.black)
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: 10)
                                    .padding()
                                    .background(lightBlue)
                                    .cornerRadius(30)
                                }
                            }
                        )
                }
            }
        }
    }
}

struct SpeechRecognizerView_Previews: PreviewProvider {
    static var previews: some View {
        SpeechRecognizerView()
    }
}

