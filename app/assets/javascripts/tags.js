$(document).on('page:change', function(){
  $("#js-tags").selectize({
    plugins: ['remove_button'],
    delimiter: ',',
    persist: false,
    openOnFocus: false,
    valueField: 'id',
    labelField: 'text',
    searchField: ['text'],
    options: [],

    onInitialize: function() {
      var existingOptions = JSON.parse(this.$input.attr('data-selectize-value'));
      var self = this;

      if(existingOptions) {
        existingOptions.forEach(function(option) {
          self.addOption(option);
          self.addItem(option[self.settings.valueField]);
        });
      }
    },

    load: function (query, callback) {
        if (!query.length) return callback();
        $.ajax({
            url: '/tags',
            dataType: 'json',
            data: {
              q: query
            },
            error: function () {
              callback();
            },
            success: function (res) {
              console.log(res);
              callback(res);
            }
        });
    },

    create: function (input, callback) {
      $.ajax({
          url: '/tags/new',
          data: { 'text': input },
          type: 'POST',
          dataType: 'json',
          success: function (response) {
              return callback(response);
          }
      });
    },

    render: {
        option: function (item, escape) {
          console.log(item);
          return '<div>' + escape(item.text) + '</div>';
        }
    }
  });
});
