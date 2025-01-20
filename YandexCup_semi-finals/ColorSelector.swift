import SwiftUI

struct ColorSelector: View {
    @Binding var selectedColor: Color

    var body: some View {
        HStack(spacing: 20) {
            Circle().fill(Color.white).frame(width: 40, height: 40)
                .onTapGesture { selectedColor = .white }
            Circle().fill(Color.red).frame(width: 40, height: 40)
                .onTapGesture { selectedColor = .red }
            Circle().fill(Color.black).frame(width: 40, height: 40)
                .onTapGesture { selectedColor = .black }
            Circle().fill(Color.blue).frame(width: 40, height: 40)
                .onTapGesture { selectedColor = .blue }
        }
        .styleOverlay()
    }
}
