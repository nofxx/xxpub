/*

	DrawingPad
	
	by Jesse R. Warden
	jesterxl@jessewarden.com
	http://www.jessewarden.com
	
	This is release under a Creative Commons license. 
    More information can be found here:
    
    http://creativecommons.org/licenses/by/2.5/

*/

package comps.src.pad.controls
{
	

	
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.display.Graphics;
	import flash.net.SharedObject;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	
	import mx.core.UIComponent;
	import mx.managers.CursorManager;
	import mx.managers.CursorManagerPriority;
	
	import comps.src.pad.data.DrawingPoint;
	import mx.core.Application;
	import mx.controls.ColorPicker;
	
	[Event("drawingStarted")]
	[Event("drawingStopped")]
	[Event("drawingCleared")]
	[Event("drawingAnimationStarted")]
	[Event("drawingAnimationStopped")]
	public class DrawingPad extends UIComponent 
	{
		public static const DRAWING_STARTED:String = "drawingStarted";
		public static const DRAWING_STOPPED:String = "drawingStopped";
		public static const DRAWING_CLEARED:String = "drawingCleared";
		public static const DRAWING_ANIMATION_STARTED:String = "drawingAnimationStarted";
		public static const DRAWING_ANIMATION_STOPPED:String = "drawingAnimationStopped";
		
		[Embed(source="assets/cursor_pen.png")]
		public var cursor_pen_img:Class;
		public var drawingPadSOName:String = "drawing_pad_default";
		public var isDrawing:Boolean = false;
		public var isAnimateDrawing:Boolean = false;
		
		protected var canvas_shape:Shape;
		protected var drawingPoints_array:Array = [];
		protected var penCursorID:Number;
		
		private var currentDrawIndex:Number;
		private var drawingAnimeID:Number;
		
		private var lineColor:uint;
	
		public function DrawingPad()
		{
			if(hasEventListener(MouseEvent.MOUSE_DOWN) == false)
			{
				addEventListener(MouseEvent.MOUSE_DOWN, onPadPress);
			}
			
			if(hasEventListener(MouseEvent.MOUSE_UP) == false)
			{
				addEventListener(MouseEvent.MOUSE_UP, onPadRelease);	
			}
			
			if(hasEventListener(MouseEvent.MOUSE_OVER) == false)
			{
				addEventListener(MouseEvent.MOUSE_OVER, onMouseOverPad);	
			}
			
			if(hasEventListener(MouseEvent.MOUSE_OUT) == false)
			{
				addEventListener(MouseEvent.MOUSE_OUT, onMouseOutPad);	
			}
		}
		
		public function clearDrawing():void
		{
			if(isDrawing) return;
			if(isAnimateDrawing) return;
			
			canvas_shape.graphics.clear();
			isDrawing = false;
			drawingPoints_array = [];
			var event:Event = new Event(DRAWING_CLEARED, true, true);
			dispatchEvent(event);
		}
		
		
		// Optional UIComponent overrides
		
		//override protected function commitProperties():void
		//{
		//}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			canvas_shape = new Shape();
			addChild(canvas_shape);
		}
		
		override protected function measure():void
		{
			super.measure();
			
			measuredWidth = 320;
            measuredMinWidth = 16;
            measuredHeight = 240;
            measuredMinHeight = 16;
            
            explicitWidth = 240;
            explicitHeight = 320;
            
            width = 320;
            height = 240;	
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			var g:Graphics = graphics;
			g.moveTo(0, 0);
			
			g.beginFill(0xFFFFFF);
			g.drawRect(0, 0, width, height);
			
			g.endFill();
			
			//g.moveTo(0, 0);
			//g.lineStyle(0, 0x666666);
			//g.lineTo(width, 0);
			//g.lineTo(width, height);
			//g.lineTo(0, height);
			//g.lineTo(0, 0);
			
			//g.moveTo(1, 1);
			//g.lineStyle(0, 0x999999);
			//g.lineTo(width - 2, 1);
			//g.moveTo(1, 1);
			//g.lineTo(1, height - 2);
			
			//g.moveTo(1, height - 2);
			//g.lineStyle(0, 0xEEEEEE);
			//g.lineTo(width - 2, height - 2);
			//g.moveTo(width - 2, height - 2);
			//g.lineTo(width - 2, 3);
			
			//g.endFill();
		}
		
		public function changeColor(color:uint):void{
			lineColor = color;
		}
		
		protected function onPadPress(event:MouseEvent):void
		{
			if(isDrawing) return;
			if(isAnimateDrawing) return;
			
			var drawingStartedEvent:Event = new Event(DRAWING_STARTED, true, true);
			dispatchEvent(drawingStartedEvent);
			isDrawing = true;
			
			var point:Point = new Point(mouseX, mouseY);
			var dp:DrawingPoint = new DrawingPoint(point, DrawingPoint.PRESS);
			drawingPoints_array.push(dp);
			canvas_shape.graphics.lineStyle(0, lineColor);//0x000000);
			canvas_shape.graphics.moveTo(point.x, point.y);
			
			if(hasEventListener(MouseEvent.MOUSE_MOVE) == false)
			{
				addEventListener(MouseEvent.MOUSE_MOVE, onMouseMovingWhilePressed);	
			}
			event.updateAfterEvent();
		}
		
		protected function onMouseMovingWhilePressed(event:MouseEvent):void
		{
			if(isAnimateDrawing) return;
			
			var isOverCanvas:Boolean = getOverCanvas();
			if(isOverCanvas == true)
			{
				var point:Point = new Point(mouseX, mouseY);
				var dp:DrawingPoint = new DrawingPoint(point, DrawingPoint.NORMAL);	
				drawingPoints_array.push(dp);
				canvas_shape.graphics.lineStyle(0, lineColor);//0x000000);
				canvas_shape.graphics.lineTo(point.x, point.y);
				canvas_shape.graphics.moveTo(point.x, point.y);
			}
			event.updateAfterEvent();
		}
		
		protected function getOverCanvas():Boolean
		{
			var margin:Number = 4;
			if(mouseX >= margin && mouseX <= width - margin)
			{
				if(mouseY >= margin && mouseY <= height - margin)
				{
					return true;
				}
				return false;
			}
			return false;
		}
		
		protected function onPadRelease(event:MouseEvent):void
		{
			if(isAnimateDrawing) return;
			
			var point:Point = new Point(mouseX, mouseY);
			var dp:DrawingPoint = new DrawingPoint(point, DrawingPoint.RELEASE);
			drawingPoints_array.push(dp);
			canvas_shape.graphics.moveTo(point.x, point.y);
			
			isDrawing = false;
			if(hasEventListener(MouseEvent.MOUSE_MOVE) == true)
			{
				removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMovingWhilePressed);
			}
			
			var drawingStoppedEvent:Event = new Event(DRAWING_STOPPED, true, true);
			dispatchEvent(drawingStoppedEvent);
			event.updateAfterEvent();
		}
		
		public function saveDrawing():Object
		{
			if(isDrawing) return null;
			if(isAnimateDrawing) return null;
			
			var so:SharedObject = SharedObject.getLocal(drawingPadSOName);
			so.data.points_array = drawingPoints_array;
			var r:Object = so.flush();
			return r;
		}
		
		public function loadDrawing():void
		{
			if(isDrawing) return;
			if(isAnimateDrawing) return;
			
			var so:SharedObject = SharedObject.getLocal(drawingPadSOName);
			if(so.data.points_array != null)
			{
				var n:Number = so.data.points_array.length;
				if(n > 0)
				{
					clearDrawing();
					drawingPoints_array = [];
					while(n--)
					{
						var dp:DrawingPoint = so.data.points_array[n] as DrawingPoint;
						drawingPoints_array[n] = dp;
					}
					
					canvas_shape.graphics.clear();
					canvas_shape.graphics.lineStyle(0, 0x000000);
					var firstDrawingPoint:DrawingPoint = drawingPoints_array[0] as DrawingPoint;
					var first_point:Point = firstDrawingPoint.point;
					canvas_shape.graphics.moveTo(first_point.x, first_point.y);
					var len:Number = drawingPoints_array.length;
					var wasReleased:Boolean = false;
					for(var i:Number = 1; i<len; i++)
					{
						var p:DrawingPoint = drawingPoints_array[i] as DrawingPoint;
						var currentPoint:Point = p.point;
						if(p.type == DrawingPoint.PRESS)
						{
							canvas_shape.graphics.lineStyle(0, 0x000000);
							canvas_shape.graphics.moveTo(currentPoint.x, currentPoint.y);
						}
						else if(p.type == DrawingPoint.RELEASE)
						{
							canvas_shape.graphics.moveTo(currentPoint.x, currentPoint.y);
							canvas_shape.graphics.endFill();
							wasReleased = true;
						}
						else
						{
							if(wasReleased == true)
							{
								wasReleased = false;
								//canvas_shape.draw_mc.lineTo(p.x, p.y);
								canvas_shape.graphics.moveTo(currentPoint.x, currentPoint.y);
							}
							else
							{
								canvas_shape.graphics.lineTo(currentPoint.x, currentPoint.y);
								canvas_shape.graphics.moveTo(currentPoint.x, currentPoint.y);
							}
						}
					}
				}
			}
		}
		
		protected function onMouseOverPad(event:MouseEvent):void
		{
			penCursorID = CursorManager.setCursor(cursor_pen_img,
													CursorManagerPriority.LOW, 
													-2, -16);
			event.updateAfterEvent();
		}
		
		protected function onMouseOutPad(event:MouseEvent):void
		{
			CursorManager.removeCursor(penCursorID);
			event.updateAfterEvent();
		}
		
		public function loadDrawingAndDrawIt():void
		{
			if(isDrawing) return;
			if(isAnimateDrawing) return;
			
			var so:SharedObject = SharedObject.getLocal(drawingPadSOName);
			if(so.data.points_array != null)
			{
				var n:Number = so.data.points_array.length;
				if(n > 0)
				{
					clearDrawing();
					drawingPoints_array = [];
					while(n--)
					{
						var dp:DrawingPoint = so.data.points_array[n] as DrawingPoint;
						drawingPoints_array[n] = dp;
					}
					
					isAnimateDrawing = true;
					currentDrawIndex = -1;
					canvas_shape.graphics.clear();
					canvas_shape.graphics.lineStyle(0, 0x000000);
					var firstDrawingPoint:DrawingPoint = drawingPoints_array[0] as DrawingPoint;
					var first_point:Point = firstDrawingPoint.point;
					canvas_shape.graphics.moveTo(first_point.x, first_point.y);
				
					var drawingAnimeEvent:Event = new Event(DRAWING_ANIMATION_STARTED, true, true);
					dispatchEvent(drawingAnimeEvent);
					
					clearInterval(drawingAnimeID);
					drawingAnimeID = setInterval(drawNextPoint, 0);
					
					drawNextPoint();
				}
			}
		}
		
		private function drawNextPoint():void
		{
			if(currentDrawIndex + 1 < drawingPoints_array.length)
			{
				currentDrawIndex++;
				
				var len:Number = drawingPoints_array.length;
				var wasReleased:Boolean = false;
				var p:DrawingPoint = drawingPoints_array[currentDrawIndex] as DrawingPoint;
				var currentPoint:Point = p.point;
				if(p.type == DrawingPoint.PRESS)
				{
					canvas_shape.graphics.lineStyle(0, 0x000000);
					canvas_shape.graphics.moveTo(currentPoint.x, currentPoint.y);
				}
				else if(p.type == DrawingPoint.RELEASE)
				{
					canvas_shape.graphics.moveTo(currentPoint.x, currentPoint.y);
					wasReleased = true;
				}
				else
				{
					if(wasReleased == true)
					{
						wasReleased = false;
						//canvas_shape.draw_mc.lineTo(p.x, p.y);
						canvas_shape.graphics.moveTo(currentPoint.x, currentPoint.y);
					}
					else
					{
						canvas_shape.graphics.lineTo(currentPoint.x, currentPoint.y);
						canvas_shape.graphics.moveTo(currentPoint.x, currentPoint.y);
					}
				}
			}
			else
			{
				canvas_shape.graphics.endFill();
				clearInterval(drawingAnimeID);
				isAnimateDrawing = false;
				var drawingAnimeEvent:Event = new Event(DRAWING_ANIMATION_STOPPED, true, true);
				dispatchEvent(drawingAnimeEvent);
			}
		}
		
	}
}
