import UIKit
import SDWebImage
import SwiftyJSON


class ProductGridVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    @IBOutlet var productsCollection: UICollectionView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    var products: Array<Any> = [];
    lazy var selectedProduct = Product.init(withProduct: JSON({}))
    var productDetailVC: ProductDetailVC = ProductDetailVC();

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let api = ProductAPI()
        self.productsCollection.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "productCell")
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let width = screenWidth < 900 ? screenWidth < 600 ? screenWidth/2 : screenWidth/3 : screenWidth / 4;
        var height = screenHeight/2 - 80;
        
        if(screenWidth > 600 && UIDevice.current.orientation == .portrait || UIDevice.current.orientation == .portraitUpsideDown){
            height = height - 100
        }
        
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        self.productsCollection.collectionViewLayout = layout
        
        api.loadAllProducts { (result) in
            self.products = result;
            self.title =  "Dishwashers (\(self.products.count))"
            self.spinner.isHidden = true
            self.productsCollection.reloadData()
        }
        spinner.startAnimating()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath as IndexPath) as! ProductCell
        
        let product = self.products[indexPath.item] as! Product;
        cell.price.text = product.price;
        cell.title.text = product.title;
        let url = "https:\(product.imageUrl)"
        cell.image.sd_setImage(with:URL(string: url))

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let product = self.products[indexPath.item] as! Product;
        let api = ProductAPI()
        
        spinner.isHidden = false;
        
        api.fetchMoreDetailsForProductWith(id: product.id) { (productWithDetails) in
            self.selectedProduct = productWithDetails;
            self.performSegue(withIdentifier: "transitionToProductDetail", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue?, sender: Any?) {
        
        if (segue?.identifier == "transitionToProductDetail") {
            
            productDetailVC = segue!.destination as! ProductDetailVC
            spinner.isHidden = true;
            productDetailVC.setUpWithProduct(product: self.selectedProduct)
            
        }
        
    }
}

