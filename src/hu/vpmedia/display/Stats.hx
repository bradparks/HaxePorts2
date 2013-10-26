////////////////////////////////////////////////////////////////////////////////
//=BEGIN LICENSE MIT
//
// Copyright (c) 2012, Original author & contributors
// Original author : Mr. Doob http://github.com/mrdoob/stats.as 
// Contributors: NME port by fermmm - http://fermmm.wordpress.com/
//               Andras Csizmadia -  http://www.vpmedia.eu
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//  
//=END LICENSE MIT
////////////////////////////////////////////////////////////////////////////////
/**
 * Stats 
 * addChild( new Stats() );
 **/    
package hu.vpmedia.display;
    
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import flash.system.System;
import flash.text.TextField;
import flash.display.Stage;
import flash.text.TextFormat;
import Xml;
import flash.Lib;
   
class Stats extends Sprite {    

    static inline var GRAPH_WIDTH : Int = 70;
    static inline var XPOS : Int = 69;//width - 1
    static inline var GRAPH_HEIGHT : Int = 50;
    static inline var TEXT_HEIGHT : Int = 50;

    private var text : TextField;

    private var timer : Int;
    private var fps : Int;
    private var ms : Int;
    private var ms_prev : Int;
    private var mem : Float;
    private var mem_max : Float;

    private var graph : BitmapData;
    private var rectangle : Rectangle;
    private var alignRight : Bool;

    private var fps_graph : Int;
    private var mem_graph : Int;
    private var ms_graph : Int;
    private var mem_max_graph : Int;
    private var _stage:Stage;
    
    private var fpsStr        :String;
    private var memStr        :String;
    private var memMaxStr    :String;
    private var msStr        :String;

    /**
     * <b>Stats</b> FPS, MS and MEM, all in one.
     */
    public function new(alignRight:Bool = true) 
    {
        super();
        this.alignRight = alignRight;
        mem_max = 0;
        fps = 0;
                
        text = new TextField();
        text.defaultTextFormat = new TextFormat("_sans", 9, null, null, null, null, null, null, null, null, null, null, -2);
        text.multiline = true;
        text.width = GRAPH_WIDTH;
        text.height = TEXT_HEIGHT;
        text.selectable = false;
        text.mouseEnabled = false;
        
        rectangle = new Rectangle(GRAPH_WIDTH - 1, 0, 1, GRAPH_HEIGHT);            

        this.addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
        this.addEventListener(Event.REMOVED_FROM_STAGE, destroy, false, 0, true);
    }

    function init(e : Event) {

        _stage = flash.Lib.current.stage;
        graphics.beginFill(Colors.bg);
        graphics.drawRect(0, 0, GRAPH_WIDTH, TEXT_HEIGHT);
        graphics.endFill();

        this.addChild(text);
        
        graph = new BitmapData(GRAPH_WIDTH, GRAPH_HEIGHT, false, Colors.bg);
        graphics.beginBitmapFill(graph, new Matrix(1, 0, 0, 1, 0, TEXT_HEIGHT));
        graphics.drawRect(0, TEXT_HEIGHT, GRAPH_WIDTH, GRAPH_HEIGHT);

        this.addEventListener(Event.ENTER_FRAME, update);
        
        if (alignRight)
            x = Lib.current.stage.stageWidth - width;
    }

    function destroy(e : Event) {
        
        graphics.clear();
        
        while(numChildren > 0)
            removeChildAt(0);            
        
        graph.dispose();
        
        removeEventListener(Event.ENTER_FRAME, update);
        
    }

    function update(e : Event) {

        timer = flash.Lib.getTimer();
        
        //after a second has passed 
        if( timer - 1000 > ms_prev ) {

            mem = System.totalMemory * 0.000000954;
            mem_max = mem_max > mem ? mem_max : mem;

            fps_graph = GRAPH_HEIGHT - Std.int( Math.min(GRAPH_HEIGHT, ( fps / _stage.frameRate ) * GRAPH_HEIGHT) );

            mem_graph = GRAPH_HEIGHT - normalizeMem(mem);
            mem_max_graph = GRAPH_HEIGHT - normalizeMem(mem_max);
            //milliseconds since last frame -- this fluctuates quite a bit
            ms_graph = Std.int( GRAPH_HEIGHT - ( ( timer - ms ) >> 1 ));
            graph.scroll(-1, 0);

            graph.fillRect(rectangle, Colors.bg);
            graph.lock();
            graph.setPixel(XPOS, fps_graph, Colors.fps);
            graph.setPixel(XPOS, mem_graph, Colors.mem);
            graph.setPixel(XPOS, mem_max_graph, Colors.memmax);
            graph.setPixel(XPOS, ms_graph, Colors.ms);
            graph.unlock();

            fpsStr        = "FPS: " + fps + " / " + stage.frameRate;
            memStr        = "MEM: " + Math.round(mem);
            memMaxStr    = "MAX: " + Math.round(mem_max);


            
            //reset frame and time counters
            fps = 0;
            ms_prev = timer;

            return;
        }
        
        //increment number of frames which have occurred in current second
        fps++;

        msStr = "MS: " + (timer - ms);
        ms = timer;
        
        var htmlText:String = "<font color='" + Colors.fpsCSS +"'>" + fpsStr + "</font>" +
                        "<br>" +
                        "<font color='" + Colors.memCSS +"'>" + memStr + "</font>" +
                        "<br>" +
                        "<font color='" + Colors.memmaxCSS +"'>" + memMaxStr + "</font>" +
                        "<br>" +
                        "<font color='" + Colors.msCSS +"'>" + msStr + "</font>";
                        
        text.htmlText = htmlText;
    }


    
    function normalizeMem(_mem:Float):Int {
        return Std.int( Math.min( GRAPH_HEIGHT, Math.sqrt(Math.sqrt(_mem * 5000)) ) - 2);
    }
    
}

class Colors {

    public static inline var bg : Int = 0x000033;
    public static inline var fps : Int = 0xffff00;
    public static inline var ms : Int = 0x00ff00;
    public static inline var mem : Int = 0x00ffff;
    public static inline var memmax : Int = 0xff0070;
    public static inline var bgCSS : String = "#000033";
    public static inline var fpsCSS : String = "#ffff00";
    public static inline var msCSS : String = "#00ff00";
    public static inline var memCSS : String = "#00ffff";
    public static inline var memmaxCSS : String = "#ff0070";
    
}
