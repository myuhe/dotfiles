// ==UserScript==
// @name          Google Calendar - remove all decoration
// @namespace     http://userstyles.org
// @description	  Removes most useless decoration from Google Calendar.
// @author        Akral
// @homepage      http://userstyles.org/styles/50227
// @include       http://www.google.com/calendar/*
// @include       https://www.google.com/calendar/*
// ==/UserScript==
(function() {
var css = "rule_to_fade { opacity: 0; -webkit-transition: opacity 1s 0.2s }\n\nrule_to_show { opacity: 1 }\n\n #gb,\n .domainlogoparent,\n #vr-proto-nav,\nrule_to_hide { display: none !important; }\n\nrule_to_hide_borders { border: 0 !important }\n\nrule_to_hide_backgrounds { background: none !important; }\n\n\n\n#vr-proto-header { height: 10px; -webkit-transition: height 1s 1s; overflow: hidden }\n#vr-proto-header:hover { height: 70px }\n#vr-proto-header > * {  }\n\n#mainbody { padding-top: 0 }\n#nav { margin-left: 10px }\n#mainbody { margin-left: 170px }";
if (typeof GM_addStyle != "undefined") {
	GM_addStyle(css);
} else if (typeof PRO_addStyle != "undefined") {
	PRO_addStyle(css);
} else if (typeof addStyle != "undefined") {
	addStyle(css);
} else {
	var heads = document.getElementsByTagName("head");
	if (heads.length > 0) {
		var node = document.createElement("style");
		node.type = "text/css";
		node.appendChild(document.createTextNode(css));
		heads[0].appendChild(node); 
	}
}
})();
