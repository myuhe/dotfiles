// ==UserScript==
// @name          Google Reader - Compact
// @namespace     http://userstyles.org
// @description	  /*====================
// @author        dowlare
// @homepage      http://userstyles.org/styles/15561
// @include       http://www.google.com/reader/*
// @include       https://www.google.com/reader/*
// ==/UserScript==
(function() {
var css = "#gbar, #global-info, .gbh, #logo-container{display:none !important;}\n\n	\n	#search{opacity:0.2;top:0 !important;left:auto !important;right:580px !important;}\n	#search:hover {opacity:1 !important; }\n\n	#main{top:0 !important;}\n	#message-area-outer{z-index:0 !important;}\n	#chrome-header{padding:2px 5px 0 !important;}\n	#viewer-top-controls, #viewer-footer{padding:2px 0!important;}\n	#entries-status{top:2px !important;}\n	#chrome-view-links{padding:0 0.5em 2px !important}\n	#viewer-top-controls{position:absolute !important;right:105px !important;top:-1px !important;border-bottom:none !important;}\n	#chrome-lhn-menu{margin-top:-2px !important;}\n	#chrome{margin-left:250px !important;}\n	.lhn-hidden #chrome{margin-left:0 !important;}\n	#nav{width:250px !important;}\n	.entry .card{border-color:#C2CFF1 !important;}\n	#current-entry .card{border-color:#6688EE !important;}\n	\n	.entry-body img{border:1px #ccc solid !important;}\n	.entry .entry-body, .entry .entry-title{max-width:none !important;}\n	.entry-body, .entry-body *{font-size:14px !important;line-height:1.5 !important;}\n	.modal-dialog-bg, .fr-modal-dialog-bg{background-color:black !important;opacity:0.1 !important}\n\n	\n	.unread span { font-size: 12px;padding: 0 !important;}\n	.unread-count { color: red;position: absolute;right: 2px !important;}\n	#lhn-add-subscription-section{display:none !important}\n\n	\n	.sub-icon ,.folder-icon { display:none !important;}\n\n	\n	#nav * { line-height:14px !important;}\n\n	\n	#entries.list .entry .collapsed { padding: 0 !important;}\n	#entries.list .collapsed .entry-main .entry-source-title,\n	#entries.list .collapsed .entry-secondary { top: 0 !important;}\n	#entries.list .collapsed .entry-icons { top: -1px !important;}\n	#entries.list .collapsed .entry-main .entry-original { top: 1px !important;}\n\n	\n	.collapsed:hover { background:#E6EAF9 !important;}\n\n	\n	.lhn-section-minimized .lhn-section-secondary\n	{display:block !important;}\n	.lhn-section-minimized #overview-selector,          \n	.lhn-section-minimized #reading-list-selector,      \n	\n	.lhn-section-minimized #your-items-tree-container,  \n	.lhn-section-minimized #trends-selector,            \n	.lhn-section-minimized #directory-selector,         \n	#lhn-selectors.lhn-section-minimized + #lhn-friends \n	{display:none !important;}\n\n	\n	.selector-icon { margin-top:0px !important; }\n	.lhn-button { top:0px !important; }\n\n	\n	#settings-frame { top:0px !important; }";
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
