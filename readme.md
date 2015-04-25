# Event Calendar - Phase 1

In this phase, we want to accomplish three objectives:

- Create the event resource
- Create the user resource
- Create a calendar display

We will take care of making these items work together in the next phase.

## Event and User Resources

As usual, we will use Rails scaffolding to create our resources.  We need
an event to have the following properties:

- name (string)
- start time & date (datetime)
- end time & date (datetime)
- location (string)

A user will have the following properties:

- name (string)
- email (string)

Creating these is simply a matter of doing what we have already seen, so
they should be pretty easy.

## Calendar Display

The first task we need to do in order to have a calendar display is to
edit our Gemfile to include the appropriate gem:

`gem "watu_table_builder", :require => "table_builder"`

After saving the Gemfile, update Bundler to make sure the gem is
installed:

`bundle update`

Next, we need to generate a controller that will house the calendar
processing and associated view.  For now, we simply need an index action
in the controller.

`rails g controller calendar index`

Next, we need to edit the index action of the CalendarController class
to make it grab all the events for use in the calendar display.  Even
though we will not make use of this feature yet, it is required to
display the calendar form in the view:

```
def index
  @events = Event.all
end
```

We also need to incorporate a routing configuration so we can view the
calendar: the most sensible thing to do is to set the index action for
the CalendarController class as the default home page.  We can edit the
config/routes.rb file to do so:

`root 'calendar#index'`

Finally, we need to edit the index.html.erb view for the
CalendarController to display the calendar.

The calendar is displayed through the addition of the a `calendar_for`
method that has been included as part of the newly installed calendar
gem.  Make sure you review the documentation for how to use this method
to generate an HTML table that displays a calendar.

We want this to display the current month and year across the top, as
well as contain links to the previous and next months:

```
<div id="calendar">
  <h2 id="month">
      <%= link_to "<", root_path(month: (@date.prev_month).strftime("%Y-%m-%d")) %>
    <%= @date.strftime("%b %Y") %>
    <%= link_to ">", root_path(month: (@date.next_month).strftime("%Y-%m-%d")) %>
  </h2>
  <%= calendar_for @events, year: @date.year, month: @date.month do |c| %>
    <%= c.head('Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat') %>
    <%= c.day do |day, events| %>
      <%= day.day %>
    <% end %>
  <% end %>
</div>
```

I have included some styling to make the calendar display look a little
nicer.  Feel free to modify the styling as desired: the stylesheets are
located in the app/assets/stylesheets directory under the appropriate
file names.
