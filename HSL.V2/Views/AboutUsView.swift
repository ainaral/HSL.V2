//
//  AboutUsView.swift
//  HSL.V2
//
//  Created by iosdev on 30.3.2023.
//

import SwiftUI

struct AboutUsView: View {
    var body: some View {
        ScrollView{
            VStack{
                Text("Welcome to HSL.V2, the app helps you to stay connected with your local bus service, day or night. We understand that commuting can be stressful, especially during those dark and dim nights when it’s hard to see the bus. That’s why we’ve designed our app to help you track your bus’s location in real-time and get notifications when it’s approaching your stop. \n \n Our app uses location-based technology to ensure that you always have the most up-to-date information about your bus. You’ll receive notifications when your bus is approaching your stop, so you can be ready and waiting. \n \n We also have the speech-recognition technology that allows you to simply say to notify you when the bus is near out loud, and the app will notify you when the bus is coming. It’s simple but powerful tool that can make a big difference in your daily commute. \n \n But that’s not all, we’ve also added a special feature for people who are dealing with myopia, poor visibility, or any other vision issues. Our app will alert the driver that someone is waiting at the bus stop. \n \n We’re proud to offer a reliable, user-friendly app that helps make your daily commute a little easier. And with the focus on accessibility and inclusivity, we’re working hard to make sure that everyone can benefit from our app, no matter their abilities or challenges. \n \n Thank you for choosing HSL.V2 - we’re excited to be a part of your daily journey.")
                    .multilineTextAlignment(.leading)
                    .frame(width: 300)
            }
            .navigationTitle("About us")
            .navigationBarTitleDisplayMode(.inline)   
        }
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AboutUsView()
        }
    }
}
