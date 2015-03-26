package com.dhcc.gis.util
{
	import com.dhcc.gis.events.PBGISEvent;
	
	import flash.events.EventDispatcher;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	/**
	 * 类名：ConfigManager.as
	 * 功能：该类初始化加载配置地图的gisconfig.xml
	 * 包名：com.dhcc.gis.util
	 * 作者：邢健  xingjian@yeah.net
	 * 日期：2013年7月25日
	 * 版本：V1.0
	 **/
	public class ConfigManager extends  EventDispatcher{
		
		
		public function ConfigManager(){
		}
		
		/**
		 *功能：通过传入url加载gisconfig.xml配置文件
		 **/
		public function configXMLLoad(url:String):void{
			var configService:HTTPService = new HTTPService();
			configService.url = url;
			configService.resultFormat = "e4x";
			configService.addEventListener(ResultEvent.RESULT, configXMLResult);
			configService.addEventListener(FaultEvent.FAULT, configXMLFault);	
			configService.send();
		}
		
		/**
		*加载 gisconfig.xml配置文件成功
		**/
		private function configXMLResult(event:ResultEvent):void{
			var configXML:XML = event.result as XML;
			//读取mapservices.mapservice
			var configData:ConfigData = new ConfigData();
			var mapservices:XMLList = configXML.mapservices.mapservice as XMLList;
			for (var i:int = 0; i < mapservices.length(); i++){
				var name:String = mapservices[i].@name;
				var layers:String = mapservices[i].@layers;
				var format:String = mapservices[i].@format;
				var label:String = mapservices[i].@label;
				var type:String = mapservices[i].@type;
				var visible:String = mapservices[i].@visible;
				var alpha:String = mapservices[i].@alpha;
				var msURL:String = mapservices[i];
				var mapserviceObject:Object = {name:name,layers:layers,format:format,label:label,type:type,visible:visible,alpha:alpha,msURL:msURL};
				configData.mapservices.push(mapserviceObject);
			}
			
			//读取initextent
			var initExtentXML:XML = configXML..initextent[0] as XML;
			var initExtentStr:String = initExtentXML.toString();
			var initExtentArray:Array = initExtentStr.split(",");
			if(initExtentArray.length==4){
				var initExtent:Object = {xmin:initExtentArray[0],ymin:initExtentArray[1],xmax:initExtentArray[2],ymax:initExtentArray[3]};
				configData.initExtent = initExtent;
			}
			//读取maxextent
			var maxExtentXML:XML = configXML..maxextent[0] as XML;
			var maxExtentStr:String = maxExtentXML.toString();
			var maxExtentArray:Array = maxExtentStr.split(",");
			if(maxExtentArray.length==4){
				var maxExtent:Object = {xmin:maxExtentArray[0],ymin:maxExtentArray[1],xmax:maxExtentArray[2],ymax:maxExtentArray[3]};
				configData.maxExtent = maxExtent;
			}
			dispatchEvent(new PBGISEvent("loadConfigComplete", false, false, configData));
		}
		
		/**
		 *加载 gisconfig.xml配置文件失败 
		 **/
		private function configXMLFault(event:FaultEvent):void{
			var sInfo:String = "Error: ";
			sInfo += "Event Target: " + event.target + "\n\n";
			sInfo += "Event Type: " + event.type + "\n\n";
			sInfo += "Fault Code: " + event.fault.faultCode + "\n\n";
			sInfo += "Fault Info: " + event.fault.faultString;
			trace(sInfo);
			dispatchEvent(new PBGISEvent("loadConfigError", false, false, sInfo));
		}
	}
}