//
//  EditSettingsView.swift
//  memu-app
//
//  Created by Jonathan on 9/5/2024.
//

import SwiftUI

struct EditAccountView: View {
    //wrapper for user default
    @AppStorage("name") var name: String = ""
    @AppStorage("email") var email: String = ""
    @AppStorage("phoneNum") var phoneNum: String = ""
    @Environment(\.dismiss) var dismissView
    
    @State var nameField = ""
    @State var emailField = ""
    @State var phoneNumField = ""
    
    @State var message = ""
    @State var showAlert = false
    @State var exitScreen = false
    
    //update user default
    func saveDetails(){
        name = nameField
        email = emailField
        phoneNum = phoneNumField
        
        message = "Account Updated"
        showAlert = true
        exitScreen = true
    }
    
    //initialize the user details on the screen
    func initializeValues(){
        nameField = name
        emailField = email
        phoneNumField = phoneNum
        exitScreen = false
    }
    
    //checks if email address is valid
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    //checks if phone number is valid
    func isValidPhoneNum(phoneNum: String) -> Bool {
        let phoneNumRegEx = #"^(\+61|0)([0-9]){9}$"#

        let phoneNumPred = NSPredicate(format:"SELF MATCHES %@", phoneNumRegEx)
        return phoneNumPred.evaluate(with: phoneNum)
    }
    
    //verify the saved detail. will return false if it is not valid
    func verifyDetails() -> Bool{
        guard !nameField.isEmpty else{
            message = "Name cannot be empty"
            showAlert = true
            return false
        }
        
        guard !emailField.isEmpty else{
            message = "Email cannot be empty"
            showAlert = true
            return false
        }
        
        guard isValidEmail(email:emailField) else{
            message = "Please enter a valid email address"
            showAlert = true
            return false
        }
        
        
        guard !phoneNumField.isEmpty else{
            message = "Phone number cannot be empty"
            showAlert = true
            return false
        }
        
        guard isValidPhoneNum(phoneNum: phoneNumField) else{
            message = "Please enter a valid phone number"
            showAlert = true
            return false
        }
        return true
    }
    
    var body: some View {
        ZStack {
            VStack {
                Image("Avatar6")
                    .resizable()
                    .frame(width:64,height:64)
                    .clipShape(.circle)
                    .padding()
                VStack {
                    AppTextField(label: "Name", editedField: $nameField)
                    AppTextField(label: "Email", editedField: $emailField)
                    AppTextField(label: "Phone Number", editedField: $phoneNumField)

                    //button to update user details
                    SimpleButton(label:"Confirm", action: {
                        if verifyDetails() {
                            saveDetails()
                        }
                    })
                }
                Spacer()
            }
            .padding(.top, 150)
        }
        .ignoresSafeArea()
        .onAppear(){
            initializeValues()
        }
        //alert to display warning
        .alert(message, isPresented: $showAlert){
            Button("OK", role: .cancel) {
                if exitScreen {
                    dismissView()
                }
            }
        }
    }
}

#Preview {
    EditAccountView()
}
