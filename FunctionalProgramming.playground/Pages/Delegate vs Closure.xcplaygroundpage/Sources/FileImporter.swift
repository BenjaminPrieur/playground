import Foundation

public class FileImporter {
    // *********************************************************************
    // MARK: - Delegate
    public weak var delegate: FileImporterDelegate?

    public init() {
        self.configuration = .importAll
    }

    private func processFileIfNeeded(_ file: File) {
        guard let delegate = delegate else {
            // Uhm.... what to do here?
            return
        }

        let shouldImport = delegate.fileImporter(self, shouldImportFile: file)

        guard shouldImport else {
            return
        }

        process(file)
    }

    // *********************************************************************
    // MARK: - Configuration
    private let configuration: FileImporterConfiguration

    public init(configuration: FileImporterConfiguration) {
        self.configuration = configuration
    }

    private func processFileIfNeededThroughConfiguration(_ file: File) {
        let shouldImport = configuration.predicate(file)

        guard shouldImport else {
            return
        }

        process(file)
    }

    private func handle(_ error: Error) {
        configuration.errorHandler(error)
    }

    private func importDidFinish() {
        configuration.completionHandler()
    }

    func process(_ file: File) {}
}
