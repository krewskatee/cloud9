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
    },

    methods: {
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
         });
      },
      editToggle: function(comment) {
        comment.commentVisible = !comment.commentVisible;
      },

    },
    computed: {

    }
  });
});
