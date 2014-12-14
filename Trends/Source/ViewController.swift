//
//  ViewController.swift
//  Trends
//
//  Created by Marcin Kuptel on 12/12/2014.
//  Copyright (c) 2014 Marcin Kuptel. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MKWordListProviderDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    private let _wordListProvider: MKWordListProvider = MKWordListProviderFactory.wordListProvider
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        _wordListProvider.delegate = self
        _wordListProvider.fetchWordList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MKWordListProviderDelegate
    func wordListFetched(wordList: Array<(String, Int)>)
    {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
    }
    
    //UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _wordListProvider.wordList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("MKWordCell") as UITableViewCell
        
        let (word, count) = _wordListProvider.wordList[indexPath.row]
        cell.textLabel?.text = String(format: "%@: %i", word, count)
        
        return cell
    }
    
}

