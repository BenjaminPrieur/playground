//: Playground - noun: a place where people can play

import UIKit

func convertStringToDictionary(text: String) -> [[String:AnyObject]]? {
//    if let data = text.data(using: .utf8) { // swift 3.0
    if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
        do {
//            return try JSONSerialization.jsonObject(with: data, options: []) as? [[String:AnyObject]] // swift 3.0
            return try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [[String:AnyObject]] // swift 2.2
        } catch let error as NSError {
            print(error)
        } catch {
            print("merde")
        }
    }
    return nil
}


var str = "[{\"_id\": \"57a4a4165b5c3472303bef53\",\"full_name\": \"Benjamin Prieur\", \"username\": \"Ben\", \"photo\": \"https://scontent.xx.fbcdn.net/v/t1.0-1/p50x50/1934642_10153626658304405_2645359677490508445_n.jpg?oh=1a529cd493e452ca4ce4b55eb68e1872&oe=58585822\", \"is_following\": true},{\"_id\": \"57a4a4165b5c3472303bef53\",\"full_name\": \"Benjamin Prieur\", \"username\": \"Ben\", \"photo\": \"https://scontent.xx.fbcdn.net/v/t1.0-1/p50x50/1934642_10153626658304405_2645359677490508445_n.jpg?oh=1a529cd493e452ca4ce4b55eb68e1872&oe=58585822\", \"is_following\": true}]"

//var str = "[{\"_id\":\"578cc7ffbc10760a12fc2b32\",\"media\":\"https://d24g6oh7sft28g.cloudfront.net/medias/posts/1468844030921.gif\",\"created_by\":{\"_id\":\"5783f8fede2f50c145184bd1\",\"full_name\":\"Arthur Daurel\",\"photo\":\"https://scontent.xx.fbcdn.net/v/t1.0-1/p50x50/12341039_10206298172426426_4000110928716309444_n.jpg?oh=bffd9c948910f3ca4a4b0264cba11c03&oe=58349A07\"},\"comments_people\":[{\"by\":{\"_id\":\"5783f8fede2f50c145184bd1\",\"full_name\":\"Arthur Daurel\",\"photo\":\"https://scontent.xx.fbcdn.net/v/t1.0-1/p50x50/12341039_10206298172426426_4000110928716309444_n.jpg?oh=bffd9c948910f3ca4a4b0264cba11c03&oe=58349A07\"},\"content\":\"test\",\"_id\":\"578cc7ffbc10760a12fc2b33\",\"date\":\"2016-07-18T12:13:51.042Z\"}],\"__v\":0,\"comments_count\":1,\"likes_count\":0,\"loops_count\":0,\"created_at\":\"2016-07-18T12:13:51.039Z\"},{\"_id\":\"57895c5397a225366beaccd9\",\"media\":\"https://d24g6oh7sft28g.cloudfront.net/medias/posts/1468619859781.gif\",\"created_by\":{\"_id\":\"5783f8fede2f50c145184bd1\",\"full_name\":\"Arthur Daurel\",\"photo\":\"https://scontent.xx.fbcdn.net/v/t1.0-1/p50x50/12341039_10206298172426426_4000110928716309444_n.jpg?oh=bffd9c948910f3ca4a4b0264cba11c03&oe=58349A07\"},\"comments_people\":[{\"by\":{\"_id\":\"5783f8fede2f50c145184bd1\",\"full_name\":\"Arthur Daurel\",\"photo\":\"https://scontent.xx.fbcdn.net/v/t1.0-1/p50x50/12341039_10206298172426426_4000110928716309444_n.jpg?oh=bffd9c948910f3ca4a4b0264cba11c03&oe=58349A07\"},\"content\":\"test\",\"_id\":\"57895c5397a225366beaccda\",\"date\":\"2016-07-15T21:57:39.868Z\"}],\"__v\":0,\"comments_count\":1,\"likes_count\":1,\"loops_count\":0,\"created_at\":\"2016-07-15T21:57:39.867Z\"},{\"_id\":\"5789551497a225366beaccd6\",\"media\":\"https://d24g6oh7sft28g.cloudfront.net/medias/posts/1468618004798.gif\",\"created_by\":{\"_id\":\"5783f8fede2f50c145184bd1\",\"full_name\":\"Arthur Daurel\",\"photo\":\"https://scontent.xx.fbcdn.net/v/t1.0-1/p50x50/12341039_10206298172426426_4000110928716309444_n.jpg?oh=bffd9c948910f3ca4a4b0264cba11c03&oe=58349A07\"},\"comments_people\":[{\"by\":{\"_id\":\"5783f8fede2f50c145184bd1\",\"full_name\":\"Arthur Daurel\",\"photo\":\"https://scontent.xx.fbcdn.net/v/t1.0-1/p50x50/12341039_10206298172426426_4000110928716309444_n.jpg?oh=bffd9c948910f3ca4a4b0264cba11c03&oe=58349A07\"},\"content\":\"test\",\"_id\":\"5789551497a225366beaccd7\",\"date\":\"2016-07-15T21:26:44.913Z\"}],\"__v\":0,\"comments_count\":1,\"likes_count\":1,\"loops_count\":0,\"created_at\":\"2016-07-15T21:26:44.910Z\"}]"

let result = convertStringToDictionary(str)

//: [Next](@next)
