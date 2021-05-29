//
//  MapView.swift
//  Mymap2
//
//  Created by naoki on 2021/05/27.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {

    let searchKey:String

    func makeUIView(context: Context) ->  MKMapView {
        
        MKMapView()
        
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        print(searchKey)
    
    //CLGeocoderインスタンスの設置
    let geocoder = CLGeocoder()
        //入力された位置情報の取得
        geocoder.geocodeAddressString(searchKey, completionHandler: { (placemarks,error) in
            
        //検索結果が存在し、１件目の情報から位置情報を取り出す
       if  let unwrapPlacemarks = placemarks ,
           let firstPlacemark = unwrapPlacemarks.first ,
           let location = firstPlacemark.location {
        
        //位置情報から緯度経度をtargetcoodinateに取り出す
        let targetcoodinate = location.coordinate
        
        //緯度経度をデバッグエリアに表示
        print(targetcoodinate)
        
        //MKPointAnnotationインスタンスを取得し、ピンを作成
        let pin = MKPointAnnotation()
        
        //ピンの置く場所に緯度経度を設定
        pin.coordinate = targetcoodinate
        
        //ピンのタイトルを設定
        pin.title = searchKey
        
        //ピンを地図に置く
        uiView.addAnnotation(pin)
        
        //緯度経度を中心にして半径500mの範囲を表示
        uiView.region = MKCoordinateRegion(center: targetcoodinate, latitudinalMeters: 500.0,  longitudinalMeters: 500.0)
        
        
        }
    })
    

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(searchKey: "東京タワー")
    }
}
    }
}
