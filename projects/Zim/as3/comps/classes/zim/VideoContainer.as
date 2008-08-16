package comps.classes.zim
{
	import mx.core.UIComponent;
	import flash.events.Event;
	import flash.media.Video;
	
	public class VideoContainer extends UIComponent
	{
        private var _video:Video;
        private var teste:UIComponent;
        
        
		public function VideoContainer()
		{
			super();
			addEventListener(Event.RESIZE, resizeHandler);	
		}

        public function set video(video:Video):void
        {
            if (_video != null)
            {
                removeChild(_video);
            }

			_video = video;

           	if (_video != null)
            {
	            _video.width = width;
                _video.height = height;
                addChild(_video);
            }
        }

        private function resizeHandler(event:Event):void
        {
            if (_video != null)
            {
               _video.width = width;
               _video.height = height;
            }
        }
	
	}
}