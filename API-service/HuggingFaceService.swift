
import Foundation

actor HuggingFaceService {

    private let apiKey = "YOUR_HF_API_KEY"
    private let model = "google/flan-t5-base"

    func generate(prompt: String) async throws -> String {

        let url = URL(string:
            "https://api-inference.huggingface.co/models/\(model)"
        )!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "inputs": prompt,
            "parameters": [
                "max_new_tokens": 150,
                "temperature": 0.6
            ]
        ]

        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, response) = try await URLSession.shared.data(for: request)

        if let http = response as? HTTPURLResponse, http.statusCode == 429 {
            throw URLError(.cannotLoadFromNetwork)
        }

        let decoded = try JSONDecoder().decode([HFResponse].self, from: data)
        return decoded.first?.generated_text ?? "No output"
    }
}

struct HFResponse: Decodable {
    let generated_text: String
}
