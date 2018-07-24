var __DEV__=false,__BUNDLE_START_TIME__=this.nativePerformanceNow?nativePerformanceNow():Date.now(),process=this.process||{};process.env=process.env||{};process.env.NODE_ENV="production";
!(function(r){'use strict';r.require=n,r.__d=function(r,n,o){if(null!=t[n])return;t[n]={dependencyMap:o,exports:void 0,factory:r,hasError:!1,isInitialized:!1}};const t='number'==typeof __NUM_MODULES__?Array(0|__NUM_MODULES__):Object.create(null);function n(r){const n=r,o=t[n];return o&&o.isInitialized?o.exports:i(n,o)}let o=!1;function i(t,n){if(!o&&r.ErrorUtils){let i;o=!0;try{i=s(t,n)}catch(t){r.ErrorUtils.reportFatalError(t)}return o=!1,i}return s(t,n)}const c=16,u=65535;function d(r){return{segmentId:r>>>c,localId:r&u}}function s(o,i){!i&&r.__defineModule&&(r.__defineModule(o),i=t[o]);const c=r.nativeRequire;if(!i&&c){var u=d(o);const r=u.segmentId;c(u.localId,r),i=t[o]}if(!i)throw a(o);if(i.hasError)throw l(o,i.error);i.isInitialized=!0;const s=i.exports={};var f=i;const p=f.factory,_=f.dependencyMap;try{const t={exports:s};return p(r,n,t,s,_),i.factory=void 0,i.dependencyMap=void 0,i.exports=t.exports}catch(r){throw i.hasError=!0,i.error=r,i.isInitialized=!1,i.exports=void 0,r}}function a(r){return Error('Requiring unknown module "'+r+'".')}function l(r,t){return Error('Requiring module "'+r+'", which threw an exception: '+t)}n.unpackModuleId=d,n.packModuleId=function(r){return r.segmentId<<c+r.localId}})(this);
__d(function(g,r,m,e,d){"use strict";r(d[0]);var t,a=(t=r(d[1]))&&t.__esModule?t:{default:t};navigate(a.default,'Home')},0,[1,2]);
__d(function(g,r,m,e,d){log(Object.keys(g)),fetch=((t,a)=>new Promise((c,o)=>{makeHttpRequest({url:t,method:(a||{}).method||'GET',callback:t=>{200===t.statusCode?c(t):o(t)}})})),fetchJson=((t,a)=>fetch(t,a).then(({data:t})=>JSON.parse(t)))},1,[]);
__d(function(g,r,m,e,d){"use strict";Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0;var t=i(r(d[0])),n=i(r(d[1])),o=i(r(d[2]));function i(t){return t&&t.__esModule?t:{default:t}}function l(t,n){if(!(t instanceof n))throw new TypeError("Cannot call a class as a function")}var u=function i(u){l(this,i),this.render=u,u({type:'View',flex:1,backgroundColor:'white',justifyContent:'center',alignItems:'center',children:[{type:'Text',text:'Welcome!',color:'black',fontSize:50},{type:'Button',title:'Next Screen',color:'blue',onPress:function(){return navigate(t.default,'Add Cards')}},{type:'Button',title:'Collection View Screen',color:'blue',onPress:function(){return navigate(n.default,'Collection View')}},{type:'Button',title:'GitHub Data Screen',color:'blue',onPress:function(){return navigate(o.default,'GitHub User Search')}}]})};e.default=u},2,[3,4,5]);
__d(function(g,r,m,e,d){"use strict";function t(t,n){if(!(t instanceof n))throw new TypeError("Cannot call a class as a function")}function n(t,n){for(var a=0;a<n.length;a++){var i=n[a];i.enumerable=i.enumerable||!1,i.configurable=!0,"value"in i&&(i.writable=!0),Object.defineProperty(t,i.key,i)}}Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0;var a=(function(){function a(n){t(this,a),this.render=n,this.cards=[],this.cardColors=['red','green','blue','yellow','purple'],this.handleAddCard=this.handleAddCard.bind(this),this.handleRemoveCard=this.handleRemoveCard.bind(this),this.renderCards=this.renderCards.bind(this),this.renderCards()}var i,o,s;return i=a,(o=[{key:"handleAddCard",value:function(){var t=this.cards.length;this.cards.push({type:'View',flex:1,height:1,backgroundColor:this.cardColors[(t+1)%this.cardColors.length]}),this.renderCards()}},{key:"handleRemoveCard",value:function(){this.cards.pop(),this.renderCards()}},{key:"renderCards",value:function(){this.render({type:'View',flex:1,backgroundColor:'white',children:[{type:'View',flexDirection:'row',justifyContent:'spaceAround',children:[{type:'Button',title:'Add Card',color:'blue',onPress:this.handleAddCard},{type:'Button',title:'Remove Card',color:'red',onPress:this.handleRemoveCard}]}].concat(this.cards)})}}])&&n(i.prototype,o),s&&n(i,s),a})();e.default=a},3,[]);
__d(function(g,r,m,e,d){"use strict";function t(t,n){if(!(t instanceof n))throw new TypeError("Cannot call a class as a function")}function n(t,n){for(var i=0;i<n.length;i++){var o=n[i];o.enumerable=o.enumerable||!1,o.configurable=!0,"value"in o&&(o.writable=!0),Object.defineProperty(t,o.key,o)}}Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0;var i=(function(){function i(n){t(this,i),this.render=n,this.itemsPerSection=0,this.handleAddCard=this.handleAddCard.bind(this),this.renderCards=this.renderCards.bind(this),addOrientationChangeListener(this.renderCards),this.renderCards()}var o,a,s;return o=i,(a=[{key:"handleAddCard",value:function(){this.itemsPerSection+=1,this.renderCards()}},{key:"renderCards",value:function(){this.render({type:'View',flex:1,backgroundColor:'white',children:[{type:'Button',title:'Add Card',color:'blue',onPress:this.handleAddCard},{type:'CollectionView',flex:1,itemsPerSection:this.itemsPerSection,minimumLineSpacing:2,sectionInsets:{top:0,bottom:0,left:0,right:0},itemSize:{width:screenWidth(),height:60},renderItem:function(t){return{type:'View',flex:1,justifyContent:'center',alignItems:'center',backgroundColor:'orange',children:[{type:'Button',title:t,color:'blue',onPress:function(){return log("Cell Index: ".concat(t))}}]}}}]})}}])&&n(o.prototype,a),s&&n(o,s),i})();e.default=i},4,[]);
__d(function(g,r,m,e,d){"use strict";function t(t,n){if(!(t instanceof n))throw new TypeError("Cannot call a class as a function")}function n(t,n){for(var i=0;i<n.length;i++){var o=n[i];o.enumerable=o.enumerable||!1,o.configurable=!0,"value"in o&&(o.writable=!0),Object.defineProperty(t,o.key,o)}}Object.defineProperty(e,"__esModule",{value:!0}),e.default=void 0;var i=(function(){function i(n){var o=this;t(this,i),this.render=n,this.handleJson=this.handleJson.bind(this),this.inputText='',this.topSectionView={type:'View',alignItems:'center',backgroundColor:'white',children:[{type:'Text',text:'Enter a username and press Search.',fontSize:20,color:'black'},{type:'TextField',placeholder:'Enter Username',width:175,height:40,borderColor:'gray',borderWidth:1,borderRadius:5,onPress:function(t){o.inputText=t}},{type:'Button',color:'blue',title:'Search',borderColor:'blue',borderWidth:1,borderRadius:5,margin:15,paddingLeft:25,paddingRight:25,onPress:function(){fetchJson("https://api.github.com/users/".concat(o.inputText)).then(o.handleJson)}}]},this.keys=['login','id','type','company','blog','location','email','bio'],this.render(this.topSectionView)}var o,a,l;return o=i,(a=[{key:"handleJson",value:function(t){this.inputText='';var n=this.keys.map(function(n){return[n,t[n]]});this.render({type:'View',flex:1,backgroundColor:'white',children:[this.topSectionView,{type:'CollectionView',flex:1,backgroundColor:'white',itemsPerSection:n.length,sectionInsets:{top:10,bottom:10,left:10,right:10},itemSize:{width:screenWidth(),height:75},renderItem:function(t){return{type:'View',flex:1,backgroundColor:'white',children:[{type:'Text',text:n[t][0],color:'black',fontSize:15},{type:'Text',text:n[t][1],color:'black',fontSize:20}]}}}]})}}])&&n(o.prototype,a),l&&n(o,l),i})();e.default=i},5,[]);
require(0);