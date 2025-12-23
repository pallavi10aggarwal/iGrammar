
import Foundation

@MainActor
final class GrammarViewModel: ObservableObject {

    @Published var inputText = ""
    @Published var outputText = ""
    @Published var isLoading = false
    @Published var error: String?

    private let service = HuggingFaceService()

    func process(action: AIAction) async {
        guard !inputText.isEmpty else { return }

        isLoading = true
        error = nil

        do {
            let prompt = action.prompt(for: inputText)
            outputText = try await service.generate(prompt: prompt)
        } catch {
            // Mock fallback if API fails
            outputText = "[Mock Response]\n" + inputText.capitalized
            self.error = "API limit reached – showing mock output."
        }

        isLoading = false
    }
}
