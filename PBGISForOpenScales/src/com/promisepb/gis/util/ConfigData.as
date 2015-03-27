package com.promisepb.gis.util
{
	/**
	 * 类名：ConfigData.as
	 * 功能：该类保存初始化加载配置地图的数据，由ConfigManager来初始化，非专业开发人员，严禁自定义该对象
	 * 包名：com.promisepb.gis.util
	 * 作者：邢健  xingjian@yeah.net
	 * 日期：2013年7月25日
	 * 版本：V1.0
	 **/
	public class ConfigData{
		
		public var mapservices:Array;
		public var maxExtent:Object;
		public var initExtent:Object;
		
		public function ConfigData(){
			mapservices = [];
		}
	}
}	