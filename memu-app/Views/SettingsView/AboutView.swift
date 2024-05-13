//
//  AboutView.swift
//  MemuAI
//
//  Created by Kane Thuong on 13/05/2024.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Spacer(minLength: CGFloat(100))
            Text("Empowering Communication")
                .font(.headline)
            
            Text("""
                    MemuAI is dedicated to making everyday conversations inclusive for everyone. Our app translates sign language into text and speech in real-time, breaking down communication barriers and fostering understanding between the hearing and the deaf communities.
                    """)
            .font(.body)
            
            Spacer()
            
            Text("Key Features:")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 10) {
                FeatureView(icon: "video.fill", featureText: "Real-time sign language translation into text and speech.")
                FeatureView(icon: "person.fill.viewfinder", featureText: "Live video processing for on-the-go interactions.")
                FeatureView(icon: "message.fill", featureText: "Enables seamless communication with those who do not understand sign language.")
            }
            
            Spacer()
            
            Text("Join us in bridging the gap in communication and embracing inclusivity with MemuAI.")
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

struct FeatureView: View {
    let icon: String
    let featureText: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 30, height: 30)
            Text(featureText)
                .font(.body)
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}



