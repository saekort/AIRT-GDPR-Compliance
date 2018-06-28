# AIRT SQL scripts for GDPR compliance

These are a few SQL scripts we developed to make AIRT GDPR compliant, and thus able to delete personal info and old data regularly and automatically. Feel free to use them on your installation of AIRT, or to suggest improvements/bugs/etc.

Scripts are based on the original [AIRT code](http://airt.leune.com/).

## How to
Run `airt_update_cascade_delete.sql` once with CREATE CONSTRAINTS and DELETE CONSTRAINTS permissions. This script will add the ability to do proper CASCADE DELETEing on the AIRT database. More info, in the script itself.

Then run `airt_delete_old_incidents.sql` as often as you want (suggested: cron it) to delete all relevant data older than 2 years. The script needs DELETE permissions on the database. More info, in the script itself.

> **Note:** Depending on how many old incidents you have the `airt_delete_old_incidents.sql` script can run several minutes.

### A word on `users`
There are three tables: `users`, `user_capabilities` and `user_comments` which do contain personal data. The users include users that can login, but also all the contacts. The scripts do not automatically delete anything from these tables, and here is why.

We would want to delete when the following is true:
* The user NOT have login permissions in `user_capabilities`
* The user is NOT a constituency contact in `constituency_contacts`
* The user is NOT attached to an active incident in `incidents` and `incident_users`
* The user is older than 2 years

The problem is that the `users` table does not have an age for a user. If the script was to delete without that, it would delete any user that was created, but not yet assigned to any of the above. That seems too risky. Secondly AIRT has a lot of references to users in columns like `added_by` and `creator`. No idea what would happen if those referenced users were deleted. There are no constraints set on those, but you never know.

> **Advice:** Keep an eye on your users yourself. Anonimise those that you do not use.