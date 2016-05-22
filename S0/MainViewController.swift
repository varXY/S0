//
//  ViewController.swift
//  S0
//
//  Created by 文川术 on 5/19/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

	var tableView: UITableView!

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor.backgroundBlack()

		let titleLabel = UILabel(frame: CGRectMake(0, 0, ScreenWidth - 60, 44))
		titleLabel.textColor = UIColor.commentGreen()
		titleLabel.font = UIFont.defaultFont(17)
		titleLabel.text = "// 开发常见词汇.swift"
		let titleItem = UIBarButtonItem(customView: titleLabel)
		navigationItem.leftBarButtonItem = titleItem

		let searchButton = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: #selector(searchButtonTapped))
		navigationItem.rightBarButtonItem = searchButton

		tableView = UITableView(frame: view.bounds)
		tableView.dataSource = self
		tableView.delegate = self
		tableView.backgroundColor = UIColor.clearColor()
		tableView.separatorStyle = .None
		tableView.sectionIndexColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
		tableView.sectionIndexBackgroundColor = UIColor.clearColor()
		view.addSubview(tableView)

	}

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(false, animated: true)
	}

	func searchButtonTapped() {

	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		print(#function)
	}


}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {

	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 26
	}

	func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return Catalog(rawValue: section)!.title
	}

	func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let label = UILabel(frame: CGRectMake(0, 0, 20, ScreenWidth))
		label.backgroundColor = UIColor.backgroundBlack()
		label.textColor = UIColor.statementYellow()
		label.text = " " + Catalog(rawValue: section)!.title
		label.font = UIFont.defaultFont(17)
		return label
	}

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return Catalog(rawValue: section)!.words.count
	}

	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 50
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier("cell")
		if cell == nil { cell = UITableViewCell(style: .Default, reuseIdentifier: "cell") }
		return cell
	}

	func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
		cell.backgroundColor = UIColor.backgroundBlack()
		cell.textLabel?.textColor = UIColor.stringRed()
		cell.textLabel?.font = UIFont.defaultFont(17)
		cell.textLabel!.text = Catalog(rawValue: indexPath.section)!.words[indexPath.row]
	}

	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		let detailVC = DetailViewController()
		detailVC.initTopDetailIndex = (indexPath.section, indexPath.row)
		navigationController?.pushViewController(detailVC, animated: true)
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
	}

	func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
		return ABC_XYZ
	}

}