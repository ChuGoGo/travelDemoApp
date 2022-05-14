//
//  ViewController.swift
//  travelDemoApp
//
//  Created by Chu Go-Go on 2022/4/28.
//

import Foundation
import UIKit
import MapKit

class FristViewController: UIViewController,CLLocationManagerDelegate{
    @IBOutlet weak var locationPicker: UIPickerView!
    //    PickerView資料
    var Regions = ["臺北市","新北市","桃園市","臺中市","臺南市","高雄市","新竹縣","苗栗縣","彰化縣","南投縣","雲林縣","嘉義縣","屏東縣","宜蘭縣","花蓮縣","臺東縣","澎湖縣","金門縣","連江縣","基隆市","新竹市","嘉義市"]
    //    裝抓到的縣市
    var region = ""
    //    選擇第幾比
    var selectedRow = 0
    //    確認是否允許使用使用者的地點
    let locationManager = CLLocationManager()
//    原本在第一頁要抓資料
    //    var taiwanInfo: Taiwan?
    //    var regionArray = [Taiwan]()
    //    var nextPageArray = [Taiwan]()
    //    var pic:URL? = nil
    //    var placeinfos: Infos = Infos()
    //    var regionPickerView = UIPickerView()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedRow = 0
        //        PickerView的delegate設定為 程式本身
        locationPicker.delegate = self
        //        詢問是否同意使用自己的定位
        locationManager.requestWhenInUseAuthorization()
        //        CLLocationManager的delegate的設定為 程式本身
        locationManager.delegate = self
        // Do any additional setup after loading the view.
    }
//    button的Action
    @IBAction func locationButton(_ sender: UIButton) {
//        確認是否抓對資料
        print(region)
    }
//    傳遞資料的SegueAction
    @IBSegueAction func regionSegue(_ coder: NSCoder) -> MainTableViewController? {
//        儲存抓到的資料是哪一筆
        let regionSelectedRow = Regions[selectedRow]
//        將選擇好的縣市傳送到下一頁
        return MainTableViewController(coder: coder, region: regionSelectedRow)
    }
    
}
//外掛套件UIPickerViewDelegate,UIPickerViewDataSource
extension FristViewController:UIPickerViewDelegate,UIPickerViewDataSource{
//    PickerView的數量
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //        placeInfo[index].Region.count
        return Regions.count
    }
//    titleForRow捲動到那筆顯示的地區
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        顯示選擇的地區
        return Regions[row]
    }
// didSelectRow確認抓到是資料裡的哪一筆
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 抓到的是第幾個
        selectedRow = row
        // 儲存確認抓到的是哪個地區
        region = Regions[selectedRow]
        //        print(region)
    }
//    有幾個PickerView捲簾
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}
