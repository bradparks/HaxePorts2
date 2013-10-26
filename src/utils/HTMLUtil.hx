////////////////////////////////////////////////////////////////////////////////
//=BEGIN LICENSE MIT
//
// Copyright (c) 2012, Original author & contributors
// Original author : AS3 Utils author & contributors
// Contributors: Andras Csizmadia -  http://www.vpmedia.eu (HaXe port)
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
package utils;

class HTMLUtil
{
/**
 * Generate an A HREF tag.
 */
public static function a(href:String, text:String, styleClass:String=null):String
{
    return '<a href="' + href + '"' +((styleClass!=null)? ' class="' + styleClass + '"':"")+ ">" + text + "</a>";
}

/**
 * Inset a BR with optional newline.
 */
public static function br(addNewline:Bool=false):String
{
    return "<br/>" +(addNewline ? "\n":"");
}

/*public static inline var entities:Hash=new Hash();
entities["\""]="&quot;";
entities["'"]="&apos;";
entities["&"]="&amp;";
entities["<"]="&lt;";
entities[">"]="&gt;";
entities[" "]="&nbsp;";
entities["�"]="&iexcl;";
entities["�"]="&curren;";
entities["�"]="&cent;";
entities["�"]="&pound;";
entities["�"]="&yen;";
entities["�"]="&brvbar;";
entities["�"]="&sect;";
entities["�"]="&uml;";
entities["�"]="&copy;";
entities["�"]="&ordf;";
entities["�"]="&laquo;";
entities["�"]="&not;";
entities["�"]="&shy;";
entities["�"]="&reg;";
entities["�"]="&trade;";
entities["�"]="&macr;";
entities["�"]="&deg;";
entities["�"]="&plusmn;";
entities["�"]="&sup2;";
entities["�"]="&sup3;";
entities["�"]="&acute;";
entities["�"]="&micro;";
entities["�"]="&para;";
entities["�"]="&middot;";
entities["�"]="&cedil;";
entities["�"]="&sup1;";
entities["�"]="&ordm;";
entities["�"]="&raquo;";
entities["�"]="&frac14;";
entities["�"]="&frac12;";
entities["�"]="&frac34;";
entities["�"]="&iquest;";
entities["�"]="&times;";
entities["�"]="&divide;";
entities["�"]="&Agrave;";
entities["�"]="&Aacute;";
entities["�"]="&Acirc;";
entities["�"]="&Atilde;";
entities["�"]="&Auml;";
entities["�"]="&Aring;";
entities["�"]="&AElig;";
entities["�"]="&Ccedil;";
entities["�"]="&Egrave;";
entities["�"]="&Eacute;";
entities["�"]="&Ecirc;";
entities["�"]="&Euml;";
entities["�"]="&Igrave;";
entities["�"]="&Iacute;";
entities["�"]="&Icirc;";
entities["�"]="&Iuml;";
entities["�"]="&ETH;";
entities["�"]="&Ntilde;";
entities["�"]="&Ograve;";
entities["�"]="&Oacute;";
entities["�"]="&Ocirc;";
entities["�"]="&Otilde;";
entities["�"]="&Ouml;";
entities["�"]="&Oslash;";
entities["�"]="&Ugrave;";
entities["�"]="&Uacute;";
entities["�"]="&Ucirc;";
entities["�"]="&Uuml;";
entities["�"]="&THORN;";
entities["�"]="&szlig;";
entities["�"]="&agrave;";
entities["�"]="&aacute;";
entities["�"]="&acirc;";
entities["�"]="&atilde;";
entities["�"]="&auml;";
entities["�"]="&aring;";
entities["�"]="&aelig;";
entities["�"]="&eacute;";
entities["�"]="&euml;";
entities["�"]="&igrave;";
entities["�"]="&iacute;";
entities["�"]="&icirc;";
entities["�"]="&iuml;";
entities["�"]="&eth;";
entities["�"]="&ntilde;";
entities["�"]="&ograve;";
entities["�"]="&oacute;";
entities["�"]="&ocirc;";
entities["�"]="&otilde;";
entities["�"]="&ouml;";
entities["�"]="&oslash;";
entities["�"]="&uacute;";
entities["�"]="&ucirc;";
entities["�"]="&uuml;";
entities["�"]="&yacute;";
entities["�"]="&thorn;";
entities["�"]="&yuml;";
entities["�"]="&OElig;";
entities["�"]="&oelig;";
entities["�"]="&Scaron;";
entities["�"]="&scaron;";
entities["�"]="&Yuml;";
entities["�"]="&circ;";
entities["�"]="&tilde;";
entities["�"]="&ndash;";
entities["�"]="&mdash;";
entities["�"]="&lsquo;";
entities["�"]="&rsquo;";
entities["�"]="&sbquo;";
entities["�"]="&ldquo;";
entities["�"]="&rdquo;";
entities["�"]="&bdquo;";
entities["�"]="&dagger;";
entities["�"]="&Dagger;";
entities["�"]="&hellip;";
entities["�"]="&permil;";
entities["�"]="&lsaquo;";
entities["�"]="&rsaquo;";
entities["�"]="&euro;";
}*/

/**
 * Generate an IMG tag.
 */
public static function img(src:String, alt:String="image", width:Int=0, height:Int=0):String
{
    return '<img src="' + src + '" alt="' + alt + '"' +((width>0)? ' width="' + Std.string(width)+ '"':"")+((height>0)? ' height="' +Std.string(height)+ '"':"")+ '/>';
}

/**
 * Generate a P tag.
 */
public static function p(text:String, styleClass:String=null):String
{
    return styledTag("p", text, styleClass);
}

/**
 * Generate a SPAN tag.
 */
public static function span(text:String, styleClass:String=null):String
{
    return styledTag("span", text, styleClass);
}


/**
 * Generate a styled tag.
 */
public static function styledTag(tagName:String, text:String, styleClass:String):String
{
    return '<' + tagName +((styleClass!=null)? ' class="' + styleClass + '"':"")+ '>' + text + '</' + tagName + '>';
}

}