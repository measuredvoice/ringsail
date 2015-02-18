function externalLinks() {
  if (!document.getElementsByTagName) return;
  var anchors = document.getElementsByTagName("a");
  for (var i=0; i<anchors.length; i++) {
    var anchor = anchors[i];
    if (anchor.getAttribute("href") &&
      anchor.getAttribute("rel") == "external")
      anchor.target = "_blank";
  }
}

window.onload = externalLinks;

jQuery(window).load(function() {
  jQuery("#topofpage").hide().removeAttr("href");
  if (jQuery(window).scrollTop() != "0")
    jQuery("#backtotop").fadeIn("fast")
  var scrollDiv = jQuery("#backtotop");
  jQuery(window).scroll(function(){
    if (jQuery(window).scrollTop() == "0")
      jQuery(scrollDiv).fadeOut("fast")
    else
      jQuery(scrollDiv).fadeIn("fast")
  });
  jQuery("#backtotop").click(function() {
    jQuery("html, body").animate({
      scrollTop: 0
    }, "fast")
  })
});

jQuery(function( $ ){
  jQuery(window).scroll(function() {
    var yPos = ( jQuery(window).scrollTop() );
    if(yPos > 200) { // show fixed nav bar after screen has scrolled down 200px from the top
      jQuery("#fixednav").fadeIn('fast');
    } else {
      jQuery("#fixednav").fadeOut('fast');
    }
  });
});

//Start Sites.usa.gov Addition for removing focus from page on keyboard escape
jQuery(document).keyup(function(e) {
  if (e.keyCode == 27) {
    console.log('esc')
    jQuery( ":focus" ).blur()
   }
});
//End Sites.usa.gov Addition

function callPlayer(frame_id, func, args) {
  if (window.jQuery && frame_id instanceof jQuery) frame_id = frame_id.get(0).id;
  var iframe = document.getElementById(frame_id);
  if (iframe && iframe.tagName.toUpperCase() != 'IFRAME') {
    iframe = iframe.getElementsByTagName('iframe')[0];
  }

  // When the player is not ready yet, add the event to a queue
  // Each frame_id is associated with an own queue.
  // Each queue has three possible states:
  //  undefined = uninitialised / array = queue / 0 = ready
  if (!callPlayer.queue) callPlayer.queue = {};
  var queue = callPlayer.queue[frame_id],
    domReady = document.readyState == 'complete';

  if (domReady && !iframe) {
    // DOM is ready and iframe does not exist. Log a message
    window.console && console.log('callPlayer: Frame not found; id=' + frame_id); 
    if (queue) clearInterval(queue.poller);
  } else if (func === 'listening') {
    // Sending the "listener" message to the frame, to request status updates 
    if (iframe && iframe.contentWindow) {
      func = '{"event":"listening","id":' + JSON.stringify(''+frame_id) + '}';
      iframe.contentWindow.postMessage(func, '*');
    }
  } else if (!domReady || iframe && (!iframe.contentWindow || queue && !queue.ready)) {
    if (!queue) queue = callPlayer.queue[frame_id] = [];
    queue.push([func, args]);
    if (!('poller' in queue)) {
      // keep polling until the document and frame is ready
      queue.poller = setInterval(function() {
        callPlayer(frame_id, 'listening');
      }, 250);
      // Add a global "message" event listener, to catch status updates:
      messageEvent(1, function runOnceReady(e) {
        var tmp = JSON.parse(e.data);
        if (tmp && tmp.id == frame_id && tmp.event == 'onReady') {
          // YT Player says that they're ready, so mark the player as ready
          clearInterval(queue.poller);
          queue.ready = true;
          messageEvent(0, runOnceReady);
          // .. and release the queue:
          while (tmp = queue.shift()) {
            callPlayer(frame_id, tmp[0], tmp[1]);
          }
        }
      }, false);
    }
  } else if (iframe && iframe.contentWindow) {
    // When a function is supplied, just call it (like "onYouTubePlayerReady")
    if (func.call) return func();
    // Frame exists, send message
    iframe.contentWindow.postMessage(JSON.stringify({
      "event": "command",
      "func": func,
      "args": args || [],
      "id": frame_id
    }), "*");
  }

  /* IE8 does not support addEventListener... */
  function messageEvent(add, listener) {
    var w3 = add ? window.addEventListener : window.removeEventListener;  
    w3 ?
      w3('message', listener, !1)
    :
      (add ? window.attachEvent : window.detachEvent)('onmessage', listener);
  }

}

jQuery(window).load(function() {

  var vimeoPlayers = jQuery('.flexslider').find('iframe'), player;
  
  for (var i = 0, length = vimeoPlayers.length; i < length; i++) {        
    player = vimeoPlayers[i];         
    $f(player).addEvent('ready', ready);    
  }
  
  function addEvent(element, eventName, callback) {         
    if (element.addEventListener) {           
      element.addEventListener(eventName, callback, false)        
    } else {            
      element.attachEvent(eventName, callback, false);          
    }       
  }
  
  function ready(player_id) {         
    var froogaloop = $f(player_id);         
  }

  // NARROW SLIDER NAV
  jQuery('#featured-narrow-thumbnav').flexslider({
    animation:'slide',
    controlNav:false,
    animationLoop:true,
    slideshow: false,
    animationSpeed:300,
    useCSS:false,
    itemWidth:133,
    itemMargin:0,
    asNavFor: '#featured'
  });

  // NARROW FEATURED CONTENT SLIDER
  jQuery('#featured').flexslider({
    animation:'slide',
    controlNav:true,
    animationLoop:true,
    slideshow: false,
    useCSS:false,
    smoothHeight:true,
    animationSpeed:300,
    sync: '#featured-narrow-thumbnav',
    controlsContainer: '.narrow-slider',
    before: function(slider) {         
      if (slider.slides.eq(slider.currentSlide).find('iframe').length !== 0)
        $f(slider.slides.eq(slider.currentSlide).find('iframe').attr('id') ).api('pause');
      if (slider.slides.eq(slider.currentSlide).find('iframe[src*="youtube"]').length !== 0)
        callPlayer(slider.slides.eq(slider.currentSlide).find('iframe[src*="youtube"]').attr('id'), 'pauseVideo');
    }
  });

  // WIDE SLIDER NAV
  jQuery('#featured-wide-thumbnav').flexslider({
    animation:'slide',
    controlNav:false,
    animationLoop:true,
    slideshow:false,
    animationSpeed:300,
    useCSS:false,
    itemWidth:90,
    itemMargin:0,
    asNavFor: '#featured-wide'
  });


  // WIDE FEATURED CONTENT SLIDER
  jQuery('#featured-wide').flexslider({
    animation:'slide',
    controlNav:true,
    animationLoop:true,
    slideshow: false,
    useCSS:false,
    smoothHeight:true,
    animationSpeed:300,
    sync: "#featured-wide-thumbnav",
    manualControls: '.wide-custom-controls li a',
    controlsContainer: '.wide-slider',
    before: function(slider) {         
      if (slider.slides.eq(slider.currentSlide).find('iframe').length !== 0)
        $f(slider.slides.eq(slider.currentSlide).find('iframe').attr('id') ).api('pause');
      if (slider.slides.eq(slider.currentSlide).find('iframe[src*="youtube"]').length !== 0)
        callPlayer(slider.slides.eq(slider.currentSlide).find('iframe[src*="youtube"]').attr('id'), 'pauseVideo');
    }
  });

  // FEATURED PAGES SLIDER NAV
  jQuery('#featured-pages-thumbnav').flexslider({
    animation:'slide',
    controlNav:false,
    animationLoop:true,
    slideshow:false,
    animationSpeed:300,
    useCSS:false,
    itemWidth:90,
    itemMargin:0,
    asNavFor: '#featured-pages'
  });


  // FEATURED PAGES SLIDER
  jQuery('#featured-pages').flexslider({
    animation:'slide',
    controlNav:true,
    animationLoop:true,
    slideshow: false,
    useCSS:false,
    animationSpeed:300,
    sync: "#featured-pages-thumbnav",
    controlsContainer: '.pages-slider',
    before: function(slider) {         
      if (slider.slides.eq(slider.currentSlide).find('iframe').length !== 0)
        $f(slider.slides.eq(slider.currentSlide).find('iframe').attr('id') ).api('pause');
      if (slider.slides.eq(slider.currentSlide).find('iframe[src*="youtube"]').length !== 0)
        callPlayer(slider.slides.eq(slider.currentSlide).find('iframe[src*="youtube"]').attr('id'), 'pauseVideo');
    }
  });

  // YOUTUBE VIDEOS WIDGET SLIDER
  jQuery('#featured-yt-vids').flexslider({
    animation:'slide',
    slideshow: false,
    useCSS:false,
    smoothHeight:true,
    directionNav:false,
    animationSpeed:300,
    manualControls: '.youtube-custom-controls li a',
    controlsContainer: ".yt-vids-slider",
    before: function(slider) {
      if (slider.slides.eq(slider.currentSlide).find('iframe[src*="youtube"]').length !== 0)
        callPlayer(slider.slides.eq(slider.currentSlide).find('iframe[src*="youtube"]').attr('id'), 'pauseVideo');
    }
  });

  // YOUTUBE VIDEOS PAGE TEMPLATE SLIDER  
  jQuery('#featured-yt-vids-page').flexslider({
    animation:'slide',
    slideshow: false,
    useCSS:false,
    smoothHeight:true,
    animationSpeed:800,
    manualControls: '.youtube-page-custom-controls li a',
    controlsContainer: '.yt-vids-page-slider',
    before: function(slider) {
      if (slider.slides.eq(slider.currentSlide).find('iframe[src*="youtube"]').length !== 0)
        callPlayer(slider.slides.eq(slider.currentSlide).find('iframe[src*="youtube"]').attr('id'), 'pauseVideo');
    }
  });

  // SIDETABS WIDGET
  jQuery('#flextabs').flexslider({
    animation:'slide',
    slideshow: false,
    useCSS:false,
    smoothHeight:true,
    animationSpeed:0000,
    directionNav:false,
    manualControls: '.flextabs-custom-controls li a',
    controlsContainer: ".flextabs"
  });

  jQuery('.youtube-page-custom-controls li').bind("click touchend", function(){
    location.href="#featured-yt-vids-page";
  });

  jQuery('.clone').find('iframe').each(function(i, e){
    jQuery(e).attr('id', jQuery(e).attr('id') + '_clone');
  });

});

/*!
 * hoverIntent r7 // 2013.03.11 // jQuery 1.9.1+
 * http://cherne.net/brian/resources/jquery.hoverIntent.html
 *
 * You may use hoverIntent under the terms of the MIT license.
 * Copyright 2007, 2013 Brian Cherne
 */
(function(e){e.fn.hoverIntent=function(t,n,r){var i={interval:100,sensitivity:7,timeout:0};if(typeof t==="object"){i=e.extend(i,t)}else if(e.isFunction(n)){i=e.extend(i,{over:t,out:n,selector:r})}else{i=e.extend(i,{over:t,out:t,selector:n})}var s,o,u,a;var f=function(e){s=e.pageX;o=e.pageY};var l=function(t,n){n.hoverIntent_t=clearTimeout(n.hoverIntent_t);if(Math.abs(u-s)+Math.abs(a-o)<i.sensitivity){e(n).off("mousemove.hoverIntent",f);n.hoverIntent_s=1;return i.over.apply(n,[t])}else{u=s;a=o;n.hoverIntent_t=setTimeout(function(){l(t,n)},i.interval)}};var c=function(e,t){t.hoverIntent_t=clearTimeout(t.hoverIntent_t);t.hoverIntent_s=0;return i.out.apply(t,[e])};var h=function(t){var n=jQuery.extend({},t);var r=this;if(r.hoverIntent_t){r.hoverIntent_t=clearTimeout(r.hoverIntent_t)}if(t.type=="mouseenter"){u=n.pageX;a=n.pageY;e(r).on("mousemove.hoverIntent",f);if(r.hoverIntent_s!=1){r.hoverIntent_t=setTimeout(function(){l(n,r)},i.interval)}}else{e(r).off("mousemove.hoverIntent",f);if(r.hoverIntent_s==1){r.hoverIntent_t=setTimeout(function(){c(n,r)},i.timeout)}}};return this.on({"mouseenter.hoverIntent":h,"mouseleave.hoverIntent":h},i.selector)}})(jQuery)

sfHover = function() {
  var sfEls = document.getElementById("topnav").getElementsByTagName("li");
  for (var i=0; i<sfEls.length; i++) {
    sfEls[i].onmouseover=function() {
      this.className+=" sfhover";
    }
    sfEls[i].onmouseout=function() {
      this.className=this.className.replace(new RegExp(" sfhover\\b"), "");
    }
  }
}
if (window.attachEvent) window.attachEvent("onload", sfHover);


sfHover = function() {
  var sfEls = document.getElementById("catnav").getElementsByTagName("li");
  for (var i=0; i<sfEls.length; i++) {
    sfEls[i].onmouseover=function() {
      this.className+=" sfhover";
    }
    sfEls[i].onmouseout=function() {
      this.className=this.className.replace(new RegExp(" sfhover\\b"), "");
    }
  }
}
if (window.attachEvent) window.attachEvent("onload", sfHover);

  