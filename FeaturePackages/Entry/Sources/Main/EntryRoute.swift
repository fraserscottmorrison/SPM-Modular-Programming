// Authored by Fraser Scott-Morrison

import Tools

/// Represents the navigation destinations in the Entry module.
public enum EntryRoute: String, Route {
    case tabStack

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
