package com.promisepb.gis.layers
{
	import flash.system.Security;
	import mx.controls.Alert;
	import mx.formatters.DateFormatter;
	import org.openscales.core.layer.TMS;
	import org.openscales.geometry.basetypes.Bounds;
	import org.openscales.geometry.basetypes.Location;
	import org.openscales.proj4as.ProjProjection;

	public class SougouMapLayer extends TMS
	{
		private var mapMinZoom:int = 1; //最小显示等级
		private var mapMaxZoom:int = 18;//最大显示等级
		private var _serviceVersion:String = "1.0.0";       
		private var _format:String = "png";     
		private var _layerName:String;
		//成员变量   
		private var tileUrls:Array = [
			"http://p0.go2map.com/seamless1/0/174/", 
			"http://p1.go2map.com/seamless1/0/174/",
			"http://p2.go2map.com/seamless1/0/174/", 
			"http://p3.go2map.com/seamless1/0/174/"];

		
		public function SougouMapLayer(name:String, url:String, layerName:String="", type:String=""){
			super(name, url, layerName);
//			Security.loadPolicyFile("http://google.com/crossdomain.xml");
//			Security.allowDomain( "*" );
//			Security.allowInsecureDomain( "*" );
			this.projection = new ProjProjection("EPSG:4326");
//			this._layerName = layerName;
			//this.maxExtent = new Bounds(-180,-90,90,180);
		}
		
		public function getStr(zoom:Number, row:Number, col:Number):String{
			zoom = zoom - 2;
			var offsetX:Number = Math.pow(2,zoom);
			var offsetY:Number = offsetX - 1;
			var numX:Number = col - offsetX;
			var numY:Number = (-row) + offsetY;
			zoom = zoom + 1;
			var l:int = 729 - zoom;
			if (l == 710) l = 792;
			
			var blo:Number = Math.floor(numX / 200);
			var bla:Number = Math.floor(numY / 200);
			
			var blos:String,blas:String;
			if (blo < 0) 
				blos = "M" + ( - blo);
			else 
				blos = "" + blo;
			if (bla < 0) 
				blas = "M" + ( - bla);
			else 
				blas = "" + bla;
			
			var x:String = numX.toString().replace("-","M");
			var y:String = numY.toString().replace("-","M");
			
			var num:int = (row+col) % tileUrls.length;
			trace(l+" row:"+blos+" col: "+blas+" x: "+x+" y: "+y);
			
			var strURL:String = "";
			strURL = tileUrls[num] + l + "/" + blos + "/" + blas + "/" + x + "_" + y + ".png";
			return strURL;
		}
		
		override public function getURL(bounds:Bounds):String {
			
//			var res:Number = this.getSupportedResolution(this.map.resolution).value;
//			if(this._tileOrigin==null) {
//				this._tileOrigin = new Location(this.maxExtent.left,this.maxExtent.bottom, this.maxExtent.projection);
//			}
			
			var res:Number = this.getSupportedResolution(this.map.resolution).value;
			var x:Number = Math.round((bounds.left - this.maxExtent.left) / (res * this.tileWidth));
			var y:Number = Math.round((this.maxExtent.top - bounds.top) / (res * this.tileHeight));
			var z:Number = this.getZoomForResolution(this.map.resolution.reprojectTo(this.projection).value);
			
			
//			var x:Number = Math.round((bounds.left - this._tileOrigin.lon) / (res * this.tileWidth));
//			var y:Number = Math.round((bounds.bottom - this._tileOrigin.lat) / ( res* this.tileHeight));
//			var z:Number = this.getZoomForResolution(this.map.resolution.reprojectTo(this.projection).value);
//			var limit:Number = Math.pow(2, z);
//			if (y < 0 || y >= limit ||x < 0 || x >= limit) {
//				return "";
//			} else {
//				x = ((x % limit) + limit) % limit;
//				y = ((y % limit) + limit) % limit;
//			}
			return getStr(z,y,x);
	}
		
		
	}
}