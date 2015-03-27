package com.promisepb.gis.events
{
	import flash.events.Event;
	/**   
	 * 类名: PBGISEvent.as 
	 * 包名: com.promisepb.gis.events 
	 * 功能: PBGISEvent事件
	 * 作者: promisePB xingjian@yeah.net   
	 * 日期: 2013-7-25 下午01:37:47 
	 * 版本: V1.0   
	 */
	public class PBGISEvent extends Event
	{
		//事件携带数据		
		private var _data:Object;
		
		//构造函数
		public function PBGISEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, data:Object=null)
		{
			if (data != null) _data = data;
			super(type, bubbles, cancelable);
		}
		
		public function get data():Object
		{
			return _data;
		} 
		
		public function set data(data:Object):void
		{
			_data = data;
		}
	}
}