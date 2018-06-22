/**
	AIRT does not have ON DELETE CASCADE set up to support
	proper cascading delete in the database this script will
	drop and recreate any constraints that need a cascading delete.

	You only have to run this SQL script ONCE.

	If you have edited the table constraints yourself in the past,
	you might need to tweak the script.
	
	The script changes the following constraints:
	- external_incidentids 	-	external_incidentids_incidentid_fkey
	- incident_addresses 	-	incident_addresses_incident_fkey
	- incident_attachments 	-	incident_attachments_incident_fkey
	- incident_comments  	-	incident_comments_incident_fkey
	- incident_mail 	 	-	incident_mail_incidentid_fkey
	- incident_users 		-	incident_users_incidentid_fkey
	- user_capabilities		-	user_capabilities_userid_fkey
	- user_comments			-	

	Note that the mailbox and users tables cannot get by with just a
	ON CASCADE DELETE. Hence, no constraints are changed on those.

	@src https://github.com/saekort/AIRT-GDPR-Compliance
	@author Simon Kort
*/

-- DROP and RECREATE external_incidentids_incidentid_fkey
ALTER TABLE public.external_incidentids
DROP CONSTRAINT external_incidentids_incidentid_fkey;

ALTER TABLE public.external_incidentids
ADD CONSTRAINT external_incidentids_incidentid_fkey FOREIGN KEY (incidentid)
	REFERENCES public.incidents (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE CASCADE;

-- DROP and RECREATE incident_attachments_incident_fkey
ALTER TABLE public.incident_attachments
DROP CONSTRAINT incident_attachments_incident_fkey;

ALTER TABLE public.incident_attachments
ADD CONSTRAINT incident_attachments_incident_fkey FOREIGN KEY (incident)
	REFERENCES public.incidents (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE CASCADE;

-- DROP and RECREATE incident_addresses_incident_fkey
ALTER TABLE public.incident_addresses
DROP CONSTRAINT incident_addresses_incident_fkey;

ALTER TABLE public.incident_addresses
ADD CONSTRAINT incident_addresses_incident_fkey FOREIGN KEY (incident)
	REFERENCES public.incidents (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE CASCADE;

-- DROP and RECREATE incident_comments_incident_fkey
ALTER TABLE public.incident_comments
DROP CONSTRAINT incident_comments_incident_fkey;

ALTER TABLE public.incident_comments
ADD CONSTRAINT incident_comments_incident_fkey FOREIGN KEY (incident)
	REFERENCES public.incidents (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;

-- DROP and RECREATE incident_mail_incidentid_fkey
ALTER TABLE public.incident_mail
DROP CONSTRAINT incident_mail_incidentid_fkey;

ALTER TABLE public.incident_mail
ADD CONSTRAINT incident_mail_incidentid_fkey FOREIGN KEY (incidentid)
	REFERENCES public.incidents (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE CASCADE;

-- DROP and RECREATE incident_users_incidentid_fkey
ALTER TABLE public.incident_users
DROP CONSTRAINT incident_users_incidentid_fkey;

ALTER TABLE public.incident_users
ADD CONSTRAINT incident_users_incidentid_fkey FOREIGN KEY (incidentid)
	REFERENCES public.incidents (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE CASCADE;

-- DROP and RECREATE user_capabilities_userid_fkey
ALTER TABLE public.user_capabilities
DROP CONSTRAINT user_capabilities_userid_fkey;

ALTER TABLE public.user_capabilities
ADD CONSTRAINT user_capabilities_userid_fkey FOREIGN KEY (userid)
	REFERENCES public.users (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE CASCADE;

	-- DROP and RECREATE incident_users_incidentid_fkey
ALTER TABLE public.user_capabilities
DROP CONSTRAINT user_capabilities_userid_fkey;

ALTER TABLE public.user_capabilities
ADD CONSTRAINT user_capabilities_userid_fkey FOREIGN KEY (userid)
	REFERENCES public.users (id) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE CASCADE;