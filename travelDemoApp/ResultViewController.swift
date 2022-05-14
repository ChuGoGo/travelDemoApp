//
//  ResultViewController.swift
//  travelDemoApp
//
//  Created by Chu Go-Go on 2022/5/2.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var resultImageVIew: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var addLabel: UILabel!
    @IBOutlet weak var openInfoLabel: UILabel!
    

    var taiwanInfo:Taiwan?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: taiwanInfo?.Picture1 ?? "https://www.greatearth.com.tw/eweb_hsinchu/images/default_demo.jpg") {
                    URLSession.shared.dataTask(with: url) { data, response, error in
                        if let error = error {
                            print(error)
                            return
                        }
                        guard let response = response as? HTTPURLResponse,
                              response.statusCode == 200 else {
                            return
                        }
                        if let data = data {
                            let locationImage = UIImage(data: data)
                            DispatchQueue.main.async {
                                self.resultImageVIew.image = locationImage
                                self.descriptionTextView.text = self.taiwanInfo?.Description
                                self.addLabel.text = self.taiwanInfo?.Add
                                self.openInfoLabel.text = self.taiwanInfo?.Opentime
                            }
                        }
        
                    }.resume()
        
            }
        //        if let picUrl = URL(string: placePic?.Picture1 ?? "noimage.jpg"){
        //            cell.LocationImageView.kf.setImage(with: picUrl)
        //        }
        
        navigationItem.title = taiwanInfo?.Name
        // Do any additional setup after loading the view.
    }
    
    required init?(coder: NSCoder,taiwanInfo:Taiwan) {
        super.init(coder: coder)
        self.taiwanInfo = taiwanInfo
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBSegueAction func mapSegueAction(_ coder: NSCoder) -> MapViewController? {
        return MapViewController(coder: coder, taiwanInfo: taiwanInfo!)
    }
    
    

}
