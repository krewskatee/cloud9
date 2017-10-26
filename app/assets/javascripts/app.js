document.addEventListener("DOMContentLoaded", function(event) {
  var app = new Vue({
    el: '#app',
    data: {
      post_comments: [],
      comments: [],
      content: "",
      errors: []
    },
    mounted: function() {
      $.get(`/api/v1/post/${gon.post_id}.json`, function(data) {
        this.post_comments = data['comments'];
      }.bind(this));

      $.get(`/api/v1/comment.json`, function(data) {
        this.comments = data;
      }.bind(this));
    },
    methods: {
      addComment: function() {
        var newComment = {
            content: this.content,
            post_id: gon.post_id,
            user_id: gon.current_user_id
          };
          $.post('/api/v1/comment.json', newComment, function(newComment) {
           this.comments.push(newComment);
           this.post_comments.push(newComment);
           this.content = "";
          }.bind(this)).fail(function(response) {
           console.log("fail")
          }.bind(this));
      },
      editToggle: function($event) {
        var targetParent = $($event.target).parent()
        if($($event.target).text() === "Cancel") {
          $($event.target).text("Edit")
        } else {
          $($event.target).text("Cancel")
        }
        targetParent.closest("div").prev(".comment-content").toggle();
        targetParent.closest("div").prev(".comment-delete").fadeToggle();
        $($event.target).closest("div").next(".edit").fadeToggle();
      }
    },
    computed: {

    }
  });
});
