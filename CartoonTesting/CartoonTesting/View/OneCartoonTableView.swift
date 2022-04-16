//
//  OneCartoonTableView.swift
//  CartoonTest
//
//  Created by Mikhail Kim on 15.04.2022.
//

import Foundation
import UIKit

class OneCartoonTableView: UITableViewController {
    
    private var CartoonNetwork: apiCartoon?
    private var characters: [Result] = []
    private var isPagination = false
    var nextPage:String? = ApiData.shared.firstPage
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 160

    }
    private func createSpinerFooret() -> UIView{
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height:100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        spinner.style = .medium
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let position = scrollView.contentOffset.y
        if position > (scrollView.contentSize.height - scrollView.frame.height){
            
            if !isPagination {
                self.tableView.tableFooterView = createSpinerFooret()
                isPagination = true
                
                // last page loaded
                if nextPage == nil{
                    tableView.tableFooterView = nil
                    isPagination = true
                    return
                }
                
                guard let nextPage = nextPage else { return }
                
                ApiData.shared.get20Sheets(urlString: nextPage, responce: {[weak self] character, error in
                    if error == nil{
                        guard let character = character else {return}
                        self?.characters.append(contentsOf: character.results)
                        self?.nextPage = character.info.next
                        self?.tableView.reloadData()
                    }
                    else {
                        print(error!.localizedDescription)
                    }
                    self?.tableView.tableFooterView = nil
                    self?.isPagination = false
                })
            }
            else { return }
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TableViewCell{
            
            let item = characters[indexPath.row]
            cell.configure(with: item)
            return cell
        }
        
        return UITableViewCell()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailController = storyboard.instantiateViewController(identifier: "Detail") as? TwoCartoonView else{return}

        let item = characters[indexPath.row]

        detailController.id = item.id
        show(detailController, sender: nil)
    }
    
    
    private func apiData(from url: String?) {
        apiTest.shared.apiData(from: url) {  CartoonNetwork in
            self.CartoonNetwork = CartoonNetwork
            self.tableView.reloadData()
        }
    }
}
