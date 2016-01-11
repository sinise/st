// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require ../../../vendor/assets/javascripts/jquery-ui-1.10.3.custom.min
//= require_tree ../../../vendor/assets/javascripts/.
//= stub "icon-font-ie7.js"
//= require_tree .

/*
 require turbolinks

// Some general UI pack related JS
// Extend JS String with repeat method
String.prototype.repeat = function(num) {
    return new Array(num + 1).join(this);
};



(function($) {


  // Add segments to a Sliders
  $.fn.addSliderSegments = function (amount) {
    return this.each(function () {
      var segmentGap = 100 / (amount - 1) + "%"
        , segment = "<div class='ui-slider-segment' style='margin-left: " + segmentGap + ";'></div>";
      $(this).prepend(segment.repeat(amount - 2));
    });
  };



  $(function() {
		$("select").selectpicker({style: 'btn btn-primary', menuStyle: 'dropdown-inverse'});
    $('textarea').autosize();

    $('.timepicker').timepicker({
			minTime: '00:00',
			maxTime: '23:50',
    	disableTextInput: true,
    	step:10,
    	scrollDefaultTime: '07:00',
    	timeFormat: 'H:i',
    	lang: {
				mins: 'minutter',
				hr: 'time',
				hrs: 'timer'
			}
    });
  
    // jQuery UI Sliders

    $(".ui-slider").each(function(index, elm) {
    	var $slider = $(elm);
    	var level = $slider.data('stress-level');
    	var $hidden = $('#stress_level_' + level);
    	//var $hidden = $slider.parent().next('input:hidden');

      $slider.slider({
        min: 1,
        max: 11,
        value: 0,
        orientation: "horizontal",
        range: "min",
	      slide: function( event, ui ) {
      		// store slider value
					$hidden.val(ui.value - 1);
	      }
      }).addSliderSegments($slider.slider("option").max);

      // set slider value
      var indexStart = parseInt($hidden.val());
      		indexStart = isNaN(indexStart) ? 0 : (indexStart + 1);
      		console.log($hidden);
			$slider.slider("value", indexStart);
  	 });
  });
  
})(jQuery);*/