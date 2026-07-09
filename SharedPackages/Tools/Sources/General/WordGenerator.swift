/// Generates random placeholder words for sample navigation titles.
public struct WordGenerator {
    static let vocabulary = [
        "Apple", "Banana", "Galaxy", "Horizon", "Nebula",
        "Ocean", "Phantom", "Quantum", "Shadow", "Vortex"
    ]

    public static func next() -> String {
        return vocabulary.randomElement() ?? "Unknown"
    }
}
