import SwiftUI

struct ToolSelectorSection: View {
    @Binding var activeImage: String?
    @Binding var selectedFigureType: FigureType?
    @Binding var selectedColor: Color
    var addFigure: (FigureType) -> Void

    var body: some View {
        ToolSelectorView(activeImage: $activeImage, selectedFigure: $selectedFigureType)
            .overlay(
                Group {
                    if activeImage == "figures" {
                        FigureSelector(addFigure: addFigure)
                    } else if activeImage == "eclipsik" {
                        ColorSelector(selectedColor: $selectedColor)
                    }
                },
                alignment: .bottomTrailing
            )
    }
}
