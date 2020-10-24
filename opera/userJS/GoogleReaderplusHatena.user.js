// ==UserScript==
// @name          GoogleReader plus Hatena
// @namespace     http://zero-code.com/category/googlereader_puls_hatena
// @description   GoogleReader上にはてなブックマークのコメントを表示する
// @author        zero-code
// @version 0.1.0
// @include http://www.google.*/reader/*
// @include https://www.google.*/reader/*
// @exclude *.css
// @exclude *.js
// ==/UserScript==


/* -------------------------------------------------------------

GoogleReaderで「はてなブ」 - GoogleReader plus Hatena ( Greasemokey - FireFox )
当スクリプトのブックマークコメント表示は「どこでもはてブ」を元に作成しました。

The MIT License
Copyright (c) 2009 zero-code
http://zero-code.com/category/googlereader_puls_hatena

----------------------------------------------------------------

どこでもはてブ - Hatena bookmark anywhere
http://blog.masuidrive.jp/index.php/category/hba/

The MIT License
Copyright (c) 2008 Yuichiro MASUI <masui@masuidrive.jp>

------------------------------------------------------------- */

(function() {

function consoleLog( logdata ){
	if(typeof(window.console)=="object"){
		console.log(logdata);
	}
}

function consoleError( logdata ){
	if(typeof(window.console)=="object"){
		console.error(logdata);
	}
}

function findNode(root, xpath) {
	try{
		var result = document.evaluate(xpath, root, null, XPathResult.UNORDERED_NODE_SNAPSHOT_TYPE, null);
		return result.snapshotItem(0);
	}catch(e){
		return null;
	}
}

function clreatekBookmarkNumberImage( entryURL ){
	try{
		var url = entryURL.textContent.replace(/#.*/,"");
		var BookmarkImageURL = 'http://b.hatena.ne.jp/entry/image/'+url;
		var mySpan = document.createElement("span");
		mySpan.setAttribute("class","hatena-entry-number");
		mySpan.innerHTML = '<a href="http://b.hatena.ne.jp/entry/'+url+'" onClick="window.open(this.href,\'\',\'status=yes,scrollbars=yes,directories=yes,menubar=yes,resizable=yes,toolbar=yes\'); return false;" ><img src="'+ BookmarkImageURL +'" /></a>';
		
		return mySpan;
	}catch(e){
		consoleLog('clreatekBookmarkNumberImage : ERROR "'+e+'"');
		return null;
	}
}

function loadHatenaStart (){
	try{
		var mainScript = document.createElement("script");
		mainScript.setAttribute("type","text/javascript");
		mainScript.setAttribute("src","http://s.hatena.ne.jp/js/HatenaStar.js");
		document.body.appendChild(mainScript);
		
		setTimeout( function(){ setHatenaStart(); }, 100 );
		
	}catch(e){
		consoleLog('loadHatenaStart : ERROR "'+e+'"');
	}
}

function setHatenaStart (){
	try{
		
		var today = today = new Date();
		var myTime = 'add-hatena-star-'+today.getTime();
		var entries = document.getElementById('entries');
		for ( var i=0; i< entries.childNodes.length; i++ ) {
			var entry = entries.childNodes[i];
			if ( entry.getAttribute('class').match(/add-hatena-star-/) == null){
				entry.setAttribute('class',myTime+" "+entry.getAttribute('class'));
			}
		}
		
		consoleLog ( 'myTime = '+myTime );
		
		var config = document.createElement("script");
		config.setAttribute("type","text/javascript");
		config.innerHTML = "Hatena.Star.SiteConfig = { entryNodes: { 'div."+myTime+"': { uri: 'h2.entry-title a.entry-title-link', title: 'h2.entry-title', container: 'h2.entry-title' } } }; Hatena.Star.EntryLoader();";
		document.body.appendChild(config);
		
	}catch(e){
		consoleLog('setHatenaStart : ERROR "'+e+'"');
	}
}


var hatena_bookmark_anywhere_collapse = true; // trueにすると、コメントの書いてないブクマを表示しない。指定しない場合は、表示件数を超えた場合のみ表示しない
var hatena_bookmark_anywhere_url; 
var hatena_bookmark_anywhere_entryActionsNode;

function __hatena_bookmark_anywhere_receiver(json) {
	try {
		
		hatena_bookmark_anywhere_limit = 100; //コメント表示上限数
		
		var html = "";
		
		var escapeHTML = function(str) {
			str = str.replace("&","&amp;");
			str = str.replace("\"","&quot;");
			str = str.replace("'","&#039;");
			str = str.replace("<","&lt;");
			str = str.replace(">","&gt;");
			return str;
		}
		
		if(json==null) {
			html += "このエントリーのはてなブックマーク (0) <a class=\"hatena_bookmark_anywhere_go\" href=\"http://b.hatena.ne.jp/entry/"+escapeHTML(hatena_bookmark_anywhere_url)+"\">はてなブックマークのページへ飛ぶ</a>";
			html += "<a href=\"http://b.hatena.ne.jp/entry/"+escapeHTML(hatena_bookmark_anywhere_url)+"\" onclick=\"window.open(this.href,'','status=yes,scrollbars=yes,directories=yes,menubar=yes,resizable=yes,toolbar=yes'); return false;\" ><img src=\""+newWindowImage+"\" /></a><br />";
			html += "<div class=\"hatena_bookmark_anywhere_zero\">";
			html += "このページはまだブックマークされていません。";
			html += "</div>";
		} else {
			if(typeof(hatena_bookmark_anywhere_collapse)=="undefined" && json.bookmarks.length>hatena_bookmark_anywhere_limit){hatena_bookmark_anywhere_collapse = true;}
		
			html += "このエントリーのはてなブックマーク ("+json.count+") <a class=\"hatena_bookmark_anywhere_go\" href=\"http://b.hatena.ne.jp/entry/"+escapeHTML(hatena_bookmark_anywhere_url)+"\">はてなブックマークのページへ飛ぶ</a>";
			html += "<a href=\"http://b.hatena.ne.jp/entry/"+escapeHTML(hatena_bookmark_anywhere_url)+"\" onclick=\"window.open(this.href,'','status=yes,scrollbars=yes,directories=yes,menubar=yes,resizable=yes,toolbar=yes'); return false;\" ><img src=\""+newWindowImage+"\" /></a><br />";
			html += "<ul id=\"bookmarked_user\">";
			
			var commentCount = 0;
			for(var i=0; i < json.bookmarks.length && hatena_bookmark_anywhere_limit > 0; i++ ) {
				var bookmark = json.bookmarks[i];
				var t = bookmark.timestamp.split(" ")[0].split("/");
				var tags = [];
				for(var j=0; j<json.bookmarks[i].tags.length; ++j) {
					var tag = json.bookmarks[i].tags[j];
					tags.push("<a href=\"http://b.hatena.ne.jp/"+bookmark.user+"/"+tag+"\">"+escapeHTML(tag)+"</a>");
				}
				
				if(hatena_bookmark_anywhere_collapse!=true || bookmark.comment!='') {
					commentCount++;
					html += "<li><span class=\"__hatena_bookmark_anywhere_timestamp\">"+escapeHTML(t[0])+"年"+escapeHTML(t[1])+"月"+escapeHTML(t[2])+"日</span><img src=\"http://www.hatena.ne.jp/users/"+escapeHTML(bookmark.user.substring(0,2))+"/"+bookmark.user+"/profile_s.gif\" width=\"16\" height=\"16\"><a href=\"http://b.hatena.ne.jp/"+escapeHTML(bookmark.user)+"/"+escapeHTML(t.join(""))+"\" class=\"hatena_bookmark_anywhere_user\">"+escapeHTML(bookmark.user)+"</a><span class=\"hatena_bookmark_anywhere_tags\">"+tags.join(", ")+"</span>"+escapeHTML(bookmark.comment)+"</li>";
					hatena_bookmark_anywhere_limit--;
				}
			}
			
			if ( commentCount == 0 ){
				html += '<p class="noComment">このエントリーにはコメントはありませんでした。</p>';
			}
			
			html += "</ul>";
		}
		
		var wrap = document.createElement("div");
		wrap.setAttribute("class","hatena_bookmark_anywhere");
		wrap.innerHTML = html;
		
		//document.getElementById("hatena_bookmark_anywhere").appendChild(wrap);
		hatena_bookmark_anywhere_entryActionsNode.appendChild(wrap);
		
	}catch(e){
		consoleLog( '__HBAR_receiver : ERROR "'+e+'"' )
	}
}


/* Safaru Only 
var jsonNameChekerNumber = 0;
function jsonNameCheker(jsonName,entryURL,entryActions){
	jsonNameChekerNumber++;
	if(jsonNameChekerNumber == 20){
		__hatena_bookmark_anywhere_receiver(null,entryURL,entryActions);
		consoleLog('jsonNameCheker : 10回チェックを行いましたが値はありません。');
		jsonNameChekerNumber = 0;
		
		var loadimage = findNode( entryActions, './/div[@class="loadimage"]' );
		entryActions.removeChild(loadimage);
		
	}else if ( eval(jsonName) == null ){
		setTimeout(function(){jsonNameCheker(jsonName,entryURL,entryActions);},250);
		consoleLog('jsonNameCheker : json = null. sleep 0.100s');
		consoleLog('jsonNameCheker : jsonNameChekerNumber = '+ jsonNameChekerNumber);
		jsonNameChekerNumber = 0;
	}else{
		__hatena_bookmark_anywhere_receiver(eval(jsonName),entryURL,entryActions);
		consoleLog('jsonNameCheker : __hatena_bookmark_anywhere_receiver();を実行しました。');
		
		setTimeout(function(){
			eval('delete '+jsonName);
			consoleLog('jsonNameCheker : キャッシュしていたjson "'+ jsonName +'" を削除しました')
		},2000);
		
		var loadimage = findNode( entryActions, './/div[@class="loadimage"]' );
		entryActions.removeChild(loadimage);
		jsonNameChekerNumber = 0;
	}
	
	
}
*/


function __hatena_bookmark_anywhere_load(event) {
	
	try {
		var eventTarget = event.target;
		var entryActions = findNode( eventTarget, 'ancestor::div[@class="entry-actions"]' );
		var entryURL = findNode( eventTarget, 'ancestor::div[@class="card card-common" or @class="entry read expanded" or @class="entry read read-state-locked expanded" or @class="entry expanded read"] //a[@class="entry-title-link"]/@href' ) ;
		
		if( entryURL != null) {
			entryURL = entryURL.textContent.replace(/#.*/,"");
			consoleLog('__HBA_load : current-entryのURLを確認 "'+entryURL+'"');
			
			today = new Date();
			var myDate = today.getTime();
			var jsonFunctionName = '__hatena_bookmark_anywhere_receiver';
			
			var jsonurl = "http://b.hatena.ne.jp/entry/json/?url="+entryURL+"&callback="+jsonFunctionName;
			
			var wrap = document.createElement("div");
			wrap.setAttribute("class","loadimage");
			wrap.innerHTML = '<img src="'+ loadImage +'" />';
			entryActions.appendChild(wrap);
		
			var hatena_bookmark_anywhere = findNode( entryActions, './/div[@class="hatena_bookmark_anywhere"]' );
			if ( hatena_bookmark_anywhere != null ){
				entryActions.removeChild(hatena_bookmark_anywhere);
			}
			
			GM_xmlhttpRequest({
				method:"GET", 
				url:"http://b.hatena.ne.jp/entry/json/?url="+ entryURL +"&callback="+jsonFunctionName,
				onload:function(x){
					hatena_bookmark_anywhere_url = entryURL;
					hatena_bookmark_anywhere_entryActionsNode = entryActions;
					eval("(" + x.responseText + ")");
					
					var loadimage = findNode( entryActions, './/div[@class="loadimage"]' );
					entryActions.removeChild(loadimage);
				}
			});
			consoleLog('__HBA_load : json loading "'+jsonurl+'"');
		}
	}catch(e){
		consoleLog('__HBA_load : ERROR "'+e+'"');
	}
}



//ボタンを生成
var timeID = null;
var myStyle = null;

function addButton(){
	
	//addButton
	try{
		var entries = document.getElementById('entries');
		var onButton = null;
		
		/* 記事毎のLoop */
		for ( var i=0; i< entries.childNodes.length; i++ ) {
			var entry = entries.childNodes[i];
			var actions = findNode(entry, './/div[@class="entry-actions"]');
			var entryURL = findNode( entry, './/div[@class="entry-main"] //a[@class="entry-original" or @class="entry-title-link"]/@href' );
			
				
			/* actionエリアに ブックマークコメント表示用ボタンを設置 */
			var hatenaButton = findNode(entry, './/span[@class="hatenaButton"]');
			if ( actions != null && hatenaButton == null ){
				today = new Date();
				var myDate = today.getTime();
				var span = document.createElement("span");
				
				span.setAttribute('class','hatenaButton');
				span.setAttribute('id',myDate);
				span.innerHTML = "<a href='javascript:void[0]'>HatenaB</a>";
				
				var BookmarkNumberImage = clreatekBookmarkNumberImage( entryURL );
				actions.appendChild(span).appendChild(BookmarkNumberImage);
				//actions.appendChild(BookmarkNumberImage);
				
				var createSpan = findNode( actions, './/span[@id="'+myDate+'"] //a' );
				createSpan.addEventListener("click", function(event){ __hatena_bookmark_anywhere_load(event); }, false);
				
			}
			
			/* ブックマーク数の表示 */
			var entryTitle = findNode(entry, './/h2[@class="entry-title"]');
			var hatenaEntryNumber = findNode(entryTitle, './/span[@class="hatena-entry-number"]');
			if( entryTitle != null && hatenaEntryNumber == null ){
				var BookmarkNumberImage = clreatekBookmarkNumberImage( entryURL );
				entryTitle.appendChild( BookmarkNumberImage );
			}
		}
		
	}catch(e){
		consoleLog('addButton : ERROR "'+e+'"');
	}
	
	
	
	// addStyle
	
	// http://juce6ox.blogspot.com/2007/11/cssdom.html
	// by latchet
	var addCSSRule = (document.createStyleSheet) ? (function(sheet){
		return function(selector, declaration){ sheet.addRule(selector, declaration); };
	})	
	(document.createStyleSheet()) : (function(sheet){
		return function(selector, declaration){  sheet.insertRule(selector + '{' + declaration + '}', sheet.cssRules.length); };
	})
	((function(e){
		e.appendChild(document.createTextNode(''));
		(document.getElementsByTagName('head')[0] || (function(h){ document.documentElement.insertBefore(h, this.firstChild); return h; })
		(document.createElement('head'))).appendChild(e);
		return e.sheet;
	})
	(document.createElement('style')))
	
	if ( myStyle == null ){
		try{
			addCSSRule(".hatena_bookmark_anywhere", "font-family: \"Arial\", sans-serif; color: #333; margin: 1em 0 ;");
			addCSSRule(".hatena_bookmark_anywhere * ", "margin: 0 ; padding: 0; text-align: left; font-weight: normal; font-family: \"Arial\", sans-serif;");
			addCSSRule(".hatena_bookmark_anywhere .hatena_bookmark_anywhere_zero", "background-color:#edf1fd; border-top:1px solid #5279e7; border-right: 1px solid #ccc; border-bottom: 1px solid #ccc; border-left: 1px solid #ccc; list-style-position: inside; margin:2px 0 0 0;padding: 8px 5px 12px 8px;");
			addCSSRule(".hatena_bookmark_anywhere ul", "background-color:#edf1fd; border-top:1px solid #5279e7; border-right: 1px solid #ccc; border-bottom: 1px solid #ccc; border-left: 1px solid #ccc; list-style-position: inside; margin:2px 0 0 0;padding: 8px 5px 12px 8px;");
			addCSSRule(".hatena_bookmark_anywhere ul li", "list-style-type: circle; padding: 1px 0;");
			addCSSRule(".hatena_bookmark_anywhere a.hatena_bookmark_anywhere_user", "color: #2244BB; text-decoration: none; margin: 0 2px;");
			addCSSRule(".hatena_bookmark_anywhere .hatena_bookmark_anywhere_tags", "font-size: 90%; color: #2244BB; margin: 0 4px 0 2px;");
			addCSSRule(".hatena_bookmark_anywhere .hatena_bookmark_anywhere_tags a", "text-decoration: none; color: #7C8CC5;");
			addCSSRule(".hatena_bookmark_anywhere a.hatena_bookmark_anywhere_go", "color: #7C8CC5; text-decoration: none; margin-right:3px;");
			addCSSRule(".hatena_bookmark_anywhere a img", "border:0;");
			addCSSRule(".hatenaButton ", "padding:1px 8px 1px 18px; background:transparent url(\""+hatenaBImage+"\") no-repeat scroll 0 1px;");
			addCSSRule(".hatena-entry-number ", "margin:0 5px");
			addCSSRule(".hatena-entry-number a img", "border:0;");
			addCSSRule(".hatenaButton .hatena-entry-number img", "margin:0 5px;vertical-align:text-bottom;");
			
			myStyle = 1;
			
			// Start HatebaStar
			loadHatenaStart();
			
		}catch(e){
			consoleLog('addButton (addStyle) : ERROR "'+e+'"');
		}
	}else{
		setHatenaStart();
	}
	
	
	
}

var newWindowImage = 'data:image/gif;base64,R0lGODlhCwAIAJECAP///3yMxf///wAAACH5B'+
    'AEAAAIALAAAAAALAAgAAAIUjB+iEuCeFprntQeMpRPnxXiRwhUAOw==';

var hatenaBImage = 'data:image/gif;base64,R0lGODlhEAAMAJECAP///8vY8P///wAAACH5BAE'+
    'AAAIALAAAAAAQAAwAAAIjVI6ZBu3/TlNOAovD1JfnDXZJ+IGl1UFlelLpC8WXodSHUAAAOw==';

var loadImage = 'data:image/gif;base64,'+
    'R0lGODlhEAAQAPQAAPP1/JmZmfDy+aytrsfIy5qamqamp+Tm7NPV2aCgoMHCxry9wOnq8c7P097f'+
    '5bGytLe3ugAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH+GkNy'+
    'ZWF0ZWQgd2l0aCBhamF4bG9hZC5pbmZvACH5BAAKAAAAIf8LTkVUU0NBUEUyLjADAQAAACwAAAAA'+
    'EAAQAAAFUCAgjmRpnqUwFGwhKoRgqq2YFMaRGjWA8AbZiIBbjQQ8AmmFUJEQhQGJhaKOrCksgEla'+
    '+KIkYvC6SJKQOISoNSYdeIk1ayA8ExTyeR3F749CACH5BAAKAAEALAAAAAAQABAAAAVoICCKR9KM'+
    'aCoaxeCoqEAkRX3AwMHWxQIIjJSAZWgUEgzBwCBAEQpMwIDwY1FHgwJCtOW2UDWYIDyqNVVkUbYr'+
    '6CK+o2eUMKgWrqKhj0FrEM8jQQALPFA3MAc8CQSAMA5ZBjgqDQmHIyEAIfkEAAoAAgAsAAAAABAA'+
    'EAAABWAgII4j85Ao2hRIKgrEUBQJLaSHMe8zgQo6Q8sxS7RIhILhBkgumCTZsXkACBC+0cwF2GoL'+
    'LoFXREDcDlkAojBICRaFLDCOQtQKjmsQSubtDFU/NXcDBHwkaw1cKQ8MiyEAIfkEAAoAAwAsAAAA'+
    'ABAAEAAABVIgII5kaZ6AIJQCMRTFQKiDQx4GrBfGa4uCnAEhQuRgPwCBtwK+kCNFgjh6QlFYgGO7'+
    'baJ2CxIioSDpwqNggWCGDVVGphly3BkOpXDrKfNm/4AhACH5BAAKAAQALAAAAAAQABAAAAVgICCO'+
    'ZGmeqEAMRTEQwskYbV0Yx7kYSIzQhtgoBxCKBDQCIOcoLBimRiFhSABYU5gIgW01pLUBYkRItAYA'+
    'qrlhYiwKjiWAcDMWY8QjsCf4DewiBzQ2N1AmKlgvgCiMjSQhACH5BAAKAAUALAAAAAAQABAAAAVf'+
    'ICCOZGmeqEgUxUAIpkA0AMKyxkEiSZEIsJqhYAg+boUFSTAkiBiNHks3sg1ILAfBiS10gyqCg0Ua'+
    'FBCkwy3RYKiIYMAC+RAxiQgYsJdAjw5DN2gILzEEZgVcKYuMJiEAOwAAAAAAAAAAAA==';

timeID = setInterval(addButton, 3000);

consoleLog( ': check ok' );

})();
