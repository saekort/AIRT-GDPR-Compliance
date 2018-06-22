# AIRT SQL scripts for GDPR compliance

These are a few SQL scripts we developed to make AIRT GDPR compliant, and thus able to delete personal info and old data regularly and automatically. Feel free to use them on your installation of AIRT, or to suggest improvements/bugs/etc.

Scripts are based on the original [AIRT code](http://airt.leune.com/).

## How to
Run `airt_update_cascade_delete.sql` once with CREATE CONSTRAINTS and DELETE CONSTRAINTS permissions. This script will add the ability to do proper CASCADE DELETEing on the AIRT database. More info, in the script itself.

Then run `airt_delete_old_incidents.sql` as often as you want (suggested: cron it) to delete all relevant data older than 2 years. The script needs DELETE permissions on the database. More info, in the script itself.

> **Note:** Depending on how many old incidents you have the `airt_delete_old_incidents.sql` script can run several minutes.

## TODO
Still dealing the `users` tables.
If we delete users, then what happens to all the `added_by` columns in other tables?
Delete users when NOT login =1, NOT a constituency_user AND NOT attached to a incident