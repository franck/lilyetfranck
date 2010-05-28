/* Extend jQuery with functions for PUT and DELETE requests. 

$.delete_(link.attr('href'), $(this).serialize(), function(data){$(".loader").hide();}, "script");
$.get(link.attr('href'), $(this).serialize(), function(data){}, "script");

// Ajaxify form with class 'ajax_form'. Show .loader during processing
var options = {
  beforeSubmit:  showLoader, 
  success:       hideLoader,
  dataType: 'script', // to user create.js.erb
  resetForm: true
};
$('.ajax_form').ajaxForm(options);
function showLoader(formData, jqForm, options){ $(".loader").show(); return true; }
function hideLoader(){ $(".loader").hide(); return true }

*/

function _ajax_request(url, data, callback, type, method) {
    if (jQuery.isFunction(data)) {
        callback = data;
        data = {};
    }
    return jQuery.ajax({
        type: method,
        url: url,
        data: data,
        success: callback,
        dataType: type
        });
}

jQuery.extend({
    put: function(url, data, callback, type) {
        return _ajax_request(url, data, callback, type, 'PUT');
    },
    delete_: function(url, data, callback, type) {
        return _ajax_request(url, data, callback, type, 'DELETE');
    }
});

$(function(){
  jQuery.ajaxSetup({
    'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
  });
});