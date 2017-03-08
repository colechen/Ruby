function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).parents("tr").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).parents("tr").after(content.replace(regexp, new_id));
  $(link).parents("tr").next().find(".rolepicker").on('change', update_userpicker);
}

function update_userpicker () {
  var role_id = $(this).val();
  var role_name = $(this).find('option:selected').text();
  var userpicker = $(this).parents("tr").find(".userpicker");
  userpicker.empty().append("<option/>");
  if (! role_id) { return; }
  $.ajax({
    type: "GET",
    url: "/projects/get_role_users",
    data: { id: role_id }
  }).done(function (data) {
    $.each(data, function (index, user) {
      userpicker.append($("<option></option>").attr("value", user.id).text(user.name));
    });
  }).fail(function (data) {
    alert("Cannot retrieve users for Role '" + role_name + "'.");
  });
}

$(document).on('turbolinks:load', function() {
  $(".rolepicker").on('change', update_userpicker);
});
