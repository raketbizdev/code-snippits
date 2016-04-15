# Assorted Snippits

**Hack any paid WiFi hotspot in about 30 seconds**
```
ifconfig en1 | grep ether
arp -a
sudo ifconfig en1 ether [mac address to spoof]
```

# Git Command

* `git init` creates a new Git repository
* `git status` inspects the contents of the working directory and staging area
* `git add` adds files from the working directory to the staging area
* `git diff` shows the difference between the working directory and the staging area
* `git commit` permanently stores file changes from the staging area in the repository
* `git log` shows a list of all previous commits
* `git reset --hard` Revert changes to modified files.
* `git clean -fd` Remove all untracked files and directories.
* `git checkout -b topic-branch` # To create New Branch
* `git branch` # To check branch which you are in
* `git checkout master` # To return to master branch or change another branch

# Create Multiple Skype in Mac

* Open Terminal
* type this in terminal ```$ sudo /Applications/Skype.app/Contents/MacOS/Skype /secondary```

# Compress image on wordpress via functions

* Open function.php
* add this code ```add_filter( 'jpeg_quality', create_function( '', 'return 80;' ) );```

# Here are all the Rails 4 (ActiveRecord migration) datatypes:
```
  :binary
  :boolean
  :date
  :datetime
  :decimal
  :float
  :integer
  :primary_key
  :references
  :string
  :text
  :time
  :timestamp
```

# Date and time Format meaning

* `%a` - The abbreviated weekday name (“Sun”)
* `%A` - The full weekday name (“Sunday”)
* `%b` - The abbreviated month name (“Jan”)
* `%B` - The full month name (“January”)
* `%c` - The preferred local date and time representation
* `%d` - Day of the month (01..31)
* `%H` - Hour of the day, 24-hour clock (00..23)
* `%I` - Hour of the day, 12-hour clock (01..12)
* `%j` - Day of the year (001..366)
* `%m` - Month of the year (01..12)
* `%M` - Minute of the hour (00..59)
* `%p` - Meridian indicator (“AM” or “PM”)
* `%S` - Second of the minute (00..60)
* `%U` - Week number of the current year, starting with the first Sunday as the first day of the first week (00..53)
* `%W` - Week number of the current year, starting with the first Monday as the firstday of the first week (00..53)
* `%w` - Day of the week (Sunday is 0, 0..6)
* `%x` - Preferred representation for the date alone, no time
* `%X` - Preferred representation for the time alone, no date
* `%y` - Year without a century (00..99)
* `%Y` - Year with century
* `%Z` - Time zone name
* `%%` - Literal “%” character
* `%e` - Day of the month, without leading zero (1..31)
* `%-I %-d` - You can remove leading Zeros this way as well. By just adding a - symbol.

# Outpting any files using only terminal 

eg: JSON to CSV

`curl -u 60783dd23ef:X https://your-domain.com/v1/filename.json -O`
or 
`curl -u 60783dd23ef:X https://your-domain.com/v1/filename.json -o mailbox.csv`

# downloading lots of files via terminal
`for((i=1;i<=8;i++)); do curl -u xxxxxx:pass //your-domain.com/v1/filename.json?page=$i -o mailboxes-28303-conversations-page-$i.json; done`

# FQL facebook search by group name

```sql
SELECT gid, name, privacy, website, email
FROM   group
WHERE  CONTAINS("jobs")
AND    strpos(lower(name),lower("jobs")) >=0
```

# Facebook FQL Operator

```
me()
now()
rand()
strlen(...)
concat(...)
substr(...)
strpos(...)
lower(...)
upper(...)
contains(...)
order by
SELECT, WHERE
AND, OR, NOT, IN, ><=, +-*/  
```
