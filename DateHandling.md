
## Handling Dates and Meeting times

The task is to select a date and initialize meeting dates for two timezones. Once that is done,
while selecting meeting time accomodating both the timezones. Steps below outline how to do that in Swift.

* Select a date from UIDatePicker (The selected date from datepicker comes with a random time)
* Once two timezones are selected, 
    * Assign selected date and time to one of the timezone
    * Calculate time difference in seconds between the assigned timezone and the remaining timezone
    * Add the time interval to the selected date and assign it to the second timezone
* Once these above steps are done, Changing the meeting time in seconds should be updated(add/subtract) in each of the Date objects which will automatically handle wrapping to next/previous date