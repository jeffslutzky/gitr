# class ActivityFeedViewObject
#
#
# 	def actor
# 		event.actor.login
# 	end
#
# 	def event_type
# 		event.type
# 	end
#
# 	def event_name
# 		event.repo.name
# 	end
#
# 	def date
# 		DateTime.parse(event.created_at).httpdate
# 	end
#
#
# <% @user_events_received.each do |event| %>
#           <div class="list-group-item">
#             by: <%= event.actor.login %>
#             <p><div class="pic-thumbnail">
#               <img src="<%= event.actor.avatar_url %>">
#             </div></p>
#             <p>Event type: <%= event.type %></p>
#             <p>Repo: <%= event.repo.name %></p>
#             <p><%= DateTime.parse(event.created_at).httpdate %></p>
#           </div>
#         <% end %>
#
#
# end
