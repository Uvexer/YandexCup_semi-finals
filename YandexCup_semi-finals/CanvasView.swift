import SwiftUI

struct CanvasView: View {
    @Binding var activeImage: String?
    var undoAction: () -> Void
    var redoAction: () -> Void
    
    @State private var drawingPaths: [PathData] = []
    @State private var currentPath = Path()
    @State private var undoStack: [[PathData]] = []
    @State private var redoStack: [[PathData]] = []
    
    struct PathData {
        var path: Path
        var isEraser: Bool
        var lineWidth: CGFloat
        var color: Color
    }
    
    func clearCanvas() {
        drawingPaths.removeAll()
        undoStack.removeAll()
        redoStack.removeAll()
    }
    
    private func performUndo() {
        guard !drawingPaths.isEmpty else { return }
        redoStack.append(drawingPaths)
        drawingPaths = undoStack.popLast() ?? []
    }
    
    private func performRedo() {
        guard let redoPaths = redoStack.popLast() else { return }
        undoStack.append(drawingPaths)
        drawingPaths = redoPaths
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
                        context.stroke(pathData.path, with: .color(pathData.color), lineWidth: pathData.lineWidth)
                    }
                }
                
                if activeImage == "pencil" || activeImage == "brush" {
                    let lineWidth: CGFloat = activeImage == "brush" ? 6 : 2
                    let color: Color = activeImage == "brush" ? .blue : .black
                    context.blendMode = .normal
                    context.stroke(currentPath, with: .color(color), lineWidth: lineWidth)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if activeImage == "pencil" || activeImage == "brush" {
                            if currentPath.isEmpty {
                                currentPath.move(to: value.location)
                            } else {
                                currentPath.addLine(to: value.location)
                            }
                        } else if activeImage == "eraser" {
                            let eraserRadius: CGFloat = 10
                            var erasePath = Path()
                            erasePath.addEllipse(in: CGRect(x: value.location.x - eraserRadius, y: value.location.y - eraserRadius, width: eraserRadius * 2, height: eraserRadius * 2))
                            drawingPaths.append(PathData(path: erasePath, isEraser: true, lineWidth: eraserRadius * 2, color: .black))
                        }
                    }
                    .onEnded { _ in
                        if activeImage == "pencil" || activeImage == "brush" {
                            let lineWidth: CGFloat = activeImage == "brush" ? 6 : 2
                            let color: Color = activeImage == "brush" ? .blue : .black
                            undoStack.append(drawingPaths)
                            drawingPaths.append(PathData(path: currentPath, isEraser: false, lineWidth: lineWidth, color: color))
                            currentPath = Path()
                            redoStack.removeAll()
                        }
                    }
            )
        }
        .frame(maxWidth: .infinity, maxHeight: 1000)
        .onChange(of: activeImage) {
            if activeImage == "trash" {
                clearCanvas()
                activeImage = nil
            } else if activeImage == "left" {
                performUndo()
                activeImage = nil
            } else if activeImage == "right" {
                performRedo()
                activeImage = nil
            }
        }
    }
}

