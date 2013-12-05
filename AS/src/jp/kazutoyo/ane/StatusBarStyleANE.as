package jp.kazutoyo.ane
{
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;

	public class StatusBarStyleANE extends EventDispatcher
	{
		public static const STATUS_BAR_STYLE_DEFAULT:int = 1; // 標準スタイル
		public static const STATUS_BAR_STYLE_LIGHT_CONTENT:int = 2; // ライトスタイル（白色）
		private static var _instance:StatusBarStyleANE;
		
		private var extCtx:ExtensionContext = null;
				
		public function StatusBarStyleANE()
		{
			if (!_instance)
			{
				extCtx = ExtensionContext.createExtensionContext("jp.kazutoyo.ane.StatusBarStyleANE", null);
				if (extCtx != null)
				{
					extCtx.addEventListener(StatusEvent.STATUS, onStatus);
				} 
				else
				{
					trace('[StatusBarStyleANE] Error - Extension Context is null.');
				}
				_instance = this;
			}
			else
			{
				throw Error('This is a singleton, use getInstance(), do not call the constructor directly.');
			}
		}
		
		public static function getInstance() : StatusBarStyleANE
		{
			return _instance ? _instance : new StatusBarStyleANE();
		}
		
		
		/**
		 * 対応しているかの確認ファンクション
		 */
		public function isSupported() : Boolean
		{
			return extCtx.call('isSupported');
		}
		
		/**
		 * ステータスバースタイルをセットする
		 */
		public function setStatusBarStyle(statusBarStyle:int) : Boolean
		{
			return extCtx.call('setStatusBarStyle', statusBarStyle);
		}
		
		
		/**
		 * ANEのイベント
		 */
		private function onStatus( event : StatusEvent ) : void
		{
			if (event.code == "LOGGING")
			{
				trace('[StatusBarStyleANE] ' + event.level);
			}
		}
	}
}
