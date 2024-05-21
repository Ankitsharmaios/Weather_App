//
//  DataManager.swift
//  UniviaFarmer
//
//  Created by Nik on 17/01/23.
//

import Foundation
import Alamofire

class DataManager: NSObject {
    
    //------------------------------------------------------------------------------
    // MARK:-
    // MARK:- Variables
    //------------------------------------------------------------------------------
    
    static let shared   = DataManager()
    let baseUrl         = WebServiceURL.URLDomain
    
    // Create http headers
    func getHttpHeaders() -> HTTPHeaders {
        var httpHeader = HTTPHeaders()
        httpHeader["Accept"] = "application/json"
        httpHeader["Content-Type"] = "application/json"
        httpHeader["APIToken"] = UserToken.userToken
        return httpHeader
    }
    
    // Create http Form data headers
    func getHttpFormDataHeaders() -> HTTPHeaders {
        var httpHeader = HTTPHeaders()
        httpHeader["Accept"] = "application/json"
        httpHeader["Content-Type"] = "multipart/form-data"
        httpHeader["APIToken"] = UserToken.userToken
        return httpHeader
    }
    
    
    //------------------------------------------------------------------------------
    // MARK:-
    // MARK:- Custom Methods
    //------------------------------------------------------------------------------
    
    // Get API url with endpoints
    func getURL(_ endpoint: WSEndPoints) -> String {
        return baseUrl + endpoint.rawValue
    }
}

// MARK:-
// MARK:- WebserviceURL
//------------------------------------------------------------------------------

struct WebServiceURL {
//    static let URLDomain = "http://uboapis.testingbeta.in/api/" // Live
//    static let URLDomain = "https://api.univia.tk/api/" // Staging --- Last used - till 10/01/2024
    static let URLDomain = "https://api.univia.cc/api/" // After 10/01/2024 changes
    static let globasDomain = "https://api.univia.cc" //Note : Where above domain change please this also
}

//------------------------------------------------------------------------------
// MARK:-
// MARK:- WebserviceEndPoints
//------------------------------------------------------------------------------

enum WSEndPoints: String {
    case GenerateToken = "GenerateToken"
    case AppLanguageList = "AppLanguageList?"
    case GetLanguageLabels = "languageLabels"
    case UserLoginv3 = "userLoginv3"
    case VerifyOTPv2 = "verifyOTPv2"
    case GetBannerList = "BannerList"
    
    case GetProductCategoryList = "ProductCategoryList?"
    case GetProductSubCategoryList = "ProductSubCategoryList?"
    case GetProductBrandList = "ProductBrandList?"
    case GetProductList = "ProductList"
    case GetProductDetail = "ProductDetail"
    case addProductWishList = "ProductWishList"
    
    
    case AddToCartProduct = "AddToCartProduct"
    case GetCartList = "UFACartList"
    case GetStoreAddressList = "StoreAddressList"
    case CartQuantityUpdate = "CartQuantityUpdate"
    case GetCustomerAddressList = "CustomerAddressList"
    case AddCustomerAddress = "CustomerAddress"
    
    case UFACheckout = "UFACheckout"
    case UFAPlaceOrder = "UFAPlaceOrder"
    case GetOrderList = "OrderList"
    case GetOrderDetail = "OrderDetail"
    
    case ChangeOrderStatus = "ChangeOrderStatus"
    case RewardHistoryList = "RewardHistoryList"
    case Checkout = "Checkout"
    case CouponList = "CouponList"
    
    case CompanyDetails = "CompanyDetails"
    case GetNotificationDetail = "GetNotificationDetail"
    
    //Kheti tab
    case AddFarmApi = "AddFarm"
    case GetFarmCropsList = "FarmCrops"
    case AddCropsInFarm = "AddCropsInFarm"
    case AddFarmCropIncomeExpense = "AddFarmCropIncomeExpense"
    case IncomeDetail = "IncomeDetail"
    
    case CropListData = "CropListData"
    case GetCropCategoryList = "CropCategoryList"
    case MandiCropPrice = "MandiCropPrice"
    case CropEditAddData = "CropEditAddData"
    
    case AAAForm_AddServiceRequest = "AddServiceRequest"
    case SideMenuServiceRequestList = "ServiceRequestList"
    
    case FarmerQuestionsList = "FarmerQuestionsList"
    case GetBlogList = "BlogList"
    case GetCropDetail = "CropDetail"
    case GetQuestionDetail = "QuestionDetail"
    case AddCommentQuestion = "addCommentQuestion"
    
    
    case LegalPageListList = "LegalPageList"
    case customerLikeBlogWishList = "customerLikeBlog"
    case addCommentBlogWishList = "addCommentBlog"
    case MandiWishList = "MandiWishList"
    case LikeQuestion = "LikeQuestion"
    case AddFarmerQuestions = "FarmerQuestions"
    case GetPetsList = "PetsList"
    case GetDiseaseList = "DiseaseList"
    
    //BlogDetail
    case BlogDetail = "BlogDetail"
//    case BlogWishList = "BlogWishList"
    
    //MARK: Jignesh
    case BlogWishList = "BlogWishList"
    
    //MyProfileView
    case ProfileList = "ProfileList"
    case BadgeDetails = "BadgeDetails"
    case EditProfileLocationDetail = "Location"
    case EditUGAProfile = "EditUGAProfile"
    case UFARegister = "UFARegister"
    case MarkedAsDeleted = "MarkedAsDeleted"
}


//------------------------------------------------------------------------------
// MARK:-
// MARK:- enum - Result
//------------------------------------------------------------------------------

enum Result<T, U> where U: Error  {
    case success(T)
    case failure(U)
}


//------------------------------------------------------------------------------
// MARK:-
// MARK:- enum - APIError
//------------------------------------------------------------------------------

enum APIError: Error {
    case errorMessage(String)
    case requestFailed(String)
    case jsonConversionFailure(String)
    case invalidData(String)
    case responseUnsuccessful(String)
    case jsonParsingFailure(String)
    
    var localizedDescription: String {
        
        switch self {
            
        case.errorMessage(let msg):
            return msg
            
        case .requestFailed(let msg):
            return msg
            
        case .jsonConversionFailure(let msg):
            return msg
            
        case .invalidData(let msg):
            return msg
            
        case .responseUnsuccessful(let msg):
            return msg
            
        case .jsonParsingFailure(let msg):
            return msg
        }
    }
}
