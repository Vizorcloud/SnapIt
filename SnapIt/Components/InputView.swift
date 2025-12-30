//
//  InputView.swift
//  SnapIt
//
//  Created by Maxsem Garcia on 10/14/24.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    var isSecureField = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if isSecureField {
                SecureField(title, text: $text)
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                    .padding(.horizontal)
            } else {
                TextField(title, text: $text)
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                    .padding(.horizontal)
            }
        }
        .frame(width: UIScreen.main.bounds.width - 30, height: 60)
        .overlay(
            RoundedRectangle(cornerRadius: 10).stroke(Color(.black), lineWidth: 3)
                .frame(width: UIScreen.main.bounds.width - 50, height: 60)
                .opacity(0.4)
        )
    }
}

#Preview {
    InputView(text: .constant(""), title: "Email Address")
}
