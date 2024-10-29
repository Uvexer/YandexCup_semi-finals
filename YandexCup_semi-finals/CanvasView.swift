import SwiftUI

struct CanvasView: View {
    @Binding var lines: [[CGPoint]]
    @Binding var activeImage: String?

    var body: some View {
        ZStack {
            Image("paper")
                .resizable()
                .scaledToFit()
                .cornerRadius(20)
                .padding(.horizontal, 16)
            
            Canvas { context, size in
                for line in lines {
                    var path = Path()
                    if let firstPoint = line.first {
                        path.move(to: firstPoint)
                        for point in line.dropFirst() {
                            path.addLine(to: point)
                        }
                    }
                    context.stroke(path, with: .color(.black), lineWidth: 2)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if activeImage == "pencil" {
                            lines[lines.count - 1].append(value.location)
                        }
                    }
                    .onEnded { _ in
                        if activeImage == "pencil" {
                            lines.append([])
                        }
                    }
            )
        }
        .frame(maxWidth: .infinity, maxHeight: 1000)
    }
}
