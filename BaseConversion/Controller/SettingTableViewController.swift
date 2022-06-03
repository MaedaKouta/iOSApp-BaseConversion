//
//  SettingTableViewController.swift
//  BaseConversion
//
//  Created by 前田航汰 on 2022/05/31.
//

import UIKit

class SettingTableViewController: UITableViewController {


    @IBOutlet private weak var versionLabel: UILabel!
    private let reviewUrl = "https://apps.apple.com/jp/app/%E9%80%B2%E6%95%B0%E3%83%9E%E3%82%B9%E3%82%BF%E3%83%BC/id1581706168?mt=8&action=write-review"
    private let feedbackUrl = "https://forms.gle/dkDVq2x3QpDEYmPm6"
    private let privacyUrl = "https://tetoblog.org/base-conversion/privacy/"
    private let ruleUrl = "https://tetoblog.org/base-conversion/rule/"

    override func viewDidLoad() {
        super.viewDidLoad()
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        versionLabel.text = version
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == [0, 0] {
            reviewApp()
        } else if indexPath == [0, 1] {
            shareApp()
        } else if indexPath == [0, 2] {
            prepareWebView(url: feedbackUrl, title: "お問い合わせ")
        } else if indexPath == [1, 0] {
            prepareWebView(url: privacyUrl, title: "プライバシーポリシー")
        } else if indexPath == [1, 1] {
            prepareWebView(url: ruleUrl, title: "利用規約")
        }

        // 選択された色がスーっと消えていく
        tableView.deselectRow(at: indexPath, animated: true)
    }

    private func reviewApp() {
        if let url = URL(string: reviewUrl) {
            UIApplication.shared.open(url)
        }
    }

    private func prepareWebView(url: String, title: String) {
        guard let nextNC = storyboard?.instantiateViewController(withIdentifier: "WebViewNC") as? UINavigationController, let nextVC = nextNC.topViewController as? SettingWebViewController else {
            return
        }
        nextVC.navigationItem.title = title
        nextVC.catchUrl(url: url)
        present(nextNC, animated: true, completion: nil)
    }

    private func shareApp() {
        // TODO: 文字を考える
        let shareText = """
        進数計算アプリ
        「進数計算」

        シンプルに進数を計算することが出来ます
        """

        let activityItems = [shareText] as [Any]

        // 初期化処理
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)

        // iPadでクラッシュするため、iPadのみレイアウトの変更
        if let popoverController = activityVC.popoverPresentationController {
            popoverController.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
            popoverController.sourceView = self.view
            popoverController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        }
        self.present(activityVC, animated: true)
    }

    @IBAction func didTapExitButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
