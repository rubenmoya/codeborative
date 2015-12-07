$(document).on('page:change', function(){
  $("#js-skills").selectize({
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

      if(Object.prototype.toString.call(existingOptions) === "[object Array]") {
          existingOptions.forEach(function (option) {
            self.addOption(option);
            self.addItem(option[self.settings.valueField]);
          });
      }
      else if (typeof existingOptions === 'object') {
          self.addOption(existingOptions);
          self.addItem(existingOptions[self.settings.valueField]);
      }
    },
    create: function (input, callback) {
        $.ajax({
            url: '/skills/new',
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
    },
    load: function (query, callback) {
        if (!query.length) return callback();
        $.ajax({
            url: '/skills',
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
  });
});
