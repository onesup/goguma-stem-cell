//= require jquery.scrollTo
//= require jquery.validate
// cleditor requires jquery-browser
// https://groups.google.com/forum/?fromgroups=#!topic/cleditor/5Vn4YDaQx08
//= require jquery.browser
// require jquery.cleditor

//= require callback
//= require pagination
SocialStream.Conversation = (function(SS, $, undefined) {
  var callback = new SS.Callback();

  var initPagination = function() {
    SS.Pagination.show();
  };

  callback.register('index', initPagination);

  return callback.extend({
  });
})(SocialStream, jQuery);
