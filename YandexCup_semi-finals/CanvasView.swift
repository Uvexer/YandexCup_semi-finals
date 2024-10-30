import SwiftUI

struct CanvasView: View {
    @Binding var activeImage: String?
    
    @State private var drawingPaths: [PathData] = []
    @State private var currentPath = Path()
    
    struct PathData {
        var path: Path
        var isEraser: Bool
    }
    
    var body: some View {
        ZStack {
            Image("paper")
                .resizable()
                .scaledToFit()
                .cornerRadius(20)
                .padding(.horizontal, 16)
            
            Canvas { context, size in
                for pathData in drawingPaths {
                    if pathData.isEraser {
                        context.blendMode = .destinationOut
                        context.fill(pathData.path, with: .color(.black))
                    } else {
                        context.blendMode = .normal
                        context.stroke(pathData.path, with: .color(.black), lineWidth: 2)
                    }
                }
                
                if activeImage == "pencil" {
                    context.blendMode = .normal
                    context.stroke(currentPath, with: .color(.black), lineWidth: 2)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if activeImage == "pencil" {
                            if currentPath.isEmpty {
                                currentPath.move(to: value.location)
                            } else {
                                currentPath.addLine(to: value.location)
                            }
                        } else if activeImage == "eraser" {
                            let eraserRadius: CGFloat = 10
                            var erasePath = Path()
                            erasePath.addEllipse(in: CGRect(x: value.location.x - eraserRadius, y: value.location.y - eraserRadius, width: eraserRadius * 2, height: eraserRadius * 2))
                            drawingPaths.append(PathData(path: erasePath, isEraser: true))
                        }
                    }
                    .onEnded { _ in
                        if activeImage == "pencil" {
                            drawingPaths.append(PathData(path: currentPath, isEraser: false))
                            currentPath = Path()
                        }
                    }
            )
        }
        .frame(maxWidth: .infinity, maxHeight: 1000)
    }
}

