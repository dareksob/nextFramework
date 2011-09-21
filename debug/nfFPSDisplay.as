package nextFramework.debug 
{
	import flash.display.Sprite;
    import flash.events.Event;
    import flash.text.TextField;
    import flash.utils.getTimer;
	import nextFramework.component.IComponentContainer;
	import nextFramework.component.nfComponentObjectContainer;
	import nextFramework.nfProperties;

    public class nfFPSDisplay extends Sprite implements IComponentContainer{
        private var _lastTime:uint = getTimer();
        private var _ticks:uint = 0;
        private var _textfield:TextField = null;
        private var _componentContainer:nfComponentObjectContainer = null;
		
		public function get componentContainer():nfComponentObjectContainer {
			return this._componentContainer;
		}

        public function nfFPSDisplay(offset:uint = 5, color:uint=0xffffff, background:Boolean=false, backgroundColor:uint=0x000000) {
            this.x = offset;
            this.y = offset;
			
			this._componentContainer = new nfComponentObjectContainer(this);
			
			//create text;
            this._textfield = new TextField();
			nfProperties.setObjectProperties(this._textfield, {
				color: color,
				text:  "--- fps",
				selectable: false,
				background: background,
				backgroundColor: backgroundColor,
				autoSize: 'left'
			})
            this.addChild(this._textfield);
			
            this.addEventListener(Event.ENTER_FRAME, tick);
        }

        public function tick(evt:Event):void {
            _ticks++;
            var now:uint = getTimer();
            var time:uint = now - _lastTime;
            if (time >= 1000) {
                var fps:Number = _ticks / time * 1000;
                this._textfield.text = fps.toFixed(1) + " fps";
                _ticks = 0;
                _lastTime = now;
            }
        }
    }

}