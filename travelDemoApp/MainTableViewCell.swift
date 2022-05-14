//
//  MainTableViewCell.swift
//  travelDemoApp
//
//  Created by Chu Go-Go on 2022/4/28.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var LocationImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addLabel: UILabel!
    @IBOutlet weak var tickLabel: UILabel!
    

    var taiwanInfo:Taiwan!
    var task: URLSessionDataTask?
    var safeurl: URL!
    

    func fetchImage(url:URL, completion: @escaping(UIImage?)->Void) {
        
      task = URLSession.shared.dataTask(with: url) { data, response, error in
                          if let error = error {
                              print(error)
                              return
                          }
                          guard let response = response as? HTTPURLResponse,
                                response.statusCode == 200 else {
                              return
                          }
            if let data = data
                ,let image = UIImage(data: data){
                    completion(image)
            }else{
                completion(nil)
            }
          self.task = nil
        }
        task?.resume()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func madeUrl()->URL{
//
//        if let url = URL(string: taiwanInfo.Picture1 ?? "https://www.greatearth.com.tw/eweb_hsinchu/images/default_demo.jpg") {
//            safeurl = url
//        }else{
//            safeurl = URL(string: "https://www.greatearth.com.tw/eweb_hsinchu/images/default_demo.jpg")
//        }
//
//        return safeurl
//    }
    func update(){
        let title = taiwanInfo?.Name
        titleLabel.text = title
        fetchImage(url: URL(string: taiwanInfo.Picture1 ?? "https://www.greatearth.com.tw/eweb_hsinchu/images/default_demo.jpg")!) { image in
            guard let image = image else {
                return
            }
            DispatchQueue.main.async {
                if title == self.taiwanInfo.Name{
                    self.LocationImageView.image = image
                }
            }
        }

    }
}
