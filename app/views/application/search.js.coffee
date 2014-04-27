humbnails = $("#humbnails")

<% unless @photos.nil? %>
<% @photos.each do |photo| %>
humbnails.prepend '<%=j render partial: "photo", object: photo %>'
<% end %>
<% end %>