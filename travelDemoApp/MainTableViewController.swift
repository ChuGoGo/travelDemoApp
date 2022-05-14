//
//  MainTableViewController.swift
//  travelDemoApp
//
//  Created by Chu Go-Go on 2022/4/28.
//

import UIKit

class MainTableViewController: UITableViewController,XMLParserDelegate {
//    辨識標籤資料
    var tagName:String? = nil
//    裝上一頁選擇的程式
    var region = ""
//   叫出每一筆資料
    var taiwanInfo: Taiwan?
//    儲存全部資料的Array
    var regionArray = [Taiwan]()
//    儲存需要地區資料的Array
    var nextPageArray = [Taiwan]()
//    收尋後儲存收尋到的Array
lazy var searchNextPageArray = [Taiwan]()
//    var pic:URL? = nil
//    var placePic: Taiwan?
//    var search = false
//    var result: SearchResponse?
//    儲存顯示出來的景點
//    var showPlace = [SearchResponse.XML_Head.Infos.Info?]()
//    var placeInfo: [SearchResponse.XML_Head.Infos.Info?] = []
//    接收第一頁的資料
    required init?(coder: NSCoder,region:String) {
        super.init(coder: coder)
        self.region = region
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//  解析Xml的檔案
        let url = Bundle.main.url(forResource: "tourism", withExtension: "xml")
//        從url抓資料
        if let xml = XMLParser(contentsOf: url!){
//            遵從 XMLParserDelegate 的 delegate
            xml.delegate = self
//            執行delegate裡面的func
            xml.parse()
        }
        chooseLocation(location: region)
        navigationItem.title = region
        searchNextPageArray = nextPageArray
        print("NextPageArray.count\(nextPageArray.count)")
        print("searchNextPageArray.count\(searchNextPageArray.count)")
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        self.tableView.reloadData()
//        print("regionArray總數\(regionArray.count)")
//        print("regionArray\(regionArray)")
        
//        print(nextPageArray)
//        chooseLocation()
        // Uncomment the following line to preserve selection between presentations

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return searchNextPageArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchNextPageArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(MainTableViewCell.self)", for: indexPath) as! MainTableViewCell
        let place = searchNextPageArray[indexPath.row]
        cell.titleLabel.text = place.Name
        cell.addLabel.text = place.Add
        cell.tickLabel.text = place.Ticketinfo
        cell.taiwanInfo = place
        cell.update()
        return cell
    }
    
    @IBSegueAction func moveToResult(_ coder: NSCoder) -> ResultViewController? {
        if let row = tableView.indexPathForSelectedRow?.row{
            return ResultViewController(coder: coder, taiwanInfo: searchNextPageArray[row])
        }else{
            return nil
        }
    }
    //    尋找需要的標籤
        func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
//            當遇到"Info"標籤時
            if elementName == "Info"{
//                如果tagName 不等於 nil
                if tagName != nil{
//                    建立一個taiwanInfo = Taiwan()來裝資料
                    taiwanInfo = Taiwan()
                }//如果標籤是Name時讓tagName = nil
            }else if elementName == "Name"{
                tagName = nil
                }else if elementName == "Region"{
                    tagName = nil
                }else if elementName == "Add"{
                    tagName = nil
                }else if elementName == "Ticketinfo"{
                    tagName = nil
                }else if elementName == "Keyword"{
                    tagName = nil
                }else if elementName == "Town"{
                    tagName = nil
                }else if elementName == "Description"{
                    tagName = nil
                }else if elementName == "Picture1"{
                    tagName = nil
                }else if elementName == "Opentime"{
                    tagName = nil
                }else if elementName == "Px"{
                    tagName = nil
                }else if elementName == "Py"{
                   tagName = nil
                }else if elementName == "Travellinginfo"{
                    tagName = nil
                }
    /*        switch elementName {
            case "Info":
                taiwanInfo = Taiwan()
            case "Name":
                tagName = nil
            case "Region":
    //            print("elementName\(elementName)")
                tagName = nil
            case "Add":
                tagName = nil
            case "Ticketinfo":
                tagName = nil
            case "Keyword":
                tagName = nil
            case "Town":
                tagName = nil
            case "Description":
                tagName = nil
            case "Picture1":
                tagName = nil
            default:
                tagName = elementName
            }
           */
        }
    //    存入需要的標籤
        func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
//            當遇到結尾標籤是"Info"
            if elementName == "Info"{
//                如果tagName不等於nil
                if tagName != nil{
//                  把資料裝進regionArray
                    regionArray.append(taiwanInfo!)
//                    變回nil抓下一筆資料
                    tagName = nil
                }
                }else if elementName == "Name"{
                    taiwanInfo?.Name = tagName
                }else if elementName == "Region",tagName == region{
                    taiwanInfo?.Region = tagName
                }else if elementName == "Add"{
                    taiwanInfo?.Add = tagName
                }else if elementName == "Ticketinfo"{
                    taiwanInfo?.Ticketinfo = tagName
                }else if elementName == "Keyword"{
                    taiwanInfo?.Keyword = tagName
                }else if elementName == "Town"{
                    taiwanInfo?.Town = tagName
                }else if elementName == "Description"{
                    taiwanInfo?.Description = tagName
                }else if elementName == "Picture1"{
                    taiwanInfo?.Picture1 = tagName
                }else if elementName == "Opentime"{
                    taiwanInfo?.Opentime = tagName
                }else if elementName == "Px"{
                    taiwanInfo?.Px = tagName
                }else if elementName == "Py"{
                    taiwanInfo?.Py = tagName
                }else if elementName == "Travellinginfo"{
                    taiwanInfo?.Travellinginfo = tagName
                }
            tagName = nil
        }
        func parser(_ parser: XMLParser, foundCharacters string: String) {
            if tagName == nil {
                tagName = string
            }else {
                tagName = tagName! + string
            }
//            print(tagName)
            
        }
        func chooseLocation(location: String){
//            print(regionArray.count)
            for foundregion in regionArray {
                if let palceRegion = foundregion.Region , palceRegion == location {
                    nextPageArray.append(foundregion)
    //                print("nextPageArray\(foundregion)")
                    
                    }
                }
            
            }
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as? MainTableViewCell
        cell?.task?.cancel()
        cell?.task = nil
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
//    func chooseLocation(){
//        updateData()
//        for info in placeInfo {
//            if let palceRegion = info?.Region , palceRegion == region{
//                showPlace.append(info)
//                print(showPlace)
//
//                }
//            }
//        }
    
//    func updatePic(){
   
}

extension MainTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("55555")
        if let searchText = searchController.searchBar.text,
           searchText.isEmpty == false {
            searchNextPageArray = nextPageArray.filter({ Taiwan in
                    return Taiwan.Name!.localizedStandardContains(searchText)
            })
        }else{
            print("nextPageArray\(nextPageArray)")
            searchNextPageArray = nextPageArray
        }
       
        tableView.reloadData()
        print(5555555)
    }
}

//extension MainTableViewController:UISearchBarDelegate{
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        searchNextPageArray = nextPageArray.filter({ taiwan.Name!.lowercased().
//            <#code#>
//        })
//    }
//}
