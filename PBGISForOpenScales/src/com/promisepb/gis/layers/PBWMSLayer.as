package com.dhcc.gis.layers
{
	import org.openscales.core.layer.ogc.WMS;
	
	/**
	 * 类名：PBWMSLayer.as
	 * 功能：WMS服务类型图层
	 * 包名：com.dhcc.gis.layers
	 * 作者：邢健  xingjian@yeah.net
	 * 日期：2013年7月25日
	 * 版本：V1.0
	 **/
	public class PBWMSLayer extends WMS
	{
		public function PBWMSLayer(identifier:String="", url:String="", layers:String="", styles:String="", format:String="image/png")
		{
			super(identifier, url, layers, styles, format);
		}
	}
}