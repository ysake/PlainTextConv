//
//  MainTableViewController.swift
//  PlainTextConv
//
//  Created by 酒井雄太 on 2017/06/11.
//  Copyright © 2017年 Yuuta Sakai. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import KRProgressHUD
import KRActivityIndicatorView

class MainTableViewController: UITableViewController {
    @IBOutlet var statusLabelOfPasteBoard: UITableViewCell!
    @IBOutlet var convToPlainTextButton: UITableViewCell!
    @IBOutlet var convertItems: [UITableViewCell]!

    let textConvertor     = TextConvertor()
    let generalPasteboard = UIPasteboard.general
    let notificationCentor = NotificationCenter.default
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationCentor.rx.notification(Notification.Name.UIApplicationDidBecomeActive, object: nil)
            .subscribe(onNext: { notification in
                self.updateStatusLabel()
                self.transferPasteboardContentsToTextConvertor()
            }).disposed(by: disposeBag)
        
        notificationCentor.post(name: .UIApplicationDidBecomeActive, object: nil)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                let tappedCell: UITableViewCell = self.tableView.cellForRow(at: indexPath)!
                if tappedCell == self.convToPlainTextButton {
                    print("tapped: \(tappedCell.textLabel?.text ?? "")")
                    self.transferPlainTextToPasteboardFromTextConvertor()
                    self.tableView.deselectRow(at: indexPath, animated: true)
                    self.showHUDofTransferCompletion()
                }
            }).disposed(by: disposeBag)
        
        convertItems.forEach { $0.textLabel?.isEnabled = false }
        convToPlainTextButton.textLabel?.isEnabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateStatusLabel() {
        statusLabelOfPasteBoard.textLabel?.text =
            generalPasteboard.hasStrings ? "テキストデータあり" : "テキストデータなし"
    }
    
    func showHUDofTransferCompletion() {
        KRProgressHUD.showSuccess(withMessage: "クリップボードにコピーしました")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
            KRProgressHUD.dismiss()
        }
    }
    
    func transferPasteboardContentsToTextConvertor() {
        if generalPasteboard.hasStrings {
            textConvertor.plainText = generalPasteboard.string!
        }
    }
    
    func transferPlainTextToPasteboardFromTextConvertor() {
        if let plainText = textConvertor.plainText {
            generalPasteboard.string = plainText
        }
    }
}
