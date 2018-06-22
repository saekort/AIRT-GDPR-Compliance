/**
	Run this script in a cronjob/scheduled task or by hand. It will
	delete any incidents, and related data, older then 2 years.

	The script will remove all data pointing at an incident. It will
	also empty the mailbox and users tables, because these contain
	personal info.
	
	Note that you need to run airt_update_cascade_delete.sql once before
	you run this script or you will run into FK constraint errors.

	The script deletes from the following tables:
	- incidents - Any incident older than 2 years, based on the updated column.
				  This will cascade to the following tables:
					- external_incidentids
					- incident_addresses
					- incident_attachments
					- incident_comments
					- incident_mail
					- incident_users
	- mailbox - Any mail older than 2 years AND not attached to incidents
	- import_queue - Anything older than 2 years
	- users - Anyone that does NOT have login privileges AND is NOT attached
			  attached to any constituencies as contact AND is NOT attached
			  to any incidents.
			  This will cascade to the following tables:
			  	- user_comments
			  	- user_capabilities

	@src https://github.com/saekort/AIRT-GDPR-Compliance
	@author Simon Kort
*/

-- DELETE all incidents (and related data) that has not been updated in the last 2 years
DELETE FROM public.incidents
WHERE public.incidents.updated < CURRENT_TIMESTAMP - (2 * interval '1 year');

-- Now to deal with the mailbox table, ON DELETE CASCADE does not work on that one
-- Delete all mail that is no longer referenced by an incident and older then 2 years
DELETE FROM public.mailbox
USING public.mailbox as mail
LEFT OUTER JOIN public.incident_mail AS incident_mail ON mail.id = incident_mail.messageid
WHERE public.mailbox.id = mail.id
AND CAST(mail.date AS INT) < (CAST(EXTRACT(epoch FROM NOW()) AS INT) - 63113852)
AND incident_mail.id IS NULL;

-- DELETE all import_queue that has not been updated in the last 2 years
-- Let's face it, if you need longer then 2 years to process it...
DELETE FROM public.import_queue
WHERE public.import_queue.updated < CURRENT_TIMESTAMP - (2 * interval '1 year');

-- TODO: Deal with users