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
		view.backgroundColor = UIColor.whiteColor()
		title = "iOS开发常见词汇"

		tableView = UITableView(frame: view.bounds)
		tableView.dataSource = self
		tableView.delegate = self
		view.addSubview(tableView)

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
		cell.textLabel!.text = Catalog(rawValue: indexPath.section)!.words[indexPath.row]
	}
}