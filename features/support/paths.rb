# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
      when /^the users page$/
        '/users'

      when /^the home\s?page$/
        root_path

      when /^the signup page$/
        new_user_registration_path

      when /^the login page$/
        new_user_session_path

      when /^the new shift page for the "(.*)" event$/
        event = Event.find_by event_name: $1
        new_event_shift_path event

      when /^the page for the "(.*)" shift for the "(.*)" event$/
         event = Event.find_by event_name: $2
        event_shift_path event, Shift.find_by(role: $1, event: event)

      when /^the edit page for the "(.*)" shift for the "(.*)" event$/
        event = Event.find_by event_name: $2
        edit_event_shift_path event, Shift.find_by(role: $1, event: event)

      when /^the page for the "(.*)" event$/
        event_path Event.find_by event_name: $1

      when /^the edit page for the "(.*)" event$/
        edit_event_path Event.find_by event_name: $1

      else
        begin
          page_name =~ /^the (.*) page$/
          path_components = $1.split(/\s+/)
          self.send(path_components.push('path').join('_').to_sym)
        rescue NoMethodError, ArgumentError
          raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
                    "Now, go and add a mapping in #{__FILE__}"
        end
    end
  end
end

World(NavigationHelpers)
