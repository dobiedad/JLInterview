import UIKit
import SwiftyJSON
import ImageSlideshow

class ProductDetailVC: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet var productInfoTextView: UITextView!
    @IBOutlet var productCodeLabel: UILabel!
    @IBOutlet var warrantyLabel: UILabel!
    @IBOutlet var specialOffers: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var galleryView: ImageSlideshow!
    @IBOutlet var specsTable: UITableView!
    lazy var selectedProduct = Product.init(withProduct: JSON({}))
    
    
    override func viewDidLoad() {
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tappedImage))
        galleryView.addGestureRecognizer(gestureRecognizer)
        
        self.setUpView()
    }
    
    func tappedImage() {
        galleryView.presentFullScreenController(from: self)
    }
    
    func setUpWithProduct(product: Product) {
        selectedProduct = product;
    }
    
    func setUpView(){
        self.productInfoTextView.text = selectedProduct.info;
        self.productCodeLabel.text = "Product code: " + selectedProduct.code;
        self.title = selectedProduct.title
        self.priceLabel.text = "£" + selectedProduct.price
        self.specialOffers.text =  selectedProduct.specialOffer.characters.count > 0 ? "Special Offer: " + selectedProduct.specialOffer : "";
        self.productInfoTextView.textContainer.lineBreakMode = .byTruncatingMiddle
        self.productInfoTextView.textContainer.maximumNumberOfLines = 4;
        self.warrantyLabel.text = selectedProduct.warranty;
        self.specsTable.delegate = self
        self.specsTable.dataSource = self
        self.specsTable.register(UITableViewCell.self, forCellReuseIdentifier: "selectedProduct")
        
        var arrayOfImages:Array<Any> = [];
        
        for i in 0..<self.selectedProduct.media.urls.count {
            let source:SDWebImageSource = SDWebImageSource(urlString:self.selectedProduct.media.urls[i] as! String )!
            arrayOfImages.insert(source, at: i);
        }
        
        self.galleryView.setImageInputs(arrayOfImages as! [InputSource])
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedProduct.specs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "SpecCell"
        
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: cellIdentifier)
        
        let spec = self.selectedProduct.specs[indexPath.row] as! Specification
        cell.textLabel?.text = spec.name
        cell.textLabel?.textColor = UIColor.darkGray
        cell.detailTextLabel?.text = spec.value;
        cell.selectionStyle = .none
        
        return cell
    }
    
}
