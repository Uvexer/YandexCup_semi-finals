import SwiftUI

struct FigureSelector: View {
    var addFigure: (FigureType) -> Void

    var body: some View {
        HStack(spacing: 20) {
            Image("square").onTapGesture { addFigure(.square) }
            Image("circle").onTapGesture { addFigure(.circle) }
            Image("triangle").onTapGesture { addFigure(.triangle) }
            Image("up").onTapGesture { addFigure(.up) }
        }
        .styleOverlay()
    }
}
