document.addEventListener("DOMContentLoaded", function(event) {
  var app = new Vue({
    el: '#app',
    data: {
      post_comments: [],
      content: "",
      errors: [],
      current_user_id: gon.current_user_id
    },
    mounted: function() {
      $.get(`/api/v1/post/${gon.post_id}.json`, function(data) {
        this.post_comments = data.comments;
      }.bind(this));
      $('#scroll-container').scrollTop($('#scroll-container')[0].scrollHeight);
      $(".message-input").keydown(function (e) {
        if (e.keyCode == 13) {
          $("#scroll-container").stop().animate({ scrollTop: $("#scroll-container")[0].scrollHeight}, 1000);
          $( ".chat-submit" ).trigger( "click" );
          e.target.value = "";
          e.preventDefault();
        }
      });
      $(".chat-submit").click(function (e){
        $('#scroll-container').scrollTop($('#scroll-container')[0].scrollHeight);
      });
      $('.message-input').focus();
    },

    methods: {
      scroll_top: function(){
       $('#scroll-container').scrollTop($('#scroll-container')[0].scrollHeight);
      },
      updateComment: function(comment, comment_content) {
        $.ajax({
          url: `/api/v1/comment/${comment.id}.json`,
          type: 'PATCH',
          data: JSON.stringify({ content: $('#text-area').val(), _method:'patch' }),
          contentType: 'application/json',
          success: function(result) {
            this.post_comments = result;
          }.bind(this)
        }).fail(function(response) {
          console.log('fail')
          $('.error-wrapper').fadeOut(6000);
           this.errors = (response.responseJSON.errors);
          }.bind(this));
      },
      deleteComment: function(comment) {
        $.ajax({
          url: `/api/v1/comment/${comment.id}.json`,
          type: 'DELETE',
          contentType: 'application/json',
          success: function(result) {
            console.log(result)
            this.post_comments = result;
            location.reload();
          }.bind(this)
        });
      },
      addComment: function() {
        var newComment = {
            content: this.content,
            post_id: gon.post_id,
            user_id: gon.current_user_id
          };
          $.post('/api/v1/comment.json', newComment, function(newComment) {
           this.post_comments.push(newComment);
           this.content = "";
          }.bind(this)).fail(function(response) {
            $('.error-wrapper').fadeOut(6000);
           this.errors = (response.responseJSON.errors);
         }.bind(this)).success(function() {
            console.log("success")
            $('.comment-content').fadeIn(1000);
         });
      },
      editToggle: function(comment) {
        comment.commentVisible = !comment.commentVisible;
      },
      addFriendToggle: function() {
        $('#friends-form').fadeToggle();
        $('.fa-friend-minus').fadeIn();
        $('.fa-friend-plus').hide();
      },

      addToggle: function() {
        $('#friends-form').fadeToggle();
        $('.fa-friend-minus').hide();
        $('.fa-friend-plus').fadeIn();
      },
      chatFormShow: function() {
        $('.add-chat').fadeToggle();
        $('.chat-form-minus').fadeIn();
        $('.chat-form-plus').hide();
      },
      chatFormHide: function() {
        $('.add-chat').fadeToggle();
        $('.chat-form-minus').hide();
        $('.chat-form-plus').fadeIn();
      },
      addPeopleChatFormShow: function() {
        $('.add-form').fadeToggle();
        $('.add-people-minus').fadeIn();
        $('.add-people-plus').hide();
      },
      removePeopleChatFormHide: function() {
        $('.add-form').fadeToggle();
        $('.add-people-minus').hide();
        $('.add-people-plus').fadeIn();
      },
    },
    computed: {

    },

  });
});
