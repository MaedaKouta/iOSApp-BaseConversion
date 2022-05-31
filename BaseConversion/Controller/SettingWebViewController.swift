//
//  SettingWebViewController.swift
//  BaseConversion
//
//  Created by 前田航汰 on 2022/05/31.
//

import UIKit
import WebKit

class SettingWebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate  {

    @IBOutlet private weak var webView: WKWebView!
    @IBOutlet private weak var backButton: UIBarButtonItem!
    @IBOutlet private weak var forwardButton: UIBarButtonItem!
    private var presentUrl = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        webView.uiDelegate = self
        if let url = URL(string: presentUrl) {
            self.webView.load(URLRequest(url: url))
        } else {
            print("URLが取得できませんでした。")
        }
        judgeToolBarButton()
    }

    @IBAction private func didTapBackButton(_ sender: Any) {
        webView.goBack()
    }

    @IBAction private func didTapForwardButton(_ sender: Any) {
        webView.goForward()
    }

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("読み込み開始")
        judgeToolBarButton()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("読み込み完了")
        judgeToolBarButton()
    }

    private func judgeToolBarButton() {
        if webView.canGoBack {
            backButton.isEnabled = true
        } else {
            backButton.isEnabled = false
        }

        if webView.canGoForward {
            forwardButton.isEnabled = true
        } else {
            forwardButton.isEnabled = false
        }
    }

    @IBAction func didTapExitButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    func catchUrl(url: String) {
        presentUrl = url
    }

}
