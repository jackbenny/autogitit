autogitit
=========

autogitit is a small Bash script I wrote to automatically commit changes in a spcified direcory to git. Each time the script runs it checks if there is something new to commit or not. If the directory is clean the script will simply quit and do nothing.
The usage for it could be both as a kind of directory snapshot but also for your regular git repos so you don't forget to commit any changes. The downside if you use it your for regular git repos is that the commit messages will be marked with "autogitit on YYYY-MM-DD HH:MM:SS" and it won't push to remotes (as of right now anyway).

How to use it
-------------

First of all change the variable GITDIR in autogitit.sh to point to the directory that you want to auto commit to. It's between the START CONFIG and END CONFIG comments.
Next add an entry for autogitit.sh in your crontab, for example to run every five minutes. Below is an example of how to do it and what how the line will look like.

	$ crontab -e
	*/5 * * * * /home/user/autogitit.sh

If you want to initalize a directory for use with autogitit you can either do this by your self with a "git init" or by running the script with the --init option.

Contributing
------------

Any contributions are welcome since this is only half done, althouh it's working and should run out of the box on most Unix-like systems.
Add yourself to the THANKS file if you like to after contributing to the project.
