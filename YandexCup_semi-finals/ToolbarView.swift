import SwiftUI

struct ToolbarView: View {
    var body: some View {
        HStack {
            HStack(spacing: 20) {
                Image("left")
                Image("right")
            }
            Spacer(minLength: 40)
            
            HStack(spacing: 20) {
                Image("trash")
                Image("adds")
                Image("stratum")
            }
            Spacer(minLength: 40)
            
            HStack(spacing: 20) {
                Image("stop")
                Image("play")
            }
        }
        .padding(.horizontal, 40)
    }
}
