import SwiftUI

struct ToolbarSection: View {
    @Binding var activeImage: String?
    @Binding var isStratumViewPresented: Bool

    var body: some View {
        ToolbarView(
            clearAction: { activeImage = "trash" },
            undoAction: { activeImage = "left" },
            redoAction: { activeImage = "right" },
            saveFrameAction: { activeImage = "clear" },
            stratumAction: { isStratumViewPresented = true }
        )
    }
}
