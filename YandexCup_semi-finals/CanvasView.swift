import SwiftUI

struct CanvasView: View {
    @Binding var activeImage: String?

    @State private var drawingPath = Path()
    @State private var erasedPath = Path()

    var body: some View {
        ZStack {
            Image("paper")
                .resizable()
                .scaledToFit()
                .cornerRadius(20)
                .padding(.horizontal, 16)

            Canvas { context, size in
             
                context.stroke(drawingPath, with: .color(.black), lineWidth: 2)

                
                context.blendMode = .destinationOut
                context.fill(erasedPath, with: .color(.black))
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if activeImage == "pencil" {
                          
                            if drawingPath.isEmpty {
                                drawingPath.move(to: value.location)
                            } else {
                                drawingPath.addLine(to: value.location)
                            }
                        } else if activeImage == "eraser" {
                          
                            let eraserRadius: CGFloat = 10
                            let eraseRect = CGRect(x: value.location.x - eraserRadius, y: value.location.y - eraserRadius, width: eraserRadius * 2, height: eraserRadius * 2)
                            erasedPath.addEllipse(in: eraseRect)
                        }
                    }
                    .onEnded { _ in
                        if activeImage == "eraser" {
                           
                            erasedPath = erasedPath
                        }
                    }
            )
        }
        .frame(maxWidth: .infinity, maxHeight: 1000)
    }
}

