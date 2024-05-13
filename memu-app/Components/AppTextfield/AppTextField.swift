//
//  EditAccountItem.swift
//  MimuAI
//
//  Created by user on 8/5/2024.
//

import SwiftUI

struct AppTextField: View {
    var label: String? = nil
    @Binding var editedField : String
    
    var body: some View {
        VStack {
            Text(label ?? "Name")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .fontWeight(.medium)
                .lineLimit(1)
                .frame(width: 350, alignment: .leading)
            
            TextField(label ?? "Name", text: $editedField)
                .padding()
                .font(.headline)
                .frame(width: 350, height: 55)
                .background(.regularMaterial)
        }.padding([.bottom], 25)
    }
}

#Preview {
    struct Preview: View {
        @State var field = ""
        var body: some View {
            AppTextField(label: "username" ,editedField: $field)
        }
    }

    return Preview()
}
