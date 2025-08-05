//
//  LoadingView.swift
//  Users
//
//  Created by Yü Li Chang on 05.08.25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            ProgressView()
                .progressViewStyle(.circular)
                .scaleEffect(1.5)
        }
    }
}

#Preview {
    LoadingView()
}
