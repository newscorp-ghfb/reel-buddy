import UIKit

extension BuildDetailViewController {
    private struct Constants {
        static let build = "Build:"
        static let author = "Author:"
        static let status = "Status:"
        static let tag = "Tag:"
        static let summary = "Summary:"
        static let unknown = "unkwnown"
        static let noName = "no name"
        static let noMessage = "no message"
    }
}

final class BuildDetailViewController: UIViewController {
    @IBOutlet private weak var versionLabel: UILabel?
    @IBOutlet private weak var authorLabel: UILabel?
    @IBOutlet private weak var summaryLabel: UILabel?
    @IBOutlet private weak var statusLabel: UILabel?
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet private weak var installButton: UIButton?

    var build: BuildResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadNavigationBar()
        loadButton()

        versionLabel?.text = "\(Constants.build) \(build?.buildNumber ?? 0)"
        authorLabel?.text = "\(Constants.author) \(build?.commit.author ?? Constants.noName)"
        statusLabel?.text = "\(Constants.status) \(build?.status?.rawValue ?? Constants.unknown)"
        tagLabel?.text = "\(Constants.tag) \(build?.tag ?? Constants.unknown)"
        summaryLabel?.text = "\(Constants.summary) \(build?.commit.message ?? Constants.noMessage)"
    }

    private func reloadNavigationBar() {
        navigationItem.title = build?.tag ?? Constants.unknown
    }

    private func loadButton() {
        installButton?.isEnabled = build?.download != nil ? true : false
    }
}

extension BuildDetailViewController {
    @IBAction func onInstall(_ sender: Any) {
        guard let urlString = build?.download,
            let url = URL(string: urlString),
            UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url,
                                  options: [:],
                                  completionHandler: nil)
    }
}
